
data {
  int<lower=1> N;
  vector[N] x_star;
  vector[N] y_star;
  real<lower=0> sigma_x_e;  // SD errore misura X*
  real<lower=0> sigma_y_e;  // SD errore misura Y*
}
parameters {
  real mu_x;
  real mu_y;
  real<lower=-1, upper=1> rho;  // correlazione tra i latenti X,Y
  vector[N] zx;                  // non-centered latenti standard
  vector[N] zy;
}
transformed parameters {
  vector[N] x;
  vector[N] y;
  // Latenti standardizzati con media (mu_x, mu_y) e Var=1
  x = mu_x + zx;
  // y correlato con x tramite rho: zy ~ N(0,1), y = mu_y + rho*(x - mu_x) + sqrt(1 - rho^2)*zy
  y = mu_y + rho * (x - mu_x) + sqrt(1 - square(rho)) * zy;
}
model {
  // Priori debolmente informative
  mu_x ~ normal(0, 1);
  mu_y ~ normal(0, 1);
  rho  ~ normal(0, 0.5); // favorisce correlazioni moderate evitando estremi
  zx ~ std_normal();
  zy ~ std_normal();

  // Processo di misura
  x_star ~ normal(x, sigma_x_e);
  y_star ~ normal(y, sigma_y_e);
}

