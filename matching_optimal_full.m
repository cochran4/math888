% estimation_matching
% Optimal full matching

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

% Build distance matrix
dX   = (X(ix,:)-reshape(X(ix0,:)',1,3,[]));
iSdX = reshape( sum( reshape(inv(S),1,3,3).*reshape(dX,length(ix),1,3,[]), 3 ), length(ix), 3, [] );
D    = reshape( sum( dX.*iSdX , 2 ), length(ix),[] );
tol  = 0.30;
D    = D + tol; % Penalize extra edges

% Reshape into vector 
c = D(:);

% Build constraint matrices
Ai = sparse( kron( ones(1,length(ix0)), eye(length(ix)) ) );
Aj = sparse( kron( eye(length(ix0)), ones(1,length(ix)) ) ); 

% Solve integer problem
b = -ones(length(ix)+length(ix0),1);
x = intlinprog(c,1:length(c),[-Ai; -Aj],b,[],[],zeros(length(c),1),[]);
x = reshape(x,size(D,1),size(D,2));

% Match
y0    = T.wt82_71(ix0);
y1    = T.wt82_71(ix);
[r,c] = find(x);
match = mean( [y1 - accumarray(r,y0)./accumarray(r,1); accumarray(c,y0)./accumarray(c,1) - y0 ] );

% Sample average of difference
disp('Estimate: ')
disp(match)