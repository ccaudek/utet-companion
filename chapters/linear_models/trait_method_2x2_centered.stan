
data {
  int<lower=1> N;
  vector[N] X1;
  vector[N] X2;
  vector[N] Y1;
  vector[N] Y2;
}
parameters {
  // Struttura latente
  real<lower=-1, upper=1> rho;   // Corr(Tx, Ty)
  vector[N] Tx;                  // Tratto X (Var=1 imposta via prior)
  vector[N] Ty;                  // Tratto Y (Var=1 imposta via prior)
  vector[N] M;                   // Metodo comune

  // Scale
  real<lower=0> sigma_M;         // SD del metodo
  real<lower=0> sigma_x1;        // SD errore specifico X1
  real<lower=0> sigma_x2;        // SD errore specifico X2
  real<lower=0> sigma_y1;        // SD errore specifico Y1
  real<lower=0> sigma_y2;        // SD errore specifico Y2
}
model {
  // ----- PRIOR: struttura latente -----
  // Bivariata normale standard per (Tx, Ty) con correlazione rho
  {
    vector[2] mu = [0, 0]';
    matrix[2,2] Sigma;
    Sigma[1,1] = 1;      Sigma[1,2] = rho;
    Sigma[2,1] = rho;    Sigma[2,2] = 1;
    for (n in 1:N) {
      vector[2] t;
      t[1] = Tx[n];
      t[2] = Ty[n];
      t ~ multi_normal(mu, Sigma);
    }
  }

  // Metodo comune: media 0, varianza sigma_M^2
  M ~ normal(0, sigma_M);

  // Priors debolmente informative sulle scale
  rho      ~ normal(0, 0.5);        // spinge verso 0 ma lascia libertà
  sigma_M  ~ student_t(3, 0, 2.5);  // half-t implicita
  sigma_x1 ~ student_t(3, 0, 2.5);
  sigma_x2 ~ student_t(3, 0, 2.5);
  sigma_y1 ~ student_t(3, 0, 2.5);
  sigma_y2 ~ student_t(3, 0, 2.5);

  // ----- MISURAZIONE: indicatori | fattori -----
  X1 ~ normal(Tx + M, sigma_x1);
  X2 ~ normal(Tx + M, sigma_x2);
  Y1 ~ normal(Ty + M, sigma_y1);
  Y2 ~ normal(Ty + M, sigma_y2);
}
generated quantities {
  // Posterior predictive check: correlazione tra compositi replicata
  vector[N] X1_rep;
  vector[N] X2_rep;
  vector[N] Y1_rep;
  vector[N] Y2_rep;
  real r_comp_rep;

  for (n in 1:N) {
    X1_rep[n] = normal_rng(Tx[n] + M[n], sigma_x1);
    X2_rep[n] = normal_rng(Tx[n] + M[n], sigma_x2);
    Y1_rep[n] = normal_rng(Ty[n] + M[n], sigma_y1);
    Y2_rep[n] = normal_rng(Ty[n] + M[n], sigma_y2);
  }

  {
    vector[N] Xbar_rep = 0.5 * (X1_rep + X2_rep);
    vector[N] Ybar_rep = 0.5 * (Y1_rep + Y2_rep);
    real mx = mean(Xbar_rep);
    real my = mean(Ybar_rep);
    real sxx = 0;
    real syy = 0;
    real sxy = 0;
    for (n in 1:N) {
      real dx = Xbar_rep[n] - mx;
      real dy = Ybar_rep[n] - my;
      sxx += dx * dx;
      syy += dy * dy;
      sxy += dx * dy;
    }
    r_comp_rep = sxy / sqrt(sxx * syy);
  }
}

