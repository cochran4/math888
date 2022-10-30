% Logistic regression

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Build outcome
y = double(T.wt82_71 > 0);

% Build design matrix
X0     = [ones(height(T),1),T.sex,T.age,T.sex.*T.age];
X      = [X0,X0.*T.qsmk];
[m, n] = size(X);

% Initialize theta
theta = [log(mean(y))/log(1-mean(y)); zeros(n-1,1)];

% Tolerance for error
tol = 10^(-6);
err = 1;

% Apply Newton method
while err > tol

    % Compute mu
    eta = X*theta;
    mu  = 1./(1 + exp(-eta));

    % Estimate inverse of Fisher information matrix
    A = reshape( mean( (mu.*(1-mu)).*X.*reshape(X,m,1,n)), n, n );

    % Compute error
    b = mean( (y - mu).*X )';

    % Apply Newton's update
    theta_new = theta + A\b;

    % Update L2 error
    err = norm( theta_new - theta);
    
    % Update
    theta = theta_new;

end

% Display parameters
disp('Parameters:')
disp(theta)

% Solve for ATE
disp('ATE estimate:')
eta1 = [X0,X0]*theta;
eta0 = X0*theta(1:4);
mu1  = 1./(1+exp(-eta1));
mu0  = 1./(1+exp(-eta0));
disp(mean(mu1-mu0));

% Solve for causal OR
disp('causal OR:')
disp(mean(mu1)*(1-mean(mu0))/(mean(mu0)*(1-mean(mu1))));

% Check with built-in solver
T.y = y;
mdl = fitglm(T,'y~age*sex*qsmk','Distribution','binomial','link','logit')

