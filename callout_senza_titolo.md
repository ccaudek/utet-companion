# Callout senza titolo


## chapters/appendix/a41_install_cmdstan.qmd  (2)

- **riga 37** · `note` · 1 righe · *valuta se riportarlo a testo*
  Se hai già R installato, verifica che sia una versione recente (4.3 o superiore). Puoi controllare la versione aprendo R o RStudio e guardando il numero che app
- **riga 241** · `tip` · 4 righe · *dare un titolo*
  Quando chiedi aiuto per un problema tecnico, includi sempre: - il tuo sistema operativo (Windows/Mac/Linux); - la versione di R che stai usando; - il messaggio 

## chapters/appendix/a51_matrix_algebra.qmd  (1)

- **riga 3** · `note` · 1 righe · *valuta se riportarlo a testo*
  Il modello di regressione multipla si scrive in forma compatta come $\mathbf{y} = \mathbf{X}\boldsymbol{\beta} + \boldsymbol{\varepsilon}$, e in Stan la previsi

## chapters/appendix/a52_reglin_frequentist.qmd  (1)

- **riga 3** · `note` · 5 righe · *dare un titolo*
  La **regressione lineare** è uno degli strumenti più utilizzati nell’ambito della statistica applicata. Il suo scopo principale è **descrivere la relazione medi

## chapters/applicazione/_intro_sec_applications.qmd  (1)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Le Parti precedenti hanno costruito un percorso progressivo. Abbiamo esaminato le difficoltà che hanno contribuito alla crisi di replicabilità, introdotto l'inf

## chapters/applicazione/01_dalla_descrizione_alla_spiegazione.qmd  (3)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Una regolarità statistica può essere stabile, replicabile e utile per fare previsioni, ma non ci dice ancora **come** il fenomeno venga prodotto. Se l'obiettivo
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Descrivere un'associazione, prevedere un esito, identificare l'effetto di un intervento e spiegare un processo sono obiettivi diversi. Un modello
- **riga 266** · `caution` · 10 righe · *dare un titolo*
  - Considerare una correlazione stabile come spiegazione del fenomeno. - Confondere la capacità di prevedere con l'identificazione del processo reale. - Consider

## chapters/applicazione/02_costruire_modello_dinamico.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Nel capitolo precedente sono stati delineati i requisiti fondamentali di una spiegazione di tipo processuale: la specificazione degli stati del sistema, degli i
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Una teoria eseguibile deve specificare stati, input, regola di aggiornamento, condizioni iniziali e relazione con le osservazioni. Nel modello di

## chapters/applicazione/03_rescorla_wagner.qmd  (2)

- **riga 3** · `note` · 10 righe · *dare un titolo*
  Nel capitolo precedente, una teoria formulata in termini verbali è stata formalizzata in un modello dinamico capace di generare previsioni quantitative. Il mode
- **riga 19** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Il modello combina una regola di apprendimento, che aggiorna valori latenti mediante l'errore di previsione, e un modello osservazionale che tras

## chapters/applicazione/04_eterogeneita_modelli_dinamici.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Nel capitolo dedicato al modello di Rescorla–Wagner abbiamo visto che un modello processuale può essere sottoposto a verifica confrontandolo con spiegazioni riv
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Complete pooling, no pooling e partial pooling non sono semplici tecniche di stima: corrispondono a ipotesi sostanzialmente diverse sulla struttu

## chapters/applicazione/05_decisione_ottimale.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  I capitoli precedenti hanno formulato ipotesi sul processo che genera il comportamento, le hanno confrontate con alternative e hanno rappresentato l'eterogeneit
- **riga 9** · `important` · 3 righe · *valuta se riportarlo a testo*
  **Da sapere.** Una decisione combina una distribuzione predittiva pertinente all'intervento con una funzione di utilità. La prima riguarda ciò che potrebbe acca

## chapters/applicazione/conclusions_sec_applications.qmd  (1)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Questa Parte ha proposto una risposta positiva a uno dei problemi messi in luce dalla crisi teorica della psicologia: il collegamento debole tra spiegazioni ver

## chapters/calcolo/_intro_sec_stan.qmd  (1)

