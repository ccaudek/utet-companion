#!/usr/bin/env Rscript

## estrai_callout.R -----------------------------------------------------------
##
## Estrae i callout privi di titolo dai file .qmd e ne riporta contenuto,
## lunghezza e posizione, per decidere caso per caso se dare loro un titolo
## o riportarli a testo corrente. Non modifica nulla.
##
## Attenzione: in Quarto un callout puo' essere intitolato in due modi —
## con l'attributo title="..." oppure con un'intestazione come prima riga
## interna. Lo script distingue i due casi: solo il primo gruppo e' davvero
## senza titolo.
##
## Uso:  Rscript R/estrai_callout.R            (dalla radice del progetto)
##       Rscript R/estrai_callout.R chapters/modelli
## -----------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
root <- if (length(args) > 0) args[1] else "."

files <- list.files(
  root,
  pattern = "\\.qmd$",
  recursive = TRUE,
  full.names = TRUE
)
files <- files[!grepl("/_site/|/docs/|/\\.quarto/", files)]
if (length(files) == 0) stop("Nessun file .qmd trovato in: ", root)

apertura <- "^:::+\\s*\\{?\\.callout-(note|tip|important|warning|caution)"

senza <- list()
con_intestazione <- list()

for (f in files) {
  x <- readLines(f, warn = FALSE)
  apre <- grep(apertura, x)

  for (k in apre) {
    riga <- x[k]
    tipo <- sub(paste0(apertura, ".*"), "\\1", riga)

    ## --- fine del callout: si segue l'annidamento dei div ---------------
    livello <- 1L
    fine <- length(x)
    j <- k + 1L
    while (j <= length(x)) {
      if (grepl("^:::+\\s*\\{", x[j]) || grepl("^:::+\\s*\\.", x[j])) {
        livello <- livello + 1L
      } else if (grepl("^:::+\\s*$", x[j])) {
        livello <- livello - 1L
        if (livello == 0L) {
          fine <- j
          break
        }
      }
      j <- j + 1L
    }

    corpo <- if (fine > k + 1L) x[(k + 1L):(fine - 1L)] else character(0)
    pieno <- corpo[nzchar(trimws(corpo))]

    ## --- ha gia' un titolo? --------------------------------------------
    ha_attributo <- grepl("title\\s*=", riga)
    ha_intestazione <- length(pieno) > 0 && grepl("^#{2,6}\\s+\\S", pieno[1])
    if (ha_attributo) next

    n_righe <- length(pieno)
    ha_codice <- any(grepl("^```|^#\\|", corpo))
    ha_formula <- any(grepl("^\\$\\$|\\\\begin\\{", corpo))
    collassato <- grepl("collapse\\s*=", riga)

    incipit <- paste(pieno, collapse = " ")
    incipit <- gsub("\\s+", " ", incipit)
    incipit <- substr(incipit, 1, 160)

    rec <- data.frame(
      file = sub("^\\./", "", f),
      riga = k,
      tipo = tipo,
      n_righe = n_righe,
      codice = ha_codice,
      formula = ha_formula,
      collassato = collassato,
      proposta = ifelse(
        n_righe <= 3 && !ha_codice && !ha_formula,
        "valuta se riportarlo a testo",
        "dare un titolo"
      ),
      contenuto = incipit,
      stringsAsFactors = FALSE
    )

    if (ha_intestazione)
      con_intestazione[[length(con_intestazione) + 1L]] <- rec else
      senza[[length(senza) + 1L]] <- rec
  }
}

unisci <- function(l) if (length(l)) do.call(rbind, l) else NULL
A <- unisci(senza)
B <- unisci(con_intestazione)

cat("\nFile esaminati:", length(files), "\n")
cat(strrep("-", 70), "\n")
cat(
  "Callout SENZA alcun titolo ..................",
  ifelse(is.null(A), 0, nrow(A)),
  "\n"
)
cat(
  "Callout intitolati da un'intestazione interna",
  ifelse(is.null(B), 0, nrow(B)),
  "\n"
)

if (!is.null(A)) {
  cat(strrep("-", 70), "\n")
  cat("Per tipo:\n")
  print(sort(table(A$tipo), decreasing = TRUE))
  cat("\nProposta automatica (euristica, da verificare):\n")
  print(table(A$proposta))
  cat("\nFile con piu' callout senza titolo:\n")
  print(head(sort(table(A$file), decreasing = TRUE), 12))

  write.csv(
    A,
    file.path(root, "callout_senza_titolo.csv"),
    row.names = FALSE,
    fileEncoding = "UTF-8"
  )

  ## versione leggibile, raggruppata per file
  con <- file(
    file.path(root, "callout_senza_titolo.md"),
    open = "wt",
    encoding = "UTF-8"
  )
  writeLines("# Callout senza titolo\n", con)
  for (f in unique(A$file)) {
    sub <- A[A$file == f, ]
    writeLines(paste0("\n## ", f, "  (", nrow(sub), ")\n"), con)
    for (i in seq_len(nrow(sub))) {
      writeLines(
        sprintf(
          "- **riga %d** · `%s` · %d righe · *%s*\n  %s",
          sub$riga[i],
          sub$tipo[i],
          sub$n_righe[i],
          sub$proposta[i],
          sub$contenuto[i]
        ),
        con
      )
    }
  }
  close(con)
  cat("\nScritti: callout_senza_titolo.csv e callout_senza_titolo.md\n")
}

if (!is.null(B)) {
  write.csv(
    B,
    file.path(root, "callout_con_intestazione.csv"),
    row.names = FALSE,
    fileEncoding = "UTF-8"
  )
  cat(
    "I callout intitolati da intestazione interna sono in callout_con_intestazione.csv",
    "\n(vanno solo uniformati all'attributo title=, se vuoi una sola convenzione).\n"
  )
}

d <- read.csv("callout_senza_titolo.csv", encoding = "UTF-8")
writeLines(
  with(
    subset(d, tipo == "important"),
    sprintf("%s : %d (%d righe)\n  %s", file, riga, n_righe, contenuto)
  ),
  "important_senza_titolo.txt"
)
