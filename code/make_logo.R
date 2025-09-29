# code/make_logo.R
# Programmatic Bayes Logo for Quarto Book
# Corrado-ready: no external fonts, deterministic output, SVG + PNG variants

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(glue)
  library(readr) # only for write_lines (base::writeLines is fine too)
  library(svglite) # for SVG export
})

# ---- 1) Helper: generate curves (prior, likelihood, posterior) ----
make_curves <- function(
  x_min = -4,
  x_max = 4,
  n = 2000,
  mu_prior = -0.8,
  sd_prior = 1.0,
  mu_like = 0.8,
  sd_like = 0.6
) {
  x <- seq(x_min, x_max, length.out = n)
  prior <- dnorm(x, mean = mu_prior, sd = sd_prior)
  like <- dnorm(x, mean = mu_like, sd = sd_like)

  # Posterior (conjugate Normal-Normal; up to a proportional constant)
  # Using product of Gaussians: posterior is Gaussian with:
  prec_post <- 1 / sd_prior^2 + 1 / sd_like^2
  mu_post <- (mu_prior / sd_prior^2 + mu_like / sd_like^2) / prec_post
  sd_post <- sqrt(1 / prec_post)
  post <- dnorm(x, mean = mu_post, sd = sd_post)

  tibble(x, prior, like, post, mu_post, sd_post)
}

# ---- 2) Main plot generator ----
build_logo_plot <- function(
  title = NULL, # e.g., "Metodi Bayesiani in Psicologia"
  subtitle = NULL, # e.g., "Quarto Companion"
  # palette = c(
  #   bg = "#0b1021",
  #   prior = "#94a3b8",
  #   like = "#22c55e",
  #   post = "#f59e0b",
  #   shade = "#f59e0b"
  # ),
  palette = c(
    bg = "#ffffff",
    prior = "#475569",
    like = "#0ea5e9",
    post = "#ef4444",
    shade = "#ef4444"
  ),

  stroke = 1.2,
  text_color = "white"
) {
  dat <- make_curves()
  # Area under posterior for a clean “Bayes feel”
  shade <- dat %>% filter(x >= min(x), x <= max(x))

  ggplot() +
    # Background
    geom_rect(
      aes(xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf),
      fill = palette["bg"],
      color = NA
    ) +

    # Shaded posterior area
    geom_ribbon(
      data = shade,
      aes(x = x, ymin = 0, ymax = post),
      fill = palette["shade"],
      alpha = 0.18
    ) +

    # Curves
    geom_line(
      data = dat,
      aes(x, prior),
      linewidth = stroke,
      color = palette["prior"]
    ) +
    geom_line(
      data = dat,
      aes(x, like),
      linewidth = stroke,
      color = palette["like"]
    ) +
    geom_line(
      data = dat,
      aes(x, post),
      linewidth = stroke,
      color = palette["post"]
    ) +

    # A subtle center dot at posterior mean
    geom_point(
      data = distinct(dat, mu_post, sd_post),
      aes(x = mu_post, y = dnorm(mu_post, mu_post, sd_post)),
      size = 2.2,
      color = palette["post"]
    ) +

    # Optional title/subtitle (kept small to remain icon-friendly)
    {
      if (!is.null(title)) {
        list(
          annotate(
            "text",
            x = Inf,
            y = Inf,
            hjust = 1.05,
            vjust = 1.8,
            label = title,
            color = text_color,
            size = 4,
            fontface = "bold"
          ),
          if (!is.null(subtitle))
            annotate(
              "text",
              x = Inf,
              y = Inf,
              hjust = 1.05,
              vjust = 0.9,
              label = subtitle,
              color = text_color,
              size = 3
            )
        )
      } else {
        list()
      }
    } +

    # Minimal theme and square aspect
    coord_cartesian(
      xlim = c(-3.2, 3.2),
      ylim = c(0, max(dat$post) * 1.1),
      expand = FALSE
    ) +
    theme_void() +
    theme(plot.margin = margin(8, 8, 8, 8))
}

# ---- 3) Exporter ----
export_logo <- function(
  out_dir = "static", # typical Quarto dir for assets
  base_name = "bayes-logo", # will produce bayes-logo.svg, bayes-logo-512.png, ...
  title = NULL,
  subtitle = NULL,
  palette = c(
    bg = "#0b1021",
    prior = "#94a3b8",
    like = "#22c55e",
    post = "#f59e0b",
    shade = "#f59e0b"
  ),
  stroke = 1.2,
  seed = 42
) {
  set.seed(seed)
  if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

  p <- build_logo_plot(
    title = title,
    subtitle = subtitle,
    palette = palette,
    stroke = stroke
  )

  # SVG (vector)
  svg_path <- file.path(out_dir, glue("{base_name}.svg"))
  svglite::svglite(svg_path, width = 5, height = 5, bg = "transparent")
  print(p)
  dev.off()

  # PNG variants (transparent)
  png_sizes <- c(512, 192, 32)
  for (s in png_sizes) {
    png_path <- file.path(out_dir, glue("{base_name}-{s}.png"))
    ragg::agg_png(
      png_path,
      width = s,
      height = s,
      units = "px",
      background = "transparent",
      res = 144
    )
    print(p)
    dev.off()
  }

  message(
    "Exported:\n  - ",
    svg_path,
    "\n  - ",
    file.path(out_dir, glue("{base_name}-512.png")),
    "\n  - ",
    file.path(out_dir, glue("{base_name}-192.png")),
    "\n  - ",
    file.path(out_dir, glue("{base_name}-32.png"))
  )
}

# ---- 4) User-facing wrapper (one-liner) ----
# Customize colors here if you like. The defaults are dark background,
# slate prior, green likelihood, amber posterior.
make_bayes_logo <- function(
  out_dir = "static",
  base_name = "bayes-logo",
  title = NULL,
  subtitle = NULL
) {
  # Requires ragg for high-quality PNG; install if missing
  if (!requireNamespace("ragg", quietly = TRUE)) {
    stop(
      "Package 'ragg' is required for PNG export. Install with: install.packages('ragg')"
    )
  }
  export_logo(
    out_dir = out_dir,
    base_name = base_name,
    title = title,
    subtitle = subtitle
  )
}

# ---- 5) When sourced/ran as a script, build defaults ----
if (identical(environment(), globalenv())) {
  # Example usage: comment/uncomment as needed
  make_bayes_logo(
    out_dir = "static",
    base_name = "bayes-logo",
    title = "Metodi bayesiani in psicologia",
    subtitle = "Companion"
  )
}
