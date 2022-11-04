% AIPW example

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Estimate propensity score
mdl   = fitglm(T,'qsmk ~ sex + education + age','Distribution','binomial');

% Compute denominator for IPW weights
denom            = predict(mdl,T);
denom(T.qsmk==0) = 1-denom(T.qsmk==0);

% Estimate outcome
mdl   = fitglm(T,'wt82_71 ~ qsmk + sex + education + age');

% Compute outcome regression predictions
mu0 = mdl.Coefficients.Estimate(1) + ...
      mdl.Coefficients.Estimate(3)*T.sex + ...
      mdl.Coefficients.Estimate(5)*T.education + ...
      mdl.Coefficients.Estimate(4)*T.age;
mu1 = mu0 + mdl.Coefficients.Estimate(2);

% Compute AIPW estimator for those who quit
m_quit  = mean( mu1 + T.qsmk.*(T.wt82_71-mu1)./denom );

% Compute AIPW estimator for those who do not quit
m_nquit = mean( mu0 + (1-T.qsmk).*(T.wt82_71-mu0)./denom );

% Take difference to get IPW estimate of ATE:
disp('AIPW estimate:')
disp('-------------')
disp(   m_quit - m_nquit )
