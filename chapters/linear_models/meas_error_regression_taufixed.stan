
data {
  int<lower=0> N;
  vector[N] x_star;
  vector[N] y;
  real<lower=0> tau_mean;   // sd attesa dell'errore misura (nota/da letteratura)
  real<lower=0> tau_sd;     // deviazione molto piccola per ancorare tau
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
  real<lower=0> tau;
  vector[N] x_true;
}
model {
  // Priors
  alpha ~ normal(0, 5);
  beta  ~ normal(0, 2);
  sigma ~ exponential(1);
  tau   ~ normal(tau_mean, tau_sd) T[0,]; // ancoraggio forte

  // Misura
  x_star ~ normal(x_true, tau);

  // Struttura
  y ~ normal(alpha + beta * x_true, sigma);
}

