
data {
  int<lower=0> N;
  vector[N] x_star;       // predittore osservato
  vector[N] y;            // esito
  real<lower=0> tau;      // sd dell'errore di misura (nota)
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
  vector[N] x_true;       // predittore latente
}
model {
  // Priors deboli e regolari
  alpha ~ normal(0, 5);
  beta  ~ normal(0, 2);
  sigma ~ exponential(1);

  // Modello di misura (tau noto)
  x_star ~ normal(x_true, tau);

  // Modello strutturale
  y ~ normal(alpha + beta * x_true, sigma);
}

