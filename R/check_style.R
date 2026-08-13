#!/usr/bin/env Rscript

## check_style.R --------------------------------------------------------------
##
## Censimento delle incoerenze editoriali nei file .qmd del progetto.
## Non modifica nulla: stampa un rapporto e scrive un CSV con le occorrenze,
## per decidere quali interventi valgano la pena prima di aprire i file.
##
## Uso:  Rscript R/check_style.R            (dalla radice del progetto)
##       Rscript R/check_style.R chapters/modelli
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

hits <- list()
add <- function(categoria, file, riga, testo) {
  hits[[length(hits) + 1]] <<- data.frame(
    categoria = categoria,
    file = sub("^\\./", "", file),
    riga = riga,
    testo = substr(trimws(testo), 1, 110),
    stringsAsFactors = FALSE
  )
}

## quali callout esistono, per contarne l'uso
tipi_callout <- c("note", "tip", "important", "warning", "caution")

for (f in files) {
  x <- readLines(f, warn = FALSE)

  ## 1. Blockquote con etichetta ad hoc: "> **Nota concettuale:** ..."
  ##    Sono "a parte" scritti a mano invece che con un callout.
  i <- grep("^\\s*>\\s*\\*\\*[^*]+[:.]\\*\\*", x)
  for (k in i) add("blockquote-etichetta", f, k, x[k])

  ## 2. Tipi di callout usati, per vedere se la semantica e' stabile
  for (tipo in tipi_callout) {
    i <- grep(paste0("^:::+\\s*\\{?\\.callout-", tipo), x)
    for (k in i) add(paste0("callout-", tipo), f, k, x[k])
  }

  ## 3. Articolo elidato prima di un riferimento incrociato:
  ##    "nell'@sec-..." rende "nell'Capitolo 22"
  i <- grep("(nell|dell|all|sull|quell|l)'\\s*[@\\[]", x)
  for (k in i) add("articolo-elidato", f, k, x[k])

  ## 4. Numerazione manuale dentro titoli gia' numerati da Quarto:
  ##    "### 1. Incertezza sulla media"
  i <- grep("^#{2,6}\\s+[0-9]+[.)]\\s+\\S", x)
  for (k in i) add("titolo-numerato-a-mano", f, k, x[k])

  ## 5. Corsivi markdown nei campi title dei callout / titoli di pagina:
  ##    negli elenchi laterali gli asterischi restano visibili
  i <- grep("^(title|pagetitle):.*\\*", x)
  for (k in i) add("corsivo-nel-title", f, k, x[k])

  ## 6. Didascalie di figura identiche nello stesso file
  cap <- grep("^#\\|\\s*fig-cap:", x, value = TRUE)
  dup <- unique(cap[duplicated(cap)])
  for (d in dup) add("fig-cap-duplicata", f, NA, d)

  ## 7. sessionInfo() in coda al capitolo
  i <- grep("sessionInfo\\s*\\(", x)
  for (k in i) add("sessionInfo", f, k, x[k])

  ## 8. Refusi ricorrenti gia' incontrati
  refusi <- c(
    "\\ble priorit\u00e0\\b" = "«le priorità» al posto di «i prior»",
    "\\bin base a a" = "«in base a a»",
    "\\bche che\\b" = "ripetizione",
    "\\bnell'[A-Z]" = "«nell'Capitolo» / «nell'Appendice»"
  )
  for (p in names(refusi)) {
    i <- grep(p, x, perl = TRUE)
    for (k in i) add(paste0("refuso: ", refusi[[p]]), f, k, x[k])
  }

  ## 9. Esercizi: verifica che il formato dei metadati sia uniforme
  i <- grep("^\\*Codice:", x)
  for (k in i) add("metadato-esercizio", f, k, x[k])
}

res <- if (length(hits)) do.call(rbind, hits) else
  data.frame(
    categoria = character(),
    file = character(),
    riga = integer(),
    testo = character()
  )

## ---- rapporto ---------------------------------------------------------------

cat("\nFile .qmd esaminati:", length(files), "\n")
cat(strrep("-", 68), "\n")

if (nrow(res) == 0) {
  cat("Nessuna occorrenza rilevata.\n")
} else {
  tab <- sort(table(res$categoria), decreasing = TRUE)
  for (nm in names(tab)) {
    n_file <- length(unique(res$file[res$categoria == nm]))
    cat(sprintf("%-28s %5d occorrenze in %3d file\n", nm, tab[[nm]], n_file))
  }

  cat(strrep("-", 68), "\n")
  cat("Distribuzione dei tipi di callout (semantica da uniformare):\n")
  cal <- res[grepl("^callout-", res$categoria), ]
  if (nrow(cal)) {
    print(sort(table(cal$categoria), decreasing = TRUE))
  }

  cat("\nFile con piu' occorrenze da sistemare:\n")
  no_cal <- res[!grepl("^callout-|^metadato-|^sessionInfo", res$categoria), ]
  if (nrow(no_cal)) {
    print(head(sort(table(no_cal$file), decreasing = TRUE), 12))
  }

  out <- file.path(root, "check_style_report.csv")
  write.csv(res, out, row.names = FALSE, fileEncoding = "UTF-8")
  cat("\nDettaglio completo scritto in:", out, "\n")
}
