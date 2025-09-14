
data {
  int<lower=1> N;
  vector[N] x_star;
  vector[N] y_star;
}
parameters {
  real mu_x;
  real mu_y;
  real<lower=-1, upper=1> rho;     // correlazione latente
  real<lower=0, upper=1> r_xx;     // attendibilità X*
  real<lower=0, upper=1> r_yy;     // attendibilità Y*
  real<lower=-0.95, upper=0.95> rho_e; // correlazione errori
  vector[N] zx;                    // non-centered
  vector[N] zy;
}
transformed parameters {
  vector[N] x;
  vector[N] y;
  real sigma_x_e = sqrt( (1 - r_xx) / fmax(r_xx, 1e-8) );
  real sigma_y_e = sqrt( (1 - r_yy) / fmax(r_yy, 1e-8) );

  x = mu_x + zx;
  y = mu_y + rho * (x - mu_x) + sqrt(1 - square(rho)) * zy;
}
model {
  // Priori A: poco informative (più rischiose)
  mu_x ~ normal(0, 1);
  mu_y ~ normal(0, 1);
  rho  ~ normal(0, 0.7);
  r_xx ~ beta(2, 2);  // larga su (0,1)
  r_yy ~ beta(2, 2);
  rho_e ~ normal(0, 0.5);  // ampia intorno a 0
  zx ~ std_normal();
  zy ~ std_normal();

  // Processo di misura con errori correlati impliciti
  for (n in 1:N) {
    vector[2] e;
    e[1] = x_star[n] - x[n];
    e[2] = y_star[n] - y[n];
    e ~ multi_normal(
      [0, 0]',
      [[square(sigma_x_e), rho_e*sigma_x_e*sigma_y_e],
       [rho_e*sigma_x_e*sigma_y_e, square(sigma_y_e)]]
    );
  }
}
generated quantities {
  // report reliability (utile per il confronto)
  real reliability_x = r_xx;
  real reliability_y = r_yy;
}

