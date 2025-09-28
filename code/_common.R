## ─────────────────────────────────────────────────────────────────────
## 0) Bootstrap silenzioso e riproducibilità
## ─────────────────────────────────────────────────────────────────────
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
})

## Root (opzionale ma utile; commenta se non usi here::i_am)
# try(here::i_am(".here"), silent = TRUE)

## RNG riproducibile (anche in parallelo)
set.seed(1234)
RNGkind(kind = "Mersenne-Twister", normal.kind = "Inversion")
if (exists(".Random.seed", .GlobalEnv, inherits = FALSE))
  invisible(.Random.seed)

## ─────────────────────────────────────────────────────────────────────
## 1) Conflitti: usa SEMPRE conflict_prefer (senza 's')
## ─────────────────────────────────────────────────────────────────────
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

## ─────────────────────────────────────────────────────────────────────
## 2) BRMS / CmdStanR: backend e core
## ─────────────────────────────────────────────────────────────────────
options(
  brms.backend = "cmdstanr",
  mc.cores = max(1L, parallel::detectCores(logical = FALSE)),
  # stampa numeri compatta in pillar/tibble
  pillar.bold = TRUE,
  pillar.subtle = FALSE,
  pillar.width = Inf,
  width = 80,
  scipen = 4,
  digits = 3,
  show.signif.stars = FALSE
)

# Silenzia stan/compile se serve
rstan::rstan_options(auto_write = TRUE)

## ─────────────────────────────────────────────────────────────────────
## 3) Palette colorblind-safe (Paul Tol)
## ─────────────────────────────────────────────────────────────────────
modern_palette <- list(
  white = "#ffffff",
  off_white = "#fafafa",
  text_dark = "#2c3e50",
  text_medium = "#34495e",
  text_light = "#7f8c8d",
  blue = "#4477AA",
  cyan = "#66CCEE",
  green = "#228833",
  yellow = "#CCBB44",
  red = "#EE6677",
  purple = "#AA3377",
  grey = "#BBBBBB",
  border = "#e1e8ed",
  border_medium = "#bdc3c7",
  grid = "#ecf0f1"
)

palette_discrete <- c(
  modern_palette$blue,
  modern_palette$red,
  modern_palette$green,
  modern_palette$yellow,
  modern_palette$cyan,
  modern_palette$purple,
  modern_palette$grey
)

