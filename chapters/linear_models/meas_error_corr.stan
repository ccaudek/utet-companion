
data {
  int<lower=1> N;
  vector[N] x_star;
  vector[N] y_star;
  real<lower=0> sigma_x_star; // SD errore misura X*
  real<lower=0> sigma_y_star; // SD errore misura Y*
}
parameters {
  real mu_x;
  real mu_y;
  real<lower=0> sigma_x;      // SD vera X
  real<lower=0> sigma_y;      // SD vera Y
  real<lower=-1,upper=1> rho; // correlazione vera
  vector[N] x;                // punteggi veri latenti
  vector[N] y;
}
transformed parameters {
  cov_matrix[2] Sigma;
  Sigma[1,1] = square(sigma_x);
  Sigma[2,2] = square(sigma_y);
  Sigma[1,2] = rho * sigma_x * sigma_y;
  Sigma[2,1] = Sigma[1,2];
  vector[2] mu = [mu_x, mu_y]';
}
model {
  // Priori debolmente informative
  mu_x ~ normal(0, 1);
  mu_y ~ normal(0, 1);
  sigma_x ~ lognormal(0, 0.5);
  sigma_y ~ lognormal(0, 0.5);
  // Gerarchia latente
  for (n in 1:N) {
    vector[2] z;
    z[1] = x[n];
    z[2] = y[n];
    z ~ multi_normal(mu, Sigma);
  }
  // Processo di misura (SD noti)
  x_star ~ normal(x, sigma_x_star);
  y_star ~ normal(y, sigma_y_star);
}

