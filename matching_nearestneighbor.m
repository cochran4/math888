% estimation_matching
% Nearest neighbor matching

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Calculus sample covariance matrix
X = [T.sex,T.education,T.age];
S = mean( X.*reshape(X,height(T),1,3) );
S = reshape(S,3,3);

% Initialize
count = 0;
diff  = 0;

% Focus on those who quit smoking
ix  = find( T.qsmk == 1 )';
ix0 = find( T.qsmk == 0 )';

% Loop through focual group
for i = ix
    
    % Find best match
    [~,j] = min( X(i,:)*(S\(X(ix0,:)')) );
    
    % Add difference in outcomes to sum
    diff = diff + (T.wt82_71(i) - T.wt82_71(ix0(j)));

end

% Sample average of difference
disp('Estimate: ')
disp(diff/length(ix))