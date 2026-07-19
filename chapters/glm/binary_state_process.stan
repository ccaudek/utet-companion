data {
  int<lower=1> N;
  int<lower=1> J;
  array[N] int<lower=1, upper=J> id;
  vector[N] x;
  array[N] int<lower=0, upper=1> y;
  array[N] int<lower=0, upper=N> prev;
  int<lower=0, upper=1> prior_only;
}

parameters {
  real alpha_mu;
  real<lower=0> alpha_sd;
  vector[J] alpha_raw;
  real beta;
  real<lower=-0.98, upper=0.98> phi;
  real<lower=0> sigma_z;
  vector[N] z_raw;
}

transformed parameters {
  vector[J] alpha = alpha_mu + alpha_sd * alpha_raw;
  vector[N] z;
  vector[N] eta;

  for (n in 1:N) {
    if (prev[n] == 0) {
      z[n] = sigma_z / sqrt(1 - square(phi)) * z_raw[n];
    } else {
      z[n] = phi * z[prev[n]] + sigma_z * z_raw[n];
    }
    eta[n] = alpha[id[n]] + beta * x[n] + z[n];
  }
}

model {
  alpha_mu ~ normal(0, 1.5);
  alpha_sd ~ normal(0, 0.8);
  alpha_raw ~ std_normal();
  beta ~ normal(0, 1);
  phi ~ normal(0, 0.4);
  sigma_z ~ normal(0, 0.6);
  z_raw ~ std_normal();

  if (prior_only == 0) {
    y ~ bernoulli_logit(eta);
  }
}

generated quantities {
  array[N] int y_rep;
  vector[N] log_lik;

  for (n in 1:N) {
    y_rep[n] = bernoulli_logit_rng(eta[n]);
    log_lik[n] = bernoulli_logit_lpmf(y[n] | eta[n]);
  }
}
