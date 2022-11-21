% Direct standardization with propensity score for binary X

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Estimate propensity score
mdl   = fitglm(T,'qsmk ~ sex + education + age','Distribution','binomial');
T.ex  = predict(mdl,T);

% Estimate outcome model
mdl   = fitglm(T,'wt82_71 ~ qsmk + ex + sex + education + age')

% Estimate ATE
disp(['Estimated ATE:'])
disp(mdl.Coefficients.Estimate(2))
