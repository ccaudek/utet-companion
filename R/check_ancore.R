#!/usr/bin/env Rscript
# Verifica che ogni link interno con frammento punti a un file esistente
# e a un'ancora effettivamente presente in quel file.

site <- "docs" # allinea a output-dir se lo cambi

files <- list.files(
  site,
  pattern = "\\.html$",
  recursive = TRUE,
  full.names = TRUE
)
if (!length(files)) stop("Nessun file HTML in '", site, "': hai reso il sito?")

cache <- new.env(parent = emptyenv())

ids_di <- function(path) {
  if (exists(path, envir = cache)) return(get(path, envir = cache))
  h <- paste(readLines(path, warn = FALSE), collapse = "\n")
  m <- regmatches(h, gregexpr('id="[^"]+"', h))[[1]]
  v <- unique(sub('"$', "", sub('^id="', "", m)))
  assign(path, v, envir = cache)
  v
}

problemi <- data.frame(
  pagina = character(),
  link = character(),
  causa = character()
)

for (f in files) {
  h <- paste(readLines(f, warn = FALSE), collapse = "\n")
  hrefs <- regmatches(h, gregexpr('href="[^"]*#[^"]*"', h))[[1]]
  hrefs <- unique(sub('"$', "", sub('^href="', "", hrefs)))
  hrefs <- hrefs[!grepl("^(https?:|mailto:|javascript:)", hrefs)]

  for (a in hrefs) {
    pezzi <- strsplit(a, "#", fixed = TRUE)[[1]]
    perc <- pezzi[1]
    frag <- utils::URLdecode(paste(pezzi[-1], collapse = "#"))
    if (!nzchar(frag)) next

    target <- if (!nzchar(perc)) f else file.path(dirname(f), perc)
    target <- suppressWarnings(normalizePath(target, mustWork = FALSE))

    causa <- if (!file.exists(target)) "file di destinazione assente" else if (
      !frag %in% ids_di(target)
    )
      "ancora assente" else next

    problemi <- rbind(
      problemi,
      data.frame(
        pagina = sub(paste0("^", site, "/"), "", f),
        link = a,
        causa = causa
      )
    )
  }
}

if (nrow(problemi)) {
  cat("\n*** ANCORE O DESTINAZIONI ROTTE:", nrow(problemi), "***\n\n")
  agg <- aggregate(pagina ~ link + causa, problemi, length)
  names(agg)[3] <- "occorrenze"
  print(agg[order(-agg$occorrenze), ], row.names = FALSE)
  cat("\n")
  quit(status = 1)
}

cat("Ancore: nessun problema (", length(files), "pagine ).\n")
