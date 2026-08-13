#!/usr/bin/env Rscript

## check_link.R ---------------------------------------------------------------
##
## Verifica che i collegamenti dei file .qmd puntino a qualcosa che esiste.
## Controlla:
##   1. link relativi a file del progetto     [testo](chapters/.../file.qmd)
##   2. immagini e risorse locali             ![...](images/...)
##   3. voci `aliases:` nel front matter      (segnala soltanto)
##   4. URL esterni, sia [testo](https://...) sia autolink <https://...>
##      (verificati solo con --url, richiede rete)
##
## Le ancore @sec- sono coperte da check_ancore.R e qui non si toccano,
## tranne un caso: un @sec- usato come bersaglio di un link, cioè
## [testo](@sec-qualcosa). Quarto non lo risolve e produce un href letterale,
## quindi viene segnalato come errore.
##
## Uso:  Rscript R/check_link.R
##       Rscript R/check_link.R --url        (verifica anche i link esterni)
## -----------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
controlla_url <- "--url" %in% args
root <- "."

files <- c(
  list.files(root, pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE),
  list.files(root, pattern = "\\.qmd$", full.names = TRUE)
)
files <- unique(files[!grepl("/_site/|/docs/|/\\.quarto/|/_freeze/", files)])
if (!length(files)) {
  stop("Nessun file .qmd trovato. Lancia lo script dalla radice del progetto.")
}

segnalazioni <- list()
esterni <- character(0)

nota <- function(tipo, file, riga, bersaglio) {
  segnalazioni[[length(segnalazioni) + 1L]] <<- data.frame(
    tipo = tipo,
    file = sub("^\\./", "", file),
    riga = riga,
    bersaglio = bersaglio,
    stringsAsFactors = FALSE
  )
}

for (f in files) {
  x <- readLines(f, warn = FALSE)

  ## esclude i blocchi di codice: i percorsi lì dentro sono R, non link
  fence <- grepl("^\\s*```", x)
  in_code <- cumsum(fence) %% 2 == 1 | fence

  for (k in which(!in_code)) {
    ## --- autolink <https://...> ---------------------------------------
    auto <- regmatches(
      x[k],
      gregexpr("<https?://[^>[:space:]]+>", x[k], perl = TRUE)
    )[[1]]
    if (length(auto)) {
      esterni <- c(esterni, gsub("^<|>$", "", auto))
    }

    ## --- link in forma [testo](bersaglio) -----------------------------
    m <- gregexpr("\\]\\(([^)[:space:]]+)\\)", x[k], perl = TRUE)
    if (m[[1]][1] == -1) next

    bersagli <- regmatches(x[k], m)[[1]]
    bersagli <- sub("^\\]\\(", "", sub("\\)$", "", bersagli))

    for (b in bersagli) {
      ## cross-reference usato come bersaglio di un link: non funziona
      if (grepl("^@", b)) {
        nota("crossref dentro un link", f, k, b)
        next
      }

      if (grepl("^(mailto:|#)", b)) next

      if (grepl("^https?:", b)) {
        esterni <- c(esterni, b)
        next
      }

      percorso <- sub("#.*$", "", b) # via l'ancora
      percorso <- utils::URLdecode(percorso) # %20 e simili
      if (!nzchar(percorso)) next

      atteso <- normalizePath(
        file.path(dirname(f), percorso),
        mustWork = FALSE
      )

      ## Quarto risolve indifferentemente il .qmd e il .html corrispondente
      alt <- sub("\\.qmd$", ".html", atteso)
      qmd <- sub("\\.html$", ".qmd", atteso)

      if (!file.exists(atteso) && !file.exists(alt) && !file.exists(qmd)) {
        nota("file mancante", f, k, b)
      } else if (grepl("\\.html($|#)", b)) {
        ## risolve, ma aggira la risoluzione dei link di Quarto
        nota("link a .html invece che a .qmd", f, k, b)
      }
    }
  }

  ## --- alias dichiarati nel front matter ------------------------------
  fm <- which(grepl("^---\\s*$", x))
  if (length(fm) >= 2) {
    testa <- x[fm[1]:fm[2]]
    if (any(grepl("^aliases:", testa))) {
      for (a in grep("^\\s*-\\s+\\S", testa, value = TRUE)) {
        nota("alias dichiarato", f, NA, trimws(sub("^\\s*-\\s+", "", a)))
      }
    }
  }
}

