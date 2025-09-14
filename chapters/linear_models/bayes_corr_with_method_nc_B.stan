
data {
  int<lower=1> N;
  vector[N] x_star;
  vector[N] y_star;
}
parameters {
  real mu_x;
  real mu_y;
  real<lower=-1, upper=1> rho;
  real<lower=0, upper=1> r_xx;
  real<lower=0, upper=1> r_yy;
  real<lower=-0.95, upper=0.95> rho_e;
  vector[N] zx;
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
  mu_x ~ normal(0, 1);
  mu_y ~ normal(0, 1);
  rho  ~ normal(0, 0.7);
  r_xx ~ beta(8, 3);   // media ~0.73 (moderatamente informativa)
  r_yy ~ beta(8, 3);
  rho_e ~ normal(0.3, 0.15); // informata su metodo comune ~0.3 (troncata)
  zx ~ std_normal();
  zy ~ std_normal();

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
  real reliability_x = r_xx;
  real reliability_y = r_yy;
}

