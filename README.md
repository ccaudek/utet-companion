# utet-companion

**Inferenza bayesiana in psicologia: ragionare con l'incertezza — Companion site**
Materiali di accompagnamento operativo al manuale di Corrado Caudek e Caterina Primi (UTET).

🌐 **Sito**: <https://ccaudek.github.io/utet-companion/>

---

## Descrizione

Questo repository contiene il sorgente del **Companion site** del manuale *Inferenza bayesiana in psicologia: ragionare con l'incertezza*.

Il manuale sviluppa i concetti sul piano **teorico** ed è stabile una volta stampato. Il Companion li **approfondisce e li mette in pratica** in R, Stan e `brms`, con esempi riproducibili, casi studio, esercizi con soluzione e alcune estensioni; è materiale **vivo**, aggiornato e ampliato nel tempo.

Il Companion non rispecchia il manuale capitolo per capitolo: la corrispondenza tra i due materiali è documentata nella [Guida al manuale](https://ccaudek.github.io/utet-companion/guida-al-manuale/), che resta la pagina di raccordo permanente tra volume stampato e materiale online.

## Struttura del percorso

Il sito è organizzato in dieci Parti, ciascuna delle quali risolve un limite lasciato aperto dalla precedente:

| Parte | Contenuto |
|---|---|
| **Crisi** | Crisi della replicabilità e fragilità del sistema di produzione delle evidenze. |
| **Diagnosi** | Laboratori computazionali su valore-*p*, dimensione dell'effetto, errori di tipo M e S, gradi di libertà del ricercatore. |
| **Svolta** | Aggiornamento bayesiano: griglia, famiglie coniugate, posterior, distribuzioni predittive. |
| **Calcolo** | Metropolis, linguaggi di programmazione probabilistica, Stan, workflow bayesiano. |
| **Modelli** | Il modello lineare come grammatica generativa: regressione, medie, contrasti, multilivello. |
| **Causalità** | Errore di specificazione, controfattuali, identificazione causale da dati osservazionali. |
| **Estensioni** | GLM: regressione logistica, proporzioni, conteggi, verso i modelli di processo. |
| **Applicazione** | Dalla teoria verbale al modello eseguibile: Rescorla–Wagner, eterogeneità, decisione. |
| **Valutazione** | Entropia, divergenza KL, ELPD e LOO, generalizzazione. |
| **Visione** | Riforma metodologica, integrità della ricerca, epilogo. |

Completano il sito le **appendici**: glossario, checklist del workflow, richiami matematici, guida a Stan e CmdStanR, diagnostica, troubleshooting.

## Moduli propedeutici del progetto

| Modulo | Ruolo | Indirizzo |
|---|---|---|
| **Teoria della probabilità** | Prerequisito per tutti: assiomi, distribuzioni, teorema di Bayes, verosimiglianza. | <https://ccaudek.github.io/utet-prob/> |
| **R e analisi esplorativa dei dati** | Prerequisito per la pratica: R, tidyverse, visualizzazione, statistica descrittiva. | <https://ccaudek.github.io/utet-eda/> |
| **Approccio frequentista** | Modulo di confronto, opzionale ma consigliato: valore-*p*, intervalli di confidenza, test di ipotesi. | <https://ccaudek.github.io/utet-frequentista/> |

## Usare il codice degli esempi

Gli esempi caricano i dati con `here::here("data", ...)` e condividono le impostazioni definite in `code/_common.R`. Entrambi i percorsi presuppongono che si stia lavorando **dentro il progetto**, non su un file isolato.

1. Scarica il repository — pulsante verde **Code → Download ZIP** — oppure, se usi Git:

   ```bash
   git clone https://github.com/ccaudek/utet-companion.git
   ```

2. Apri la cartella **come progetto** in RStudio o Positron (file `utet-companion.Rproj`). È questo passaggio che permette a `here::here()` di individuare la radice: aprendo il singolo file `.qmd` con doppio clic, i percorsi non si risolvono.

3. Esegui il codice capitolo per capitolo.

### Ambiente richiesto

- **R ≥ 4.5** (RStudio o Positron come IDE).
- **CmdStan** via `cmdstanr` → [guida all'installazione](https://ccaudek.github.io/utet-companion/chapters/appendix/a41_install_cmdstan.html).
- **Pacchetti R**: `tidyverse`, `brms`, `cmdstanr`, `loo`, `bayesplot`, `posterior`.
- **Quarto** per rigenerare il sito.

Verifica dell'installazione:

```r
library(cmdstanr)
check_cmdstan_toolchain()
```

## Struttura del repository

| Percorso | Contenuto |
|---|---|
| `_quarto.yml` | Configurazione del libro Quarto: struttura delle Parti, appendici, opzioni del sito. |
| `index.qmd` | Home del Companion. |
| `guida-al-manuale.qmd` | Pagina di raccordo tra manuale stampato e sito. **Il suo indirizzo è stampato nel volume e non va modificato.** |
| `chapters/` | I capitoli, una cartella per Parte (`crisi/`, `diagnosi/`, `svolta/`, `calcolo/`, `modelli/`, `causalita/`, `estensioni/`, `applicazione/`, `valutazione/`, `visione/`) più `appendix/`. |
| `code/` | Codice condiviso, in particolare `_common.R` (impostazioni comuni a tutti i capitoli). |
| `data/` | Dataset usati negli esempi. |
| `stan/` | Programmi Stan. |
| `figures/` | Immagini statiche. |
| `style/` | Fogli di stile e personalizzazioni SCSS. |
| `references.bib`, `apa.csl` | Bibliografia e stile citazionale. |
| `_freeze/` | Cache di Quarto: consente di rigenerare il sito senza rieseguire tutti i modelli. |

Il sito è generato con [Quarto](https://quarto.org/) e pubblicato con GitHub Pages.

Per rigenerarlo in locale:

```bash
quarto render
```

## Come citare

Il volume di riferimento è:

> Caudek, C., & Primi, C. *Inferenza bayesiana in psicologia: ragionare con l'incertezza*. UTET.

Per il materiale online è sufficiente citare l'indirizzo del Companion:

> Caudek, C. *Inferenza bayesiana in psicologia: ragionare con l'incertezza — Companion site*. <https://ccaudek.github.io/utet-companion/>

## Segnalazioni e contributi

Correzioni e suggerimenti sono benvenuti: apri una [issue](https://github.com/ccaudek/utet-companion/issues) oppure usa il pulsante **Segnala un problema** presente in fondo a ogni pagina del sito.

## Licenza

Materiali distribuiti con licenza [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.it):

- condivisione con attribuzione;
- non è consentito l'uso commerciale;
- non sono consentite opere derivate.

---

✦ Parte del progetto UTET per la didattica della modellazione bayesiana in psicologia.
