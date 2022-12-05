% Rosenbaum sensitivity analysis

% Random seed
seed = 0;
rng(seed)

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Covert outcome to binary
T.wt82_71 = T.wt82_71 > 0;

% Perform matching
% Initialize
count = 0;
diff  = 0;

% Focus on those who quit smoking
ix = find( T.qsmk == 1 )';

% Loop through focal group
for i = 1:length(ix)
    
    % Find possible matches
    J = find( T.qsmk == 0 & T.sex == T.sex(ix(i)) );
    
    % Check if possible match is empty
    if ~isempty(J)
    
        % Update match count
        count = count + 1;
    
        % Choose one at random to be match
        j(i,1) = J( randi(length(J),1) );
                   
    end
end

% Build counts:
c  = sum(T.wt82_71(ix)==1 & T.wt82_71(j)==0 )
b  = sum(T.wt82_71(ix)==0 & T.wt82_71(j)==1 )
disp('ATE estimate: ')
disp(c/(c+b))

%----------------------------------
% Unbiased case
mn = (c+b)/2
sd = sqrt(c+b)/2
pvalue = ( 1 - normcdf( abs((c-mn)/sd) ) )*2;
disp('p-value: ')
disp(pvalue)

% Upward biased case
mn = (c+b)/(1+1/Gamma)
sd = sqrt( (c+b)*(1/Gamma)/((1+1/Gamma)^2) )
pvalue1 = ( 1 - normcdf( abs((c-mn)/sd) ) )*2;
disp('p-value-1: ')
disp(pvalue1)

% Downward biased case
mn = (c+b)/(1+Gamma)
sd = sqrt( (c+b)*(Gamma)/((1+Gamma)^2) )
pvalue2 = ( 1 - normcdf( abs((c-mn)/sd) ) )*2;
disp('p-value-2: ')
disp(pvalue2)
