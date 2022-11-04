% Nearest neighbor matching on propensity score

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Estimate propensity score
mdl   = fitglm(T,'qsmk ~ sex + education + age','Distribution','binomial');
p     = predict(mdl,T);

% Initialize
count = 0;
diff  = 0;

% Focus on those who quit smoking
ix  = find( T.qsmk == 1 )';
ix0 = find( T.qsmk == 0 )';

% Loop through focual group
for i = ix
    
    % Find best match (closest propensity score)
    [~,j] = min( abs(p(i,:)-p(ix0,:)) );
    
    % Add difference in outcomes to sum
    diff = diff + (T.wt82_71(i) - T.wt82_71(ix0(j)));

end

% Sample average of difference
disp('Estimate ATT: ')
disp(diff/length(ix))