res <- if (length(segnalazioni)) do.call(rbind, segnalazioni) else NULL
per_tipo <- function(t) if (!is.null(res)) res[res$tipo == t, ] else NULL

cat("\nFile .qmd esaminati:", length(files), "\n")
cat(strrep("-", 68), "\n")

## ---- errori -----------------------------------------------------------------
mancanti <- per_tipo("file mancante")
crossref <- per_tipo("crossref dentro un link")
n_errori <- sum(nrow(mancanti), nrow(crossref), na.rm = TRUE)

if (n_errori == 0) {
  cat("Link a file locali: tutti risolti.\n")
} else {
  cat("DA CORREGGERE:", n_errori, "\n\n")
  if (!is.null(mancanti) && nrow(mancanti)) {
    cat("  File inesistente:\n")
    for (i in seq_len(nrow(mancanti))) {
      cat(sprintf(
        "    %s:%s  ->  %s\n",
        mancanti$file[i],
        mancanti$riga[i],
        mancanti$bersaglio[i]
      ))
    }
  }
  if (!is.null(crossref) && nrow(crossref)) {
    cat("\n  Cross-reference usato come bersaglio di un link\n")
    cat("  (Quarto non lo risolve: scrivilo come riferimento nudo,\n")
    cat("   oppure sostituiscilo con il percorso del file):\n")
    for (i in seq_len(nrow(crossref))) {
      cat(sprintf(
        "    %s:%s  ->  %s\n",
        crossref$file[i],
        crossref$riga[i],
        crossref$bersaglio[i]
      ))
    }
  }
}

## ---- avvertenze -------------------------------------------------------------
html <- per_tipo("link a .html invece che a .qmd")
if (!is.null(html) && nrow(html)) {
  cat("\nFuori convenzione (funzionano, ma Quarto non può validarli):\n")
  for (i in seq_len(nrow(html))) {
    cat(sprintf(
      "  %s:%s  ->  %s\n",
      html$file[i],
      html$riga[i],
      html$bersaglio[i]
    ))
  }
}

alias <- per_tipo("alias dichiarato")
if (!is.null(alias) && nrow(alias)) {
  cat("\nAlias dichiarati (verificabili solo dopo la pubblicazione):\n")
  for (i in seq_len(nrow(alias))) {
    cat(sprintf("  %-38s %s\n", alias$file[i], alias$bersaglio[i]))
  }
}

## ---- URL esterni ------------------------------------------------------------
esterni <- sort(unique(sub("[.,;:)]+$", "", esterni)))
cat("\nURL esterni distinti:", length(esterni), "\n")

## segnala le coppie che differiscono solo per la barra finale
senza_barra <- sub("/$", "", esterni)
doppioni <- unique(senza_barra[duplicated(senza_barra)])
if (length(doppioni)) {
  cat("\nStesso indirizzo scritto in due forme (con e senza barra finale):\n")
  for (d in doppioni) cat("  ", d, "\n")
}

if (controlla_url && length(esterni)) {
  cat("\nVerifica in corso (richiede rete)...\n\n")
  ko <- 0L
  for (u in esterni) {
    ok <- tryCatch(
      {
        con <- url(u, open = "rb")
        close(con)
        TRUE
      },
      error = function(e) FALSE
    )
    if (!ok) {
      cat("  NON RAGGIUNGIBILE:", u, "\n")
      ko <- ko + 1L
    }
  }
  if (ko == 0L) cat("  Tutti raggiungibili.\n")
  cat("\nVerifica completata.\n")
} else if (length(esterni)) {
  cat("(rilancia con --url per verificarli)\n")
  for (u in esterni) cat("  ", u, "\n")
}
