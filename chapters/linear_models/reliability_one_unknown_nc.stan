
data {
  int<lower=1> N;
  vector[N] x_star;
  vector[N] y_star;
  real<lower=0> sigma_y_e;   // SD errore di Y* (nota)
}
parameters {
  real mu_T;
  real<lower=0> sigma_T;     // SD del tratto
  real<lower=0> sigma_x_e;   // SD errore di X* (sconosciuta)
  vector[N] zT;              // non-centered
}
transformed parameters {
  vector[N] T;
  T = mu_T + sigma_T * zT;
}
model {
  // Priori robuste
  mu_T     ~ normal(0, 1);
  sigma_T  ~ student_t(3, 0, 2.5);
  sigma_x_e~ student_t(3, 0, 2.5);
  zT ~ std_normal();

  // Misurazioni (loading=1)
  x_star ~ normal(T, sigma_x_e);
  y_star ~ normal(T, sigma_y_e);
}
generated quantities {
  real r_xx;  // reliability di X*
  r_xx = square(sigma_T) / (square(sigma_T) + square(sigma_x_e));
}

