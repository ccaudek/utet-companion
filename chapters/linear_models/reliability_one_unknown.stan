
data {
  int<lower=1> N;
  vector[N] x_star;
  vector[N] y_star;
  real<lower=0> sigma_y_e;     // SD errore misura di Y* (nota)
}
parameters {
  real mu_T;
  real<lower=0> sigma_T;       // SD del tratto
  real<lower=0> sigma_x_e;     // SD errore misura di X* (sconosciuta)
  vector[N] T;                 // punteggi veri (fattore)
}
model {
  // Priori debolmente informative
  mu_T ~ normal(0, 1);
  sigma_T ~ lognormal(0, 0.5);
  sigma_x_e ~ lognormal(0, 0.5);

  // Tratto latente
  T ~ normal(mu_T, sigma_T);

  // Misurazioni (loading=1 per forme parallele)
  x_star ~ normal(T, sigma_x_e);
  y_star ~ normal(T, sigma_y_e);
}
generated quantities {
  real r_xx;  // reliability di X* calcolata dalla posterior
  r_xx = square(sigma_T) / (square(sigma_T) + square(sigma_x_e));
}

