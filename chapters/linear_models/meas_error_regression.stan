
data {
  int<lower=1> N;
  vector[N] y;
  vector[N] x_star;
  real<lower=0> sigma_x_star; // noto
}
parameters {
  real a;
  real b;
  real mu_x;
  real<lower=0> sigma;
  real<lower=0> sigma_x;
  vector[N] x;                // predittori veri (latenti)
}
model {
  // Priori debolmente informative
  a ~ normal(0, 1);
  b ~ normal(0, 1);
  mu_x ~ normal(0, 1);
  sigma ~ lognormal(0, 0.5);
  sigma_x ~ lognormal(0, 0.5);

  // Gerarchia
  x ~ normal(mu_x, sigma_x);
  y ~ normal(a + b * x, sigma);
  x_star ~ normal(x, sigma_x_star); // processo di misura
}

