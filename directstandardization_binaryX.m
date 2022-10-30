% Direct standardization with binary X

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Stratify by sex
F = T( T.sex == 1, :);
M = T( T.sex == 0, :);


%------
% Calculate mean weight change among quitters and non-smokers by strata

% Female strata:
disp('Female strata:')
disp('-------------')
disp('Mean weight change among quitters')
m_quit_f = mean(F.wt82_71(F.qsmk==1));
disp(m_quit_f)
disp('Mean weight change among non-quitters')
m_nquit_f = mean(F.wt82_71(F.qsmk==0));
disp(m_nquit_f)
disp('Mean difference in weight change between quitters and non-quitters')
disp(m_quit_f-m_nquit_f)

% Male strata
disp('Male strata:')
disp('-------------')
disp('Mean weight change among quitters')
m_quit_m = mean(M.wt82_71(M.qsmk==1));
disp(m_quit_m)
disp('Mean weight change among non-quitters')
m_nquit_m = mean(M.wt82_71(M.qsmk==0));
disp(m_nquit_m)
disp('Mean difference in weight change between quitters and non-quitters')
disp(m_quit_m-m_nquit_m)

% Calculuate proportions
disp('Proportion female:')
disp('-------------')
prop_f = height(F)/height(T); 
disp(prop_f)

% Direct standardization estimate
disp('Direct standardization estimate:')
disp('-------------')
disp(     prop_f*(m_quit_f-m_nquit_f) + ...
      (1-prop_f)*(m_quit_m-m_nquit_m) )
