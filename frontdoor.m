% Frontdoor adjustment

% Simulate data generating mechanism
n = 100000;
a = 2;
b = 1;
c = 3;
d = 4;
dta.U = rand(n,1);
dta.A =  a*dta.U + rand(n,1); 
dta.M =  b*dta.A + rand(n,1);
dta.Y =  c*dta.U + d*dta.M + rand(n,1);
mdl1 = fitglm(struct2table(dta),'Y~A+M');
mdl2 = fitglm(struct2table(dta),'A~1');
mdl3 = fitglm(struct2table(dta),'M~A');
mdl4 = fitglm(struct2table(dta),'Y~U+M+A');

% Calculate causal effect using frontdoor and directly
disp('Frontdoor:')
disp( mdl1.Coefficients{3,1}*mdl3.Coefficients{2,1})
disp('Directly:')
disp( mdl4.Coefficients{4,1}*mdl3.Coefficients{2,1})

