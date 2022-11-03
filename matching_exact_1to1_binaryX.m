% estimation_matching
% 1-1 exact matching with replacement on biological sex

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Initialize
count = 0;
diff  = 0;

% Focus on those who quit smoking
ix = find( T.qsmk == 1 )';

% Loop through focal group
for i = ix
    
    % Find possible matches
    J = find( T.qsmk == 0 & T.sex == T.sex(i) );
    
    % Check if possible match is empty
    if ~isempty(J)
    
        % Update match count
        count = count + 1;
    
        % Choose one at random to be match
        j = J( randi(length(J),1) );
    
        % Add difference in outcomes to sum
        diff = diff + (T.wt82_71(i) - T.wt82_71(j));
                
    end
end

% Sample average of difference
disp('Estimate: ')
disp(diff/count)