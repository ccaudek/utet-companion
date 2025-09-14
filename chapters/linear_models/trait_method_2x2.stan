
data {
  int<lower=1> N;
  vector[N] X1;
  vector[N] X2;
  vector[N] Y1;
  vector[N] Y2;
}
parameters {
  real<lower=-1, upper=1> rho;      // correlazione tra Tx e Ty
  real<lower=0> sigma_M;            // SD fattore di metodo
  real<lower=0> sx1;
  real<lower=0> sx2;
  real<lower=0> sy1;
  real<lower=0> sy2;
  vector[N] Tx;                     // tratti latenti
  vector[N] Ty;
  vector[N] M;                      // fattore metodo
}
model {
  // Priors debolmente informative
  rho ~ uniform(-1, 1);
  sigma_M ~ normal(0, 1) T[0,];
  sx1 ~ normal(0, 1) T[0,];
  sx2 ~ normal(0, 1) T[0,];
  sy1 ~ normal(0, 1) T[0,];
  sy2 ~ normal(0, 1) T[0,];

  // Tratti latenti correlati (Var=1)
  Tx ~ normal(0, 1);
  Ty ~ normal(rho * Tx, sqrt(1 - rho^2));

  // Metodo comune (Var = sigma_M^2)
  M ~ normal(0, sigma_M);

  // Misure (loading tratto = 1, loading metodo = 1)
  X1 ~ normal(Tx + M, sx1);
  X2 ~ normal(Tx + M, sx2);
  Y1 ~ normal(Ty + M, sy1);
  Y2 ~ normal(Ty + M, sy2);
}
generated quantities {
  // Reliability dei compositi rispetto al tratto (non include M)
  real r_xx = 1 / (1 + square(sigma_M) + 0.25 * (square(sx1) + square(sx2)));
  real r_yy = 1 / (1 + square(sigma_M) + 0.25 * (square(sy1) + square(sy2)));
}

