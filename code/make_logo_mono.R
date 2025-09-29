# code/make_logo_mono.R
# Monochrome Bayes Logo (SVG + PNG) — background transparent
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(glue)
  library(svglite) # SVG export
})

# -- Curves (prior, likelihood, posterior) --
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
  prior <- dnorm(x, mu_prior, sd_prior)
  like <- dnorm(x, mu_like, sd_like)
  prec_post <- 1 / sd_prior^2 + 1 / sd_like^2
  mu_post <- (mu_prior / sd_prior^2 + mu_like / sd_like^2) / prec_post
  sd_post <- sqrt(1 / prec_post)
  post <- dnorm(x, mu_post, sd_post)
  data.frame(x, prior, like, post, mu_post = mu_post, sd_post = sd_post)
}

# -- Plot builder (monochrome) --
build_logo_plot_mono <- function(
  fg = "#111111",
  stroke = 1.4,
  fill_alpha = 0.14,
  show_dot = TRUE,
  xlim = c(-3.2, 3.2)
) {
  dat <- make_curves()
  ggplot(dat, aes(x = x)) +
    # shaded posterior (same color, translucent)
    geom_ribbon(aes(ymin = 0, ymax = post), fill = fg, alpha = fill_alpha) +
    # curves (all same color)
    geom_line(
      aes(y = prior),
      linewidth = stroke,
      color = fg,
      lineend = "round"
    ) +
    geom_line(
      aes(y = like),
      linewidth = stroke,
      color = fg,
      lineend = "round"
    ) +
    geom_line(
      aes(y = post),
      linewidth = stroke,
      color = fg,
      lineend = "round"
    ) +
    # posterior mean dot (optional)
    {
      if (show_dot)
        geom_point(
          data = unique(dat[c("mu_post", "sd_post")]),
          aes(x = mu_post, y = dnorm(mu_post, mu_post, sd_post)),
          color = fg,
          size = 2.2
        ) else NULL
    } +
    coord_cartesian(
      xlim = xlim,
      ylim = c(0, max(dat$post) * 1.1),
      expand = FALSE
    ) +
    theme_void() +
    theme(plot.margin = margin(8, 8, 8, 8))
}

# -- Exporter --
export_logo_mono <- function(
  out_dir = "static",
  base_name = "bayes-logo-mono",
  fg = "#111111",
  stroke = 1.4,
  fill_alpha = 0.14,
  png_sizes = c(512, 192, 32)
) {
  if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
  p <- build_logo_plot_mono(fg = fg, stroke = stroke, fill_alpha = fill_alpha)

  # SVG (vector, transparent)
  svg_path <- file.path(out_dir, glue("{base_name}.svg"))
  svglite::svglite(svg_path, width = 5, height = 5, bg = "transparent")
  print(p)
  dev.off()

  # PNG variants (transparent)
  if (!requireNamespace("ragg", quietly = TRUE)) {
    stop(
      "Package 'ragg' is required for PNG export. Install with: install.packages('ragg')"
    )
  }
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
    "Exported:\n- ",
    svg_path,
    "\n- ",
    paste(
      file.path(out_dir, glue("{base_name}-{png_sizes}.png")),
      collapse = "\n- "
    )
  )
}

# -- One-liners to produce light/dark variants when run as a script --
if (identical(environment(), globalenv())) {
  # Light theme asset: dark foreground on transparent bg
  export_logo_mono(
    out_dir = "static",
    base_name = "bayes-logo-mono-darkfg",
    fg = "#111111"
  )

  # Dark theme asset: light foreground on transparent bg
  export_logo_mono(
    out_dir = "static",
    base_name = "bayes-logo-mono-lightfg",
    fg = "#ffffff"
  )
}
