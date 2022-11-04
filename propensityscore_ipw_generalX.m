% IPW example with general X

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Estimate propensity score
mdl   = fitglm(T,'qsmk ~ sex + education + age','Distribution','binomial');

% Compute denominator for weights
denom            = predict(mdl,T);
denom(T.qsmk==0) = 1-denom(T.qsmk==0);

% Compute IPW estimator for those who quit
m_quit = mean( T.qsmk.*T.wt82_71./denom );

% Compute IPW estimator for those who do not quit
m_nquit = mean( (1-T.qsmk).*T.wt82_71./denom );

% Take difference to get IPW estimate of ATE:
disp('IPW estimate:')
disp('-------------')
disp(   m_quit - m_nquit )
