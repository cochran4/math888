%  Outcome regression adjusting for propensity score

% Load data
T = readtable('NHEFS.xls');

% Remove missing data
T(isnan(T.wt82_71),:) = [];

% Estimate propensity score
mdl   = fitglm(T,'qsmk ~ sex + education + age','Distribution','binomial');
p     = predict(mdl,T);

% Plot histogram
PrettyFig
hold on
Colors
histogram(p,'FaceColor',clr(2,:),'FaceAlpha',0.9)
axis([0 1 0 180])
xlabel('Estimated propensity score','FontWeight','bold')
ylabel('Count','FontWeight','bold')
legend off
set(gcf,'Position',[100 100 600 400])
print('propensityscore_histogram','-dpng','-r1000')

% Build linear splines with propensity score and knots at quartiles
T.p  = p;
q    = quantile(p,[0.25,0.5,0.75]);
T.p1 = (p >= q(1)).*(p - q(1)); 
T.p2 = (p >= q(2)).*(p - q(2)); 
T.p3 = (p >= q(3)).*(p - q(3)); 

% Build outcome regression model
mdl = fitglm(T,'wt82_71 ~ qsmk + p + p1 + p2 + p3');

% Return ATE
disp('Estimated ATE:')
disp(mdl.Coefficients.Estimate(2))