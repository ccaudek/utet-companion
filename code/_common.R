# _common.R — caricato automaticamente da ogni .qmd
# Versione allineata a Cosmo + $primary: #39729E

suppressPackageStartupMessages({
  library(here)
  library(rio)
  library(tidyr)
  library(dplyr)
  library(tibble)
  library(modelr)
  library(matrixStats)
  library(janitor)
  library(conflicted)
  library(sessioninfo)
  library(brms)
  library(rstan)
  library(loo)
  library(posterior)
  library(priorsense)
  library(reliabilitydiag)
  library(ggplot2)
  library(bayesplot)
  library(tidybayes)
  library(ggdist)
  library(patchwork)
  library(systemfonts)
  library(withr)
  library(tinytable)
  library(ragg) # dev = "ragg_png"
})

set.seed(1234)
RNGkind(kind = "Mersenne-Twister", normal.kind = "Inversion")
if (exists(".Random.seed", .GlobalEnv, inherits = FALSE))
  invisible(.Random.seed)

# Conflitti
conflict_prefer("var", "stats")
conflict_prefer("sd", "stats")
conflict_prefer("filter", "dplyr")
conflict_prefer("select", "dplyr")
conflict_prefer("chisq.test", "stats")
conflict_prefer("mad", "posterior")
conflict_prefer("rhat", "posterior")
conflict_prefer("ess_bulk", "posterior")
conflict_prefer("ess_tail", "posterior")
conflict_prefer("theme_void", "ggplot2")

options(
  brms.backend = "cmdstanr",
  mc.cores = max(1L, parallel::detectCores(logical = FALSE)),
  pillar.bold = TRUE,
  pillar.subtle = FALSE,
  pillar.width = Inf,
  width = 80,
  scipen = 4,
  digits = 3,
  show.signif.stars = FALSE
)
rstan::rstan_options(auto_write = TRUE)

# --------- Palette coerente con SCSS ---------
PRIMARY <- "#39729E" # $primary nello SCSS
TEXT_DARK <- "#1b1f23"
TEXT_MED <- "#2b3137"
TEXT_LIGHT <- "#6C6C6C" # usato anche in .quarto-section-identifier
BORDER <- "#e1e4e8"
GRID <- "#f1f3f5"

modern_palette <- list(
  white = "#ffffff",
  off_white = "#fafafa",
  text_dark = TEXT_DARK,
  text_medium = TEXT_MED,
  text_light = TEXT_LIGHT,
  black = "#111111",
  grey1 = "#222222",
  grey2 = "#444444",
  grey3 = "#666666",
  grey4 = "#888888",
  grey5 = "#aaaaaa",
  grey6 = "#cccccc",
  border = BORDER,
  grid = GRID,
  accent = PRIMARY,
  blue = PRIMARY, # alias legacy "blue" = primary
  red = "#b25252" # rosso smorzato per warning/divergenze
)

# palette discreta in scala di grigi (per più serie); si evidenzia con scale_*_accent()
palette_discrete <- c(
  modern_palette$grey1,
  modern_palette$grey2,
  modern_palette$grey3,
  modern_palette$grey4,
  modern_palette$grey5,
  modern_palette$grey6
)

# -------- Font di sistema (sans moderni) --------
locate_sans_family <- function() {
  prefer <- c(
    "Inter",
    "Source Sans 3",
    "Source Sans Pro",
    "Roboto",
    "Helvetica Neue",
    "Segoe UI",
    "Arial"
  )
  fams <- unique(systemfonts::system_fonts()$family)
  hit <- Filter(
    function(p) any(grepl(paste0("^", p, "$"), fams, ignore.case = TRUE)),
    prefer
  )
  if (length(hit)) return(hit[[1]])
  "Helvetica Neue"
}
modern_sans <- locate_sans_family()
message("Font sans-serif per i grafici: ", modern_sans)

