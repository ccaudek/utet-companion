data {
  int<lower=0> M;
  real<lower=0, upper=1> rho;  // probabilità di rimanere nello stesso stato
}
generated quantities {
  array[M] int<lower=0, upper=1> y;  // Catena di Markov
  y[1] = bernoulli_rng(0.5);
  for (m in 2:M) {
    y[m] = bernoulli_rng(y[m - 1] ? rho : 1 - rho);
  } 
}
