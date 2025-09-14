
data {
  int<lower=1> N;
  vector[N] X1;
  vector[N] X2;
  vector[N] Y1;
  vector[N] Y2;
}
parameters {
  real<lower=-1, upper=1> rho;     // correlazione tra i tratti Tx e Ty
  real<lower=0> sigma_M;           // SD fattore di metodo condiviso
  real<lower=0> sx1;
  real<lower=0> sx2;
  real<lower=0> sy1;
  real<lower=0> sy2;
  vector[N] zTx;                   // non-centered tratti
  vector[N] zTy;
  vector[N] zM;                    // non-centered metodo
}
transformed parameters {
  vector[N] Tx = zTx;                                  // Var(Tx)=1
  vector[N] Ty = rho * zTx + sqrt(1 - square(rho)) * zTy; // Var(Ty)=1
  vector[N] M  = sigma_M * zM;                         // Var(M)=sigma_M^2
}
model {
  // Priori robuste e debolmente informative
  rho     ~ normal(0, 0.5);
  sigma_M ~ student_t(3, 0, 2.5);
  sx1     ~ student_t(3, 0, 2.5);
  sx2     ~ student_t(3, 0, 2.5);
  sy1     ~ student_t(3, 0, 2.5);
  sy2     ~ student_t(3, 0, 2.5);

  zTx ~ std_normal();
  zTy ~ std_normal();
  zM  ~ std_normal();

  // Misure: loading(tratto)=1, loading(metodo)=1
  X1 ~ normal(Tx + M, sx1);
  X2 ~ normal(Tx + M, sx2);
  Y1 ~ normal(Ty + M, sy1);
  Y2 ~ normal(Ty + M, sy2);
}
generated quantities {
  // PPC essenziale: correlazione dei compositi replicata
  vector[N] X1_rep;
  vector[N] X2_rep;
  vector[N] Y1_rep;
  vector[N] Y2_rep;
  real r_comp_rep;

  for (n in 1:N) {
    X1_rep[n] = normal_rng(Tx[n] + M[n], sx1);
    X2_rep[n] = normal_rng(Tx[n] + M[n], sx2);
    Y1_rep[n] = normal_rng(Ty[n] + M[n], sy1);
    Y2_rep[n] = normal_rng(Ty[n] + M[n], sy2);
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

