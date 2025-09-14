
data {
  int<lower=1> N;
  vector[N] x_star;
  vector[N] y_star;
}
parameters {
  real mu_x;
  real mu_y;
  real<lower=-1, upper=1> rho;               // correlazione vera tra X e Y (latenti)
  real<lower=0, upper=1> r_xx;               // attendibilità X*
  real<lower=0, upper=1> r_yy;               // attendibilità Y*
  real<lower=-0.95, upper=0.95> rho_e;       // correlazione errori di misura
  vector[N] x;                               
  vector[N] y;
}
transformed parameters {
  real sigma_x_e = sqrt( (1 - r_xx) / fmax(r_xx, 1e-8) );  // SD errore X* (Var(lat)=1)
  real sigma_y_e = sqrt( (1 - r_yy) / fmax(r_yy, 1e-8) );  // SD errore Y*
  cov_matrix[2] Sigma_lat;
  cov_matrix[2] Omega_e;
  vector[2] mu;
  mu[1] = mu_x;
  mu[2] = mu_y;

  Sigma_lat[1,1] = 1;
  Sigma_lat[2,2] = 1;
  Sigma_lat[1,2] = rho;
  Sigma_lat[2,1] = rho;

  Omega_e[1,1] = square(sigma_x_e);
  Omega_e[2,2] = square(sigma_y_e);
  Omega_e[1,2] = rho_e * sigma_x_e * sigma_y_e;
  Omega_e[2,1] = Omega_e[1,2];
}
model {
  // Priori debolmente informative
  mu_x ~ normal(0, 1);
  mu_y ~ normal(0, 1);
  // Attendibilità: Beta moderatamente informativa (valori tipici 0.6-0.9)
  r_xx ~ beta(8, 3);
  r_yy ~ beta(8, 3);
  rho_e ~ normal(0, 0.2); // metodo comune ragionevolmente piccolo

  // Latenti
  for (n in 1:N) {
    vector[2] z;
    z[1] = x[n];
    z[2] = y[n];
    z ~ multi_normal(mu, Sigma_lat);
  }

  // Processo di misura con errori correlati
  for (n in 1:N) {
    vector[2] e;
    e[1] = x_star[n] - x[n];
    e[2] = y_star[n] - y[n];
    e ~ multi_normal([0, 0]', Omega_e);
  }
}
generated quantities {
  // utili per report
  real reliability_x = r_xx;
  real reliability_y = r_yy;
}