- **riga 27** · `warning` · 1 righe · *valuta se riportarlo a testo*
  **Prerequisito tecnico**: il capitolo introduttivo sull'algoritmo di Metropolis può essere seguito con R. Prima di eseguire i capitoli dedicati a Stan, assicura

## chapters/calcolo/01_metropolis.qmd  (3)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Nella parte *Svolta* abbiamo ottenuto le distribuzioni a posteriori in due modi: esattamente, sfruttando la coniugazione, e per approssimazione, valutando la de
- **riga 12** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Perché il campionamento può sostituire il calcolo diretto; che cosa rappresentano stato corrente, proposta, probabilità di accettazione e rifiuto
- **riga 171** · `note` · 1 righe · *valuta se riportarlo a testo*
  Il codice rende visibili i passaggi appena descritti, ma non fa parte degli obiettivi essenziali. È possibile nasconderlo e concentrarsi sulle figure e sulla lo

## chapters/calcolo/02_ppl.qmd  (3)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Nel capitolo precedente abbiamo seguito passo per passo l'algoritmo di Metropolis. Per ottenere campioni dalla distribuzione a posteriori era necessario sceglie
- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un linguaggio di programmazione probabilistica consente di esprimere un modello generativo e delegare a un motore inferenziale il calcolo della d
- **riga 53** · `tip` · 2 righe · *valuta se riportarlo a testo*
  > **Il modello definisce la distribuzione che vogliamo ottenere; l'algoritmo stabilisce come esplorarla numericamente.** Modello e algoritmo collaborano, ma non

## chapters/calcolo/03_stan_intro.qmd  (2)

- **riga 3** · `note` · 8 righe · *dare un titolo*
  Nel capitolo precedente abbiamo distinto due compiti. Il ricercatore specifica il modello, mentre il software sceglie ed esegue il metodo numerico per approssim
- **riga 18** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un programma Stan distingue ciò che è osservato, ciò che è incognito, il modello probabilistico e le quantità calcolate dopo il campionamento. **

## chapters/calcolo/04_stan_odds_ratio_stan.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  In questo capitolo viene presentato uno dei programmi Stan più semplici da costruire, attraverso un confronto tra due proporzioni. Il tema principale è l'odds r
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un modello con due conteggi binomiali stima due probabilità. Differenza tra probabilità, rapporto tra probabilità e odds ratio sono confronti der

