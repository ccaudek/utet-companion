data {
  int<lower=1> N;
  int<lower=2> K;
  array[N] int<lower=1, upper=K> method;
  vector<lower=0>[N] h;
  vector[N] g;
  int<lower=0, upper=1> prior_only;
}

parameters {
  vector[K] mu_log_h;
  vector<lower=0>[K] sigma_log_h;

  vector[K] alpha;
  vector[K] beta;
  real<lower=0> sigma_g;
}

model {
  // Priors calibrated on hours and grades used in the case study.
  mu_log_h ~ normal(log(12), 0.7);
  sigma_log_h ~ normal(0, 0.4);

  alpha ~ normal(55, 15);
  beta ~ normal(6, 4);
  sigma_g ~ normal(0, 10);

  if (prior_only == 0) {
    for (n in 1:N) {
      h[n] ~ lognormal(mu_log_h[method[n]], sigma_log_h[method[n]]);
      g[n] ~ normal(
        alpha[method[n]] + beta[method[n]] * log1p(h[n]),
        sigma_g
      );
    }
  }
}

generated quantities {
  vector[N] log_lik;
  vector[N] h_rep;
  vector[N] g_rep;
  vector[K] h_new;
  vector[K] g_new;

  for (n in 1:N) {
    int k = method[n];

    log_lik[n] =
      lognormal_lpdf(h[n] | mu_log_h[k], sigma_log_h[k]) +
      normal_lpdf(g[n] |
        alpha[k] + beta[k] * log1p(h[n]),
        sigma_g
      );

    h_rep[n] = lognormal_rng(mu_log_h[k], sigma_log_h[k]);
    g_rep[n] = normal_rng(
      alpha[k] + beta[k] * log1p(h_rep[n]),
      sigma_g
    );
  }

  for (k in 1:K) {
    h_new[k] = lognormal_rng(mu_log_h[k], sigma_log_h[k]);
    g_new[k] = normal_rng(
      alpha[k] + beta[k] * log1p(h_new[k]),
      sigma_g
    );
  }
}
