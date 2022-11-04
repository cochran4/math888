% Direct standardization with propensity score for binary X

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Stratify by sex
F = T( T.sex == 1, :);
M = T( T.sex == 0, :);

%------
% Determine counts by smoking status and sex
disp(['Female and quits, n:'])
disp(sum(F.qsmk==1))
disp(['Female and does not quit, n:'])
disp(sum(F.qsmk==0))
disp(['Male and quits, n:'])
disp(sum(M.qsmk==1))
disp(['Male and does not quit, n:'])
disp(sum(M.qsmk==0))

%--------------
% Estimate propensity
disp('Female propensity score:')
disp(mean(F.qsmk))
disp('Male propensity score:')
disp(mean(M.qsmk))

%------
% Calculate mean weight change among quitters and non-smokers by strata

% Strata with propensity ~ 0.2276:
disp('Strata 1:')
disp('-------------')
disp('Mean weight change among quitters')
m_quit_f = mean(F.wt82_71(F.qsmk==1));
disp(m_quit_f)
disp('Mean weight change among non-quitters')
m_nquit_f = mean(F.wt82_71(F.qsmk==0));
disp(m_nquit_f)
disp('Mean difference in weight change between quitters and non-quitters')
disp(m_quit_f-m_nquit_f)

% Strata with propensity ~ 0.2887:
disp('Strata 2:')
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
disp('Proportion strata 1:')
disp('-------------')
prop_f = height(F)/height(T); 
disp(prop_f)

% Direct standardization estimate
disp('Direct standardization estimate:')
disp('-------------')
disp(     prop_f*(m_quit_f-m_nquit_f) + ...
      (1-prop_f)*(m_quit_m-m_nquit_m) )
