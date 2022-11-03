% estimation_matching
% Nearest neighbor matching

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Calculate sample covariance matrix and center X
X = [T.sex,T.education,T.age];
S = cov(X);

% Initialize
count = 0;
diff  = 0;

% Focus on those who quit smoking
ix  = find( T.qsmk == 1 )';
ix0 = find( T.qsmk == 0 )';

% Loop through focual group
for i = ix
    
    % Find best match
    [~,j] = min( sum( (X(i,:)-X(ix0,:)).*( (S\(X(i,:)'-X(ix0,:)'))' ), 2 ) );
    
    % Add difference in outcomes to sum
    diff = diff + (T.wt82_71(i) - T.wt82_71(ix0(j)));

end

% Sample average of difference
disp('Estimate: ')
disp(diff/length(ix))