# -------- Tema ggplot/bayesplot --------
apply_visual_theme <- function(base_size = 15) {
  # base: tema bayesplot "di fabbrica"
  base <- bayesplot::theme_default(
    base_family = modern_sans,
    base_size = base_size
  )

  # Applico senza alterare lo "stile bayesplot", ma:
  # - pannello bianco (per stampa e coerenza col libro)
  # - plot background trasparente (utile in HTML/PNG sopra sfondo pagina)
  # - griglia sottile e neutra
  # - spacing migliorato tra titolo e sottotitolo
  ggplot2::theme_set(
    base %+replace%
      ggplot2::theme(
        panel.background = ggplot2::element_rect(fill = "white", colour = NA),
        plot.background = ggplot2::element_rect(
          fill = "transparent",
          colour = NA
        ),
        legend.background = ggplot2::element_rect(
          fill = "transparent",
          colour = NA
        ),
        panel.grid.major = ggplot2::element_line(
          colour = "#eaeaea",
          linewidth = 0.4
        ),
        panel.grid.minor = ggplot2::element_line(
          colour = "#f3f3f3",
          linewidth = 0.2
        ),
        axis.title = ggplot2::element_text(colour = modern_palette$text_medium),
        axis.text = ggplot2::element_text(colour = modern_palette$text_dark),
        strip.background = ggplot2::element_rect(
          fill = "white",
          colour = modern_palette$border
        ),
        strip.text = ggplot2::element_text(
          face = "bold",
          colour = modern_palette$text_medium
        ),
        plot.title = ggplot2::element_text(
          face = "bold",
          colour = modern_palette$text_dark,
          margin = ggplot2::margin(b = 8) # spazio sotto il titolo
        ),
        plot.subtitle = ggplot2::element_text(
          colour = modern_palette$text_medium,
          size = ggplot2::rel(0.88), # leggermente più piccolo del titolo
          margin = ggplot2::margin(b = 10) # spazio sotto il sottotitolo
        ),
        plot.caption = ggplot2::element_text(
          colour = modern_palette$text_light,
          hjust = 0, # allineamento a sinistra per le caption
          margin = ggplot2::margin(t = 10) # spazio sopra la caption
        ),
        # Margini generali del plot più ariosi
        plot.margin = ggplot2::margin(12, 12, 12, 12)
      )
  )

  # Tema bayesplot coerente per i panel diagnostici
  bayesplot::bayesplot_theme_set(
    bayesplot::theme_default(
      base_family = modern_sans,
      base_size = base_size + 1
    )
  )

  # Schema colore bayesplot "blue" (default e stabile)
  if (!identical(bayesplot::color_scheme_get(), "blue"))
    bayesplot::color_scheme_set("blue")

  invisible(TRUE)
}
apply_visual_theme()

# Propaga la famiglia sans su tutto (senza toccare lo stile bayesplot)
ggplot2::theme_update(
  text = ggplot2::element_text(family = modern_sans),
  axis.title = ggplot2::element_text(family = modern_sans),
  axis.text = ggplot2::element_text(family = modern_sans),
  strip.text = ggplot2::element_text(family = modern_sans, face = "bold"),
  plot.title = ggplot2::element_text(family = modern_sans, face = "bold"),
  legend.text = ggplot2::element_text(family = modern_sans),
  legend.title = ggplot2::element_text(family = modern_sans, face = "bold")
)

# -------- Scale helper coerenti --------
scale_color_modern <- function(..., na.value = "#CCCCCC", drop = FALSE)
  scale_color_manual(
    values = palette_discrete,
    ...,
    na.value = na.value,
    drop = drop
  )
scale_fill_modern <- function(..., na.value = "#CCCCCC", drop = FALSE)
  scale_fill_manual(
    values = palette_discrete,
    ...,
    na.value = na.value,
    drop = drop
  )

scale_color_viridis_modern <- function(...)
  scale_color_viridis_c(option = "plasma", ...)
scale_fill_viridis_modern <- function(...)
  scale_fill_viridis_c(option = "plasma", ...)

scale_color_divergent <- function(...)
  scale_color_gradient2(
    low = modern_palette$grey5,
    mid = "#f7f7f7",
    high = modern_palette$grey1,
    midpoint = 0,
    ...
  )
scale_fill_divergent <- function(...)
  scale_fill_gradient2(
    low = modern_palette$grey5,
    mid = "#f7f7f7",
    high = modern_palette$grey1,
    midpoint = 0,
    ...
  )

