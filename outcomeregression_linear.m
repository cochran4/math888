% Linear regression

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Build design matrix
X = [ones(height(T),1),T.sex,T.age,T.sex.*T.age];
X = [X,X.*T.qsmk];

% Build outcome
y = T.wt82_71;

% Prepare matrix and vector for OLS
b     = mean( y.*X )';
[m n] = size(X);
A     = reshape( mean( X.*reshape(X,m,1,n)), n, n );

% Solve for parameters
theta = A\b;
disp('Parameters:')
disp(theta)

disp('Mean X')
disp(mean(X(:,1:4)))

% Solve for ATE
disp('ATE estimate:')
disp(mean(X(:,1:4))*theta(5:8));

