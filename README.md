# utet-companion

**Metodi bayesiani in psicologia — Companion site**  
Materiali di accompagnamento e approfondimento al manuale UTET.

---

## Descrizione

Questo repository contiene il sito di **companion** del manuale *Metodi bayesiani in psicologia*.  
Include esempi aggiuntivi in R e Stan, chiarimenti concettuali, note di workflow e confronto modelli (LOO-CV/ELPD), con particolare attenzione alla riproducibilità.

## Contenuti

- **Inferenza bayesiana**: posteriore, prior predictive/posterior predictive, equilibrio prior–dati.  
- **MCMC e Stan**: diagnostiche, parametrizzazioni, workflow, casi studio.  
- **Regressione e GLM**: implementazioni `brms`/Stan con focus interpretativo.  
- **Entropia e confronto**: KL, LOO-CV, ELPD e lettura predittiva.  
- **Modelli formali**: dinamiche semplici, Rescorla–Wagner, applicazioni psicologiche.  
- **Contesto**: crisi di replicazione e riforma metodologica.

## Moduli satellite

- Probabilità (richiamo): <https://ccaudek.github.io/utet-prob/>  
- Frequentista + Open Science: <https://ccaudek.github.io/utet-frequentista/>  
- EDA (analisi esplorativa): <https://ccaudek.github.io/utet-eda/>

## Struttura del repository

- `_quarto.yml` — configurazione del sito.  
- `index.qmd`, `prefazione.qmd` — pagine iniziali.  
- `chapters/` — contenuti organizzati per part/sezione.  
- `style/` — fogli di stile e configurazioni.

Il sito è generato con [Quarto](https://quarto.org/) e pubblicato con GitHub Pages.

## Online

👉 Companion: <https://ccaudek.github.io/utet-companion/>  
👉 Repo: <https://github.com/ccaudek/utet-companion>

## Come contribuire

Correzioni e suggerimenti sono benvenuti: apri una *issue* qui  
<https://github.com/ccaudek/utet-companion/issues>.

## Citations

If you are using specific methods or functions from the book, please consider citing the scientific paper and/or corresponding package.

If you want to cite this online book in your research. The following citation is recommended, as it always resolves to the latest version of the book:

> Caudek, C. (2025). Metodi bayesiani per la psicologia. Zenodo. https://doi.org/10.5281/zenodo.17628315

You can use the following BibTeX entry:

```
@book{eabm_2025,
  author       = {Caudek Corrado},
  title        = {Metodi bayesiani per la psicologia},
  month        = nov,
  year         = 2025,
  publisher    = {Zenodo},
  version      = {v0.1.0},
  doi          = {10.5281/zenodo.17628315},
  url          = {https://doi.org/10.5281/zenodo.17628315},
                  },
```

## Licenza

Materiali distribuiti con licenza  
[CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.it).

- Condivisione con attribuzione.  
- Non è consentito l’uso commerciale.  
- Non sono consentite opere derivate.

---

✦ Parte del progetto **UTET** per la didattica e la divulgazione della modellazione bayesiana in psicologia.



