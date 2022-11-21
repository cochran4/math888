% Manski bounds assuming monotonicity

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];


% Computer upper bound
C = mean(T.wt82_71(T.qsmk==1)) - ...
    mean(T.wt82_71(T.qsmk==0));
disp('Upper bound:')
disp(C)