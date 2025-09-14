
data {
  int<lower=1> N;              // Dimensione campionaria
  vector[N] y;                 // Outcome
  vector[N] x_star;            // Predittore osservato con errore
  real<lower=0> sigma_x_star;  // SD dell'errore di misura (nota)
}
parameters {
  real a;                      // Intercetta
  real b;                      // Coefficiente di regressione
  real mu_x;                   // Media del predittore latente
  real<lower=0> sigma;         // SD dell'errore nell'outcome
  real<lower=0> sigma_x;       // SD del predittore latente (eterogeneità tra x_n)
  vector[N] x;                 // Predittore latente (parametrizzazione centered)
}
model {
  // Priors debolmente informativi e robusti
  a ~ normal(0, 5);
  b ~ student_t(3, 0, 5);          // code pesanti per b
  mu_x ~ normal(0, 5);
  sigma ~ student_t(3, 0, 2.5);    // half-Student-t implicita (vincolo <lower=0>)
  sigma_x ~ student_t(3, 0, 2.5);  // half-Student-t implicita

  // Prior gerarchica (centered) sul predittore latente
  x ~ normal(mu_x, sigma_x);

  // Modello strutturale: y | x
  y ~ normal(a + b * x, sigma);

  // Modello di misura: x_star | x
  x_star ~ normal(x, sigma_x_star);
}
generated quantities {
  vector[N] y_rep;               // posterior predictive checks
  for (n in 1:N)
    y_rep[n] = normal_rng(a + b * x[n], sigma);
}

