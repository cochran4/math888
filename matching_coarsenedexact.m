% estimation_matching
% Coarsened exact matching

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Coarsen age
T.age = 1*(T.age < 35) + ...
        2*(35 <= T.age & T.age < 45) + ...
        3*(45 <= T.age & T.age < 55) + ...
        4*(55 <= T.age & T.age < 65) + ...
        5*(65 <= T.age);

% Initialize
count = 0;
diff  = 0;

% Focus on those who quit smoking
ix = find( T.qsmk == 1 )';

% Loop through focual group
for i = ix
    
    % Find possible matches
    J = find( T.qsmk == 0 & T.sex == T.sex(i) & T.education == T.education(i) & T.age == T.age(i) );
    
    % Check if possible match is empty
    if length(J) >= k
    
        % Update match count
        count = count + 1;
    
        % Choose 8 people at random to be match
        match_ave = 0;
        for l=1:8
            j         = J( randi(length(J),1) );
            match_ave = match_ave + T.wt82_71(j)/8;
            J         = setdiff(J,j);
        end

        % Add difference in outcomes to sum
        diff = diff + (T.wt82_71(i) - match_ave);
                
    end
end

% Sample average of difference
disp('Estimate: ')
disp(diff/count)