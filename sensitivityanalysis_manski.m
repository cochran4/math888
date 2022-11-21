% Manski bounds

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Max/min values
disp('Max weight gain:')
KU = max(T.wt82_71);
disp(KU)
disp('Min weight gain:')
KL = min(T.wt82_71);
disp(KL)

% Compute the part of the ATE that is measurable
C = mean(T.wt82_71(T.qsmk==1))*mean(T.qsmk) - ...
    mean(T.wt82_71(T.qsmk==0))*(1-mean(T.qsmk));
disp('C:')
disp(C)

% Compute the lower Manski bound
disp('Lower Manski bound:')
disp( C+KL - (KL + KU)*mean(T.qsmk) )

% Compute the upper Manski bound
disp('Upper Manski bound:')
disp( C+KU - (KL + KU)*mean(T.qsmk) )

% Build histogram of weight gain
PrettyFig
Colors
histogram(T.wt82_71,'FaceColor',clr(2,:),'FaceAlpha',0.8)
xlabel('Weight gain, kg', 'FontWeight','bold')
ylabel('Count', 'FontWeight','bold')
set(gcf,'Position',[100 100 600 400])
print('sensitivityanalysis_histogram', '-dpng','-r1000')

