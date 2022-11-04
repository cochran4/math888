% IPW example with binary X

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Estimate propensity score by sex
e_female = mean( T.qsmk(T.sex==1) );
e_male   = mean( T.qsmk(T.sex==0) );

% Compute denominator for weights
denom            = e_female*T.sex + e_male*(1-T.sex);
denom(T.qsmk==0) = 1-denom(T.qsmk==0);

% Compute IPW estimator for those who quit
m_quit = mean( T.qsmk.*T.wt82_71./denom );

% Compute IPW estimator for those who do not quit
m_nquit = mean( (1-T.qsmk).*T.wt82_71./denom );

% Take difference to get IPW estimate of ATE:
disp('IPW estimate:')
disp('-------------')
disp(   m_quit - m_nquit )