## ─────────────────────────────────────────────────────────────────────
## 4) Font di sistema (sans) per grafica
## ─────────────────────────────────────────────────────────────────────
locate_sans_family <- function() {
  prefer <- c(
    "Source Sans 3",
    "Source Sans Pro",
    "Inter",
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
  "sans"
}
modern_sans <- locate_sans_family()
message("Font sans serif per i grafici: ", modern_sans)

## ─────────────────────────────────────────────────────────────────────
## 5) Tema ggplot/bayesplot incapsulato (evita side-effects globali)
## ─────────────────────────────────────────────────────────────────────
apply_visual_theme <- function(base_size = 14) {
  ggplot2::theme_set(bayesplot::theme_default(
    base_family = modern_sans,
    base_size = base_size
  ))
  bayesplot::bayesplot_theme_set(bayesplot::theme_default(
    base_family = modern_sans,
    base_size = base_size + 1
  ))
  bayesplot::color_scheme_set("blue")
  invisible(TRUE)
}
apply_visual_theme()

## Scale pronte
scale_color_modern <- function(..., na.value = "#CCCCCC", drop = FALSE) {
  ggplot2::scale_color_manual(
    values = palette_discrete,
    ...,
    na.value = na.value,
    drop = drop
  )
}
scale_fill_modern <- function(..., na.value = "#CCCCCC", drop = FALSE) {
  ggplot2::scale_fill_manual(
    values = palette_discrete,
    ...,
    na.value = na.value,
    drop = drop
  )
}
scale_color_viridis_modern <- function(...)
  ggplot2::scale_color_viridis_c(option = "plasma", ...)
scale_fill_viridis_modern <- function(...)
  ggplot2::scale_fill_viridis_c(option = "plasma", ...)
# Midpoint non-bianco (più leggibile su sfondo bianco)
scale_color_divergent <- function(...)
  ggplot2::scale_color_gradient2(
    low = modern_palette$blue,
    mid = "#f7f7f7",
    high = modern_palette$red,
    midpoint = 0,
    ...
  )
scale_fill_divergent <- function(...)
  ggplot2::scale_fill_gradient2(
    low = modern_palette$blue,
    mid = "#f7f7f7",
    high = modern_palette$red,
    midpoint = 0,
    ...
  )

## Geom defaults raccolti in una funzione (chiamali solo se vuoi globali)
set_geom_defaults <- function() {
  update_geom_defaults(
    "point",
    list(size = 2.2, alpha = 0.8, stroke = 0.3, color = modern_palette$blue)
  )
  update_geom_defaults(
    "line",
    list(linewidth = 0.8, color = modern_palette$blue, alpha = 0.9)
  )
  update_geom_defaults(
    "text",
    list(family = modern_sans, color = modern_palette$text_dark, size = 3.5)
  )
  update_geom_defaults(
    "bar",
    list(
      fill = modern_palette$blue,
      color = modern_palette$white,
      alpha = 0.8,
      linewidth = 0.2
    )
  )
  invisible(TRUE)
}
# set_geom_defaults() # ← attiva solo se desideri defaults globali

## ─────────────────────────────────────────────────────────────────────
## 6) knitr: device condizionale (HTML=SVG, altrimenti PNG)
## ─────────────────────────────────────────────────────────────────────
use_device_for_format <- function() {
  # Device unico: ragg_png in tutti i formati (HTML/PDF)
  knitr::opts_chunk$set(
    dev = "ragg_png",
    dpi = 144, # retina-friendly, dimensioni contenute
    out.width = "85%",
    fig.align = "center",
    fig.asp = 0.618,
    fig.width = 7, # ~ 178mm a 144 dpi
    fig.height = 4.33,
    dev.args = list(background = "white"),
    comment = "#>",
    collapse = TRUE,
    message = FALSE,
    warning = FALSE,
    echo = TRUE,
    eval = TRUE,
    error = FALSE
    # cache = TRUE  # abilita se vuoi caching dei chunk
  )
  invisible(TRUE)
}
use_device_for_format()

## ─────────────────────────────────────────────────────────────────────
## 7) Tabelle (tinytable) con caption/note corrette
## ─────────────────────────────────────────────────────────────────────
options(
  tinytable_format_num_fmt = "significant_cell",
  tinytable_format_digits = 3,
  tinytable_tt_digits = 3,
  tinytable_theme = "void"
)

## ─────────────────────────────────────────────────────────────────────
## 8) Helper tema & formattazioni
## ─────────────────────────────────────────────────────────────────────
nessuna_griglia <- theme(panel.grid = element_blank())
griglia_sottile_x <- theme(panel.grid.major.y = element_blank())
griglia_sottile_y <- theme(panel.grid.major.x = element_blank())
legenda_in_alto <- theme(legend.position = "top")
legenda_destra <- theme(legend.position = "right")

formato_italiano <- function(accuracy = 0.01, scale = 1) {
  scales::label_number(
    accuracy = accuracy,
    scale = scale,
    decimal.mark = ",",
    big.mark = "."
  )
}
formato_percentuale_it <- function(accuracy = 1) {
  scales::label_percent(accuracy = accuracy, decimal.mark = ",", suffix = "%")
}

## ─────────────────────────────────────────────────────────────────────
## 9) Ultime rifiniture di stampa/console
## ─────────────────────────────────────────────────────────────────────
# (Opzioni pillar/width già impostate in options())

# Nota: rimuovi questa riga dal tuo script originale:
# conflicts_prefer(ggplot2::theme_void)  # ← non è una funzione valida e non serve
