#!/usr/bin/env bash
set -euo pipefail

MSG="${1:-aggiornamento del Companion}"

echo "→ render"
quarto render --clean

echo "→ controllo ancore"
Rscript R/check_ancore.R

echo "→ controllo alias stampato nel volume"
test -f docs/guida-al-manuale/index.html \
  || { echo "ERRORE: alias /guida-al-manuale/ perso"; exit 1; }

echo "→ commit dei sorgenti"
git add -A
git commit -m "$MSG" || echo "  (niente da committare)"
git push

echo "→ pubblicazione"
ghp-import -n -p -f docs

echo "Fatto."
