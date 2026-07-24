
data {
  int<lower=1> N;           // numero di studenti simulati (righe del dataset)
  int<lower=1> n_items;     // numero di item per studente
}
generated quantities {
  real alpha;               // intercetta in scala logit (UNA per draw)
  real p;                   // probabilità implicita
  array[N] int y_rep;       // punteggi simulati (dati replicati)

  // 1) campiona alpha dal prior (una sola volta per questo draw)
  alpha = normal_rng(1.2, 0.5);

  // 2) trasformazione logit -> probabilità
  p = inv_logit(alpha);

  // 3) genera i punteggi per tutti gli N studenti con la stessa p
  for (i in 1:N) {
    y_rep[i] = binomial_rng(n_items, p);
  }
}

