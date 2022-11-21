% Direct standardization with propensity score for binary X

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Estimate propensity
p_female = mean( T.qsmk(T.sex==1) );
p_male   = mean( T.qsmk(T.sex==0) );

% Estimate ATT
disp(['Estimated ATE:'])
numer = mean( (T.qsmk - p_female*T.sex - p_male*(1-T.sex)).*T.wt82_71);
denom = mean( (T.qsmk - p_female*T.sex - p_male*(1-T.sex)).*T.qsmk );
disp( numer/denom )
