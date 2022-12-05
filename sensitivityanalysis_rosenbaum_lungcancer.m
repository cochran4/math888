% Rosenbaum sensitivity analysis (lung cancer)


% Build counts:
c  = 110;
b  = 12;
disp('ATE estimate: ')
disp(c/(c+b))

%----------------------------------
% Unbiased case
mn = (c+b)/2;
sd = sqrt(c+b)/2;
pvalue = ( 1 - normcdf( abs((c-mn)/sd) ) )*2;
disp('p-value: ')
disp(pvalue)

% Upward biased case
mn = (c+b)/(1+1/Gamma);
sd = sqrt( (c+b)*(1/Gamma)/((1+1/Gamma)^2) );
pvalue1 = ( 1 - normcdf( abs((c-mn)/sd) ) )*2;
disp('p-value-1: ')
disp(pvalue1)

% Downward biased case
mn = (c+b)/(1+Gamma);
sd = sqrt( (c+b)*(Gamma)/((1+Gamma)^2) );
pvalue2 = ( 1 - normcdf( abs((c-mn)/sd) ) )*2;
disp('p-value-2: ')
disp(pvalue2)