## chapters/calcolo/05_stan_two_means.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Nel capitolo precedente abbiamo utilizzato un confronto tra proporzioni per imparare a leggere un programma Stan. Qui facciamo un passo in più: l'esito non è pi
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Il confronto tra due medie può essere scritto come una regressione con un predittore dicotomico. Se `x = 0` identifica il gruppo di controllo e `

## chapters/calcolo/06_bayesian_workflow.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Nei capitoli precedenti abbiamo incontrato strumenti diversi: l'aggiornamento analitico, le distribuzioni predittive, l'algoritmo di Metropolis, i linguaggi di 
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Il workflow bayesiano collega domanda scientifica, modello generativo, prior, distribuzioni predittive, calcolo, diagnostica e comunicazione. Una

## chapters/causalita/_intro_sec_causality.qmd  (1)

- **riga 66** · `caution` · 1 righe · *valuta se riportarlo a testo*
  **Per approfondire**: il quadro degli esiti potenziali segue l'impostazione di @hernan2020. Per una trattazione accessibile del ragionamento causale e dei DAG s

## chapters/causalita/01_specification_error.qmd  (3)

- **riga 3** · `note` · 4 righe · *dare un titolo*
  La Parte *Modelli* si è conclusa con una distinzione fondamentale: una regressione può descrivere un'associazione, sostenere una previsione o contribuire alla s
- **riga 13** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Nel caso ideale considerato nel capitolo, il modello completo rappresenta correttamente il processo causale e $\beta_1$ è il coefficiente causale
- **riga 359** · `caution` · 6 righe · *dare un titolo*
  1. **Dimenticare l'ipotesi dell'esperimento mentale.** All'inizio del capitolo possiamo chiamare $\beta_2\delta$ *bias* perché abbiamo stipulato che il modello 

## chapters/causalita/02_propedeutic_causality.qmd  (2)

- **riga 3** · `note` · 15 righe · *dare un titolo*
  Nel capitolo precedente abbiamo visto che, anche quando una regressione è calcolata correttamente, non sappiamo ancora quale coefficiente debba essere interpret
- **riga 25** · `important` · 3 righe · *valuta se riportarlo a testo*
  **Da sapere.** Un effetto causale confronta ciò che accadrebbe alla stessa unità o popolazione sotto condizioni alternative ben definite. Gli esiti potenziali r

## chapters/causalita/03_causality.qmd  (2)

- **riga 3** · `note` · 5 righe · *dare un titolo*
  Nel @sec-causality-propedeutics abbiamo definito un effetto causale come confronto tra esiti potenziali sotto interventi alternativi. Abbiamo quindi chiarito **
- **riga 15** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un DAG rappresenta ipotesi causali, non correlazioni ricavate automaticamente dai dati. Per identificare un effetto totale occorre distinguere i 

## chapters/causalita/03_causalityOLD.qmd  (2)

- **riga 3** · `note` · 4 righe · *dare un titolo*
  Nel @sec-causality-propedeutics abbiamo definito un effetto causale come confronto tra esiti potenziali sotto interventi alternativi. Ora affrontiamo la domanda
- **riga 13** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un DAG rappresenta ipotesi sul processo generativo, non correlazioni scoperte automaticamente nei dati. Catene, cause comuni e collider reagiscon

## chapters/crisi/_intro_sec_crisis.qmd  (1)

- **riga 34** · `caution` · 1 righe · *valuta se riportarlo a testo*
  **Ricadute applicative:** la crisi della replicabilità non è un dibattito confinato all'accademia. Interventi clinici, educativi e organizzativi dipendono dalla

## chapters/crisi/01_crisis.qmd  (1)

- **riga 10** · `important` · 3 righe · *valuta se riportarlo a testo*
  **Da sapere.** La crisi della replicabilità non può essere spiegata soltanto mediante errori individuali o frodi. È il risultato dell'interazione tra incertezza

## chapters/diagnosi/_intro_sec_limits.qmd  (1)

- **riga 38** · `caution` · 1 righe · *valuta se riportarlo a testo*
  **Implicazioni per la lettura critica:** non basta chiedersi se \(p<0.05\). Occorre esaminare quale effetto è stato stimato, quanto è incerta la stima, se la di

## chapters/diagnosi/01_limits_stat_freq.qmd  (2)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Nel manuale abbiamo analizzato i fondamenti teorici della critica al valore-$p$: la sua definizione come probabilità condizionata all'ipotesi nulla, le controve
- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Assumendo vera l'ipotesi nulla, il valore-$p$ esprime la probabilità di osservare un risultato almeno altrettanto estremo di quello ottenuto; non

## chapters/diagnosi/02_effect_size.qmd  (3)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  La **dimensione dell'effetto** (*effect size*) descrive l'ampiezza di una differenza o di una relazione statistica. Risponde quindi a una domanda diversa da que
- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La dimensione dell'effetto descrive quanto è grande una differenza o una relazione, non se essa supera una soglia di significatività. Il $d$ di C
- **riga 58** · `note` · 1 righe · *valuta se riportarlo a testo*
  Il $d$ calcolato in un campione è una **stima**, non il valore esatto dell'effetto nella popolazione. La sua interpretazione dovrebbe quindi essere accompagnata

## chapters/diagnosi/03_s_m_errors.qmd  (2)

- **riga 3** · `note` · 1 righe · *valuta se riportarlo a testo*
  In questo capitolo analizzeremo una conseguenza cruciale del filtro della significatività statistica. Quando l’effetto vero è piccolo, il campione è ridotto e i
- **riga 7** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Il filtro $p < 0.05$ non rende necessariamente più accurate le stime selezionate. In condizioni di bassa potenza, tende invece a selezionare stim

## chapters/diagnosi/04_p_values.qmd  (2)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Il valore-$p$ è spesso trattato come se fosse una proprietà stabile di un fenomeno: uno studio produce $p=0.03$, un altro $p=0.20$, e si conclude che il primo a
- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Il valore-$p$ è una statistica campionaria. La sua distribuzione dipende dal modello, dalla dimensione dell’effetto, dalla numerosità campionaria

## chapters/diagnosi/05_degrees_of_freedom.qmd  (2)

- **riga 3** · `note` · 4 righe · *dare un titolo*
  L'oggettività e la riproducibilità sono pilastri della conoscenza scientifica: analisi corrette, applicate agli stessi dati per rispondere alla stessa domanda, 
- **riga 13** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** I gradi di libertà del ricercatore sono le scelte che collegano i dati alle conclusioni. Se tali scelte non sono dichiarate o vengono selezionate

## chapters/estensioni/_intro_sec_glm.qmd  (1)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Nelle Parti precedenti abbiamo costruito modelli probabilistici, imparato a valutarne le implicazioni e distinto con attenzione descrizione, previsione, causali

## chapters/estensioni/01_glm_modello_osservazionale.qmd  (2)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Finora abbiamo preso in considerazione soprattutto modelli in cui una variabile continua viene descritta mediante una distribuzione gaussiana. Questa scelta è n
- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un GLM separa la struttura sistematica del modello dalla distribuzione delle osservazioni. Per un esito binario, la distribuzione di Bernoulli de

## chapters/estensioni/02_conteggi_distribuzione_ipotesi.qmd  (2)

- **riga 3** · `note` · 15 righe · *dare un titolo*
  Nel capitolo precedente abbiamo introdotto i modelli lineari generalizzati distinguendo tre componenti: una distribuzione osservazionale, un predittore lineare 
- **riga 25** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un modello di Poisson rappresenta conteggi interi non negativi e collega il loro valore atteso a un predittore lineare mediante il link logaritmi

## chapters/estensioni/02_conteggi_distribuzione_ipotesiOLD.qmd  (2)

- **riga 3** · `note` · 16 righe · *dare un titolo*
  Nel capitolo precedente abbiamo introdotto i modelli lineari generalizzati distinguendo tre componenti: una distribuzione osservazionale, un predittore lineare 
- **riga 28** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un modello di Poisson rappresenta conteggi interi non negativi e collega il loro valore atteso a un predittore lineare mediante il link logaritmi

## chapters/estensioni/03_quando_ordine_contiene_informazione.qmd  (2)

- **riga 3** · `note` · 15 righe · *dare un titolo*
  Nei capitoli precedenti, il modello lineare è stato esteso agendo sulla distribuzione di probabilità della variabile dipendente: la distribuzione di Bernoulli c
- **riga 25** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un GLM statico, sebbene in grado di descrivere correttamente la distribuzione marginale delle risposte, può perdere l'informazione veicolata dall

## chapters/estensioni/03_quando_ordine_contiene_informazioneOLD.qmd  (2)

- **riga 3** · `note` · 11 righe · *dare un titolo*
  Nei capitoli precedenti abbiamo esteso il modello lineare modificando il **modello osservazionale**. Con un esito binario abbiamo usato una distribuzione Bernou
- **riga 21** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un GLM statico può descrivere correttamente la distribuzione marginale delle risposte e tuttavia perdere l'informazione contenuta nella loro sequ

## chapters/modelli/_intro_sec_regression.qmd  (1)

- **riga 43** · `caution` · 1 righe · *valuta se riportarlo a testo*
  **Nota metodologica:** nel percorso essenziale useremo soprattutto `brms`. È richiesto saper leggere la struttura generale del codice Stan generato e collegarla

## chapters/modelli/01_modello_lineare_generativo.qmd  (3)

- **riga 3** · `note` · 5 righe · *dare un titolo*
  Con la Parte *Modelli* il focus cambia. La Parte *Calcolo* ha mostrato come rappresentare e approssimare le distribuzioni a posteriori e come organizzare l'anal
- **riga 15** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Il modello lineare gaussiano specifica la distribuzione condizionata $p(y\mid x,\alpha,\beta,\sigma)$: la componente lineare descrive la media at
- **riga 427** · `caution` · 5 righe · *dare un titolo*
  - **Interpretare l'intercetta senza considerare il riferimento.** Se $X=0$ è privo di significato sostantivo o è molto lontano dai valori osservati, l'intercett

## chapters/modelli/02_regressione_verso_media.qmd  (2)

- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Nel modello lineare standardizzato, se $0<\rho<1$, la media condizionata soddisfa $\mathbb{E}(Z_Y\mid Z_X=z)=\rho z$: la previsione conserva la d
- **riga 383** · `caution` · 5 righe · *dare un titolo*
  1. **Pensare che ogni individuo debba avvicinarsi alla media è sbagliato.** La regressione verso la media riguarda una media condizionata e i singoli casi posso

## chapters/modelli/03_regressione_bayesiana_brms.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Nei due capitoli precedenti abbiamo costruito il modello lineare come distribuzione condizionata e abbiamo visto che una retta di regressione descrive la **medi
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un modello di regressione bayesiano combina la distribuzione dei dati e le distribuzioni a priori per ottenere una distribuzione congiunta a post

## chapters/modelli/04_dalla_formula_al_programma.qmd  (2)

- **riga 3** · `note` · 9 righe · *dare un titolo*
  Nel capitolo precedente abbiamo applicato il workflow bayesiano completo a una regressione con un solo predittore. Ora estenderemo la stessa struttura a più pre
- **riga 19** · `important` · 3 righe · *valuta se riportarlo a testo*
  **Da sapere.** La regressione multipla estende il modello lineare includendo più predittori nella stessa media condizionata. Il significato di ciascun coefficie

## chapters/modelli/05_inferenza_su_una_media.qmd  (4)

- **riga 3** · `note` · 14 righe · *dare un titolo*
  Nei capitoli precedenti, il modello lineare è stato introdotto prima con un solo predittore e poi esteso a più predittori. Qui compiamo il movimento opposto: el
- **riga 27** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** L'inferenza su una media è un caso particolare del modello lineare: la matrice del modello contiene soltanto la colonna dell'intercetta. La distr
- **riga 451** · `tip` · 1 righe · *valuta se riportarlo a testo*
  **Approfondimento facoltativo.** Questa sezione anticipa il tema della revisione del modello, che verrà sviluppato sistematicamente più avanti nella Parte *Mode
- **riga 522** · `caution` · 6 righe · *dare un titolo*
  1. **Trattare la media campionaria e $\mu$ come lo stesso oggetto.** La media campionaria è una statistica descrittiva calcolata sui dati osservati; $\mu$ è un 

## chapters/modelli/06_due_gruppi_rilevanza_pratica.qmd  (3)

- **riga 3** · `note` · 7 righe · *dare un titolo*
  Nel capitolo precedente abbiamo visto che stimare una sola media equivale ad adattare il modello lineare più semplice, `y ~ 1`. Il confronto tra due gruppi cost
- **riga 17** · `important` · 3 righe · *valuta se riportarlo a testo*
  **Da sapere.** Il confronto tra due gruppi è un modello lineare con un predittore categoriale a due livelli. Codifiche diverse possono attribuire significati di
- **riga 812** · `caution` · 7 righe · *dare un titolo*
  1. **Interpretare un coefficiente senza conoscere la codifica.** I coefficienti cambiano significato quando cambia il riferimento o la parametrizzazione. 2. **C

## chapters/modelli/07_piu_gruppi_contrasti_anova.qmd  (2)

- **riga 3** · `note` · 7 righe · *dare un titolo*
  Nel capitolo precedente abbiamo visto che il confronto tra due gruppi non richiede una procedura statistica separata: è un modello lineare con un predittore cat
- **riga 16** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** L'ANOVA a una via è un modello lineare con un solo predittore categoriale, o *fattore*, che possiede più di due livelli. Le parametrizzazioni a r

## chapters/modelli/08_modelli_multilivello_partial_pooling.qmd  (3)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  I dati psicologici presentano spesso una struttura gerarchica: misurazioni ripetute sulla stessa persona, studenti annidati in classi, pazienti seguiti in centr
- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** I modelli multilivello rappresentano esplicitamente la dipendenza tra le osservazioni annidate e distinguono la relazione media della popolazione
- **riga 915** · `caution` · 9 righe · *dare un titolo*
  - **Trattare le osservazioni come indipendenti quando sono annidate entro persone o gruppi.** Ignorare la struttura gerarchica dei dati porta a stime dell'incer

## chapters/modelli/09_quando_il_modello_sbaglia.qmd  (2)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Un modello può essere stimato senza difficoltà, produrre catene MCMC ben mescolate e distribuzioni a posteriori concentrate, e tuttavia rappresentare in modo in
- **riga 11** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La correttezza computazionale, l'adeguatezza predittiva e la validità dell'interpretazione sono livelli distinti. Un controllo predittivo non "va

## chapters/modelli/10_associazione_previsione_effetto_causale.qmd  (4)

- **riga 3** · `note` · 7 righe · *dare un titolo*
  La Parte *Modelli* ha mostrato come costruire un modello lineare, estenderlo a più predittori e gruppi, rappresentare l'eterogeneità e controllare se la specifi
- **riga 17** · `important` · 3 righe · *valuta se riportarlo a testo*
  **Da sapere.** Una formula statistica non determina il significato scientifico dei suoi coefficienti. L'associazione, la previsione e l'effetto causale sono obi
- **riga 276** · `caution` · 7 righe · *dare un titolo*
  1. **Chiamare “effetto” ogni coefficiente.** Un coefficiente può descrivere soltanto un'associazione se il disegno non identifica un contrasto causale. 2. **Usa
- **riga 296** · `tip` · 1 righe · *valuta se riportarlo a testo*
  **Prima di interpretare un risultato, è utile verificare quattro elementi:** qual è la domanda scientifica, quale quantità risponde a quella domanda, quali dati

## chapters/svolta/_intro_sec_bayesian.qmd  (1)

- **riga 47** · `caution` · 1 righe · *valuta se riportarlo a testo*
  **Nota metodologica:** il percorso essenziale utilizza calcoli trasparenti, simulazioni e funzioni R semplici, così che ogni passaggio dell'aggiornamento sia os

## chapters/svolta/00_epistemological_foundations.qmd  (1)

- **riga 3** · `important` · 6 righe · *dare un titolo*
  **Prerequisiti.** Questo capitolo presuppone il linguaggio probabilistico introdotto nel modulo [Probabilità per la psicologia](https://ccaudek.github.io/utet-p

## chapters/svolta/01_grid_approx.qmd  (2)

- **riga 3** · `note` · 21 righe · *dare un titolo*
  Nel capitolo del manuale dedicato alla quantificazione e all'aggiornamento dell'incertezza, il teorema di Bayes è stato presentato nella forma $$ p(\theta \mid 
- **riga 33** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Nell'approssimazione su griglia, prior e verosimiglianza vengono valutati sugli stessi valori del parametro. Il prodotto punto per punto assegna 

## chapters/svolta/02_conjugate_families.qmd  (2)

- **riga 3** · `note` · 6 righe · *dare un titolo*
  Nel capitolo precedente abbiamo imparato l'aggiornamento bayesiano attraverso la discretizzazione a griglia: a ogni valore candidato di $\theta$ abbiamo assegna
- **riga 13** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La coniugazione è una relazione tra una famiglia di prior e una specifica verosimiglianza: non è una proprietà della prior considerata isolatamen

## chapters/svolta/03_summary_posterior.qmd  (2)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Nei capitoli precedenti abbiamo imparato a costruire distribuzioni a posteriori combinando prior e verosimiglianza. Ora la domanda si sposta su un piano diverso
- **riga 12** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Il prior descrive l'incertezza sul parametro prima dei dati; la posterior descrive l'incertezza dopo l'aggiornamento. La distribuzione a posterio

## chapters/svolta/04_balance_prior_post.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Nei due capitoli precedenti abbiamo visto come costruire una distribuzione a posteriori e come riassumerla. Ora, spostiamo l'attenzione su una domanda diversa: 
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La posizione della posterior dipende sia dai valori indicati dal prior e dai dati, sia dalla precisione relativa con cui ciascuna fonte li sostie

## chapters/svolta/05_prior_pred_distr.qmd  (2)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Questo materiale approfondisce il capitolo 18 del manuale didattico e introduce uno degli strumenti più caratteristici del workflow bayesiano: la distribuzione 
- **riga 12** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La distribuzione predittiva a priori è una media delle distribuzioni dei dati condizionate ai diversi valori del parametro. Ogni distribuzione vi

## chapters/svolta/06_post_pred_distr.qmd  (2)

- **riga 3** · `note` · 3 righe · *valuta se riportarlo a testo*
  Questo materiale costituisce un approfondimento del capitolo 18 del manuale didattico e prosegue il percorso iniziato con la distribuzione predittiva a priori. 
- **riga 12** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La distribuzione predittiva a posteriori è una media delle distribuzioni dei dati condizionate ai diversi valori del parametro. A differenza dell

## chapters/svolta/07_singolo_paziente.qmd  (1)

- **riga 3** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Un punteggio osservato non coincide con il punteggio vero postulato dal modello psicometrico: è una singola misurazione e contiene errore. Nel mo

## chapters/valutazione/01_entropy.qmd  (2)

- **riga 3** · `note` · 9 righe · *dare un titolo*
  Un modello probabilistico non si limita a indicare quale esito considera più plausibile. Distribuisce la propria fiducia tra tutti gli esiti possibili. Quando u
- **riga 20** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La sorpresa di Shannon associata a un evento è $-\log p(y)$: quanto minore è la probabilità assegnata all'evento, tanto maggiore è la sorpresa. L

## chapters/valutazione/02_kl.qmd  (2)

- **riga 3** · `note` · 10 righe · *dare un titolo*
  Nel capitolo precedente abbiamo considerato una singola distribuzione predittiva. La sorpresa misura quanto fosse inatteso un evento osservato; l'entropia misur
- **riga 22** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** L'entropia incrociata $H(P,Q)$ è la sorpresa media che si ottiene quando le osservazioni seguono $P$ ma vengono valutate con $Q$. La divergenza $

## chapters/valutazione/03_valutare_modelli_bayesiani.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  I due capitoli precedenti hanno costruito il criterio informazionale. Il log-score valuta la probabilità assegnata a ciò che si osserva (@sec-entropy-shannon-in
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** Diagnostiche MCMC, controlli predittivi e validazione fuori campione rispondono a domande diverse. La LPPD valuta i dati con una posterior che li

## chapters/valutazione/04_generalizzazione.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Nel capitolo precedente abbiamo visto come stimare la qualità predittiva fuori campione mediante ELPD e LOO (@sec-div-kl-lppd-elpd). Rimane però una domanda che
- **riga 9** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La generalizzazione non è una proprietà unica e assoluta del modello. Dipende dall'unità esclusa, dalle informazioni disponibili al momento della

## chapters/visione/01_changes.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Questo capitolo non propone una singola soluzione alla crisi della replicabilità. Esso organizza le principali linee di riforma — strutturali, procedurali e com
- **riga 10** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** La crisi di replicabilità riguarda l’intero processo con cui la ricerca viene progettata, selezionata, valutata e comunicata, non soltanto singol

## chapters/visione/02_integrity.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  L'integrità della ricerca non si riduce alla sola assenza di frode. Questo capitolo esamina le decisioni quotidiane con cui ipotesi, dati, modelli e risultati v
- **riga 10** · `important` · 4 righe · *dare un titolo*
  **Da sapere.** L’integrità della ricerca riguarda l’affidabilità dell’intero processo scientifico, non soltanto i casi estremi di frode. Comprende il modo in cu

## chapters/visione/03_epilogue.qmd  (2)

- **riga 3** · `note` · 2 righe · *valuta se riportarlo a testo*
  Questo epilogo non riassume tutte le formule e non introduce un nuovo metodo. Esso, piuttosto, ricompone l'argomento complessivo del Companion: cosa significa f
- **riga 10** · `important` · 3 righe · *valuta se riportarlo a testo*
  **Da sapere.** Il percorso del Companion non conduce a una tecnica capace di produrre automaticamente conclusioni affidabili. Conduce a un workflow nel quale do
