% Direct standardization with discrete X

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Loop through sex
for i=0:1
    % Loop through education level
    for j=1:5

       % Stratification number
       k = i*5 + j;

       % Stratify
       tmp = T( T.sex == i & T.education == j, :);

       % Count in strata
       count(k,1) = height(tmp);

       % Mean weight change for quitters
       m_quit(k,1)  = mean(tmp.wt82_71(tmp.qsmk==1));
       
       % Mean weight change for non-quitters
       m_nquit(k,1) = mean(tmp.wt82_71(tmp.qsmk==0)); 

    end
end

% Direct standardization result:
disp('Direct standardization estimate of ATE:')
sum( (count/sum(count)).*( m_quit - m_nquit) )