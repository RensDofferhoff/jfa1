#include /include/license.stan

data {
  int<lower=1> n;
  int<lower=0> k;
  real<lower=0> priorx;
  real<lower=0> priorn;
  int beta_prior;
  int gamma_prior;
  int normal_prior;
  int uniform_prior;
  int cauchy_prior;
  int t_prior;
  int chisq_prior;
  int use_likelihood;
}
parameters {
  real<lower=0, upper=1> theta;
}
model {
  if (beta_prior) {
    theta ~ beta(1 + priorx, priorn - priorx);
  } else if (gamma_prior) {
    theta ~ gamma(1 + priorx, priorn);
  } else if (normal_prior) {
    theta ~ normal(priorx, priorn);
  } else if (uniform_prior) {
    theta ~ uniform(priorx, priorn);
  } else if (cauchy_prior) {
    theta ~ cauchy(priorx, priorn);
  } else if (t_prior) {
    theta ~ student_t(priorx, 0, 1);
  } else if (chisq_prior) {
    theta ~ chi_square(priorx);
  }
  if (use_likelihood) {
    k ~ binomial(n, theta);
  }
}