# Accento (UNA serie, intervalli di confidenza o evidenziazioni)
scale_color_accent <- function(...)
  scale_color_manual(values = c(modern_palette$accent), ...)
scale_fill_accent <- function(...)
  scale_fill_manual(values = c(modern_palette$accent), ...)

# Variante: primario + grigi (utile per linee multiple con focus sulla prima)
scale_color_primary_then_grey <- function(n_primary = 1, ...) {
  vals <- c(rep(PRIMARY, n_primary), palette_discrete)
  scale_color_manual(values = vals, ...)
}

# -------- Defaults per i geoms --------
set_geom_defaults <- function() {
  update_geom_defaults(
    "point",
    list(size = 2.2, stroke = 0.3, colour = modern_palette$grey3, alpha = 0.9)
  )
  update_geom_defaults(
    "line",
    list(linewidth = 0.9, colour = modern_palette$grey3, alpha = 0.95)
  )
  update_geom_defaults(
    "text",
    list(family = modern_sans, colour = modern_palette$text_dark, size = 3.6)
  )
  update_geom_defaults("label", list(family = modern_sans))
  update_geom_defaults("bar", list(linewidth = 0.2, colour = NA))
  update_geom_defaults("area", list(fill = modern_palette$grey6, alpha = 0.6))
  invisible(TRUE)
}
set_geom_defaults()

# -------- Device: PNG alta qualità + background trasparente --------
use_device_for_format <- function() {
  knitr::opts_chunk$set(
    dev = "ragg_png",
    fig.ext = "png",
    dpi = 300,
    out.width = "85%",
    fig.align = "center",
    fig.asp = 0.618,
    fig.width = 7,
    fig.height = 4.33,
    comment = "#>",
    collapse = TRUE,
    message = FALSE,
    warning = FALSE,
    echo = TRUE,
    eval = TRUE,
    error = FALSE,
    # trasparenza del device (funziona con ragg >= 1.2)
    dev.args = list(background = "transparent")
  )
  invisible(TRUE)
}
use_device_for_format()


# -------- tinytable --------
# Tema "void" minimal; header e linee coerenti con Cosmo
options(
  tinytable_format_num_fmt = "significant_cell",
  tinytable_format_digits = 3,
  tinytable_tt_digits = 3,
  tinytable_theme = "void",
  tinytable_css = paste(
    ":root{--tt-border:",
    BORDER,
    "; --tt-primary:",
    PRIMARY,
    ";}",
    "table.tt{border:1px solid var(--tt-border)}",
    "table.tt thead th{border-bottom:2px solid var(--tt-border);",
    "color:",
    TEXT_MED,
    "; font-weight:600}",
    "table.tt td, table.tt th{border-bottom:1px solid var(--tt-border)}",
    "table.tt caption{color:",
    TEXT_LIGHT,
    ";}"
  )
)

# -------- Helper tema/label --------
nessuna_griglia <- theme(panel.grid = element_blank())
griglia_sottile_x <- theme(panel.grid.major.y = element_blank())
griglia_sottile_y <- theme(panel.grid.major.x = element_blank())
legenda_in_alto <- theme(legend.position = "top")
legenda_destra <- theme(legend.position = "right")

formato_italiano <- function(accuracy = 0.01, scale = 1)
  scales::label_number(
    accuracy = accuracy,
    scale = scale,
    decimal.mark = ",",
    big.mark = "."
  )
formato_percentuale_it <- function(accuracy = 1)
  scales::label_percent(accuracy = accuracy, decimal.mark = ",", suffix = "%")

# -------- Comode annotazioni con colore primario --------
geom_hline_primary <- function(yintercept, ...) {
  geom_hline(
    yintercept = yintercept,
    linewidth = 0.8,
    colour = PRIMARY,
    alpha = 0.9,
    ...
  )
}
geom_vline_primary <- function(xintercept, ...) {
  geom_vline(
    xintercept = xintercept,
    linewidth = 0.8,
    colour = PRIMARY,
    alpha = 0.9,
    ...
  )
}
annotate_primary <- function(...) {
  annotate(..., colour = PRIMARY)
}
