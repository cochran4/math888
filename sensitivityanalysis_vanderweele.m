% sensitivityanalysis_vanderweele


% Possible values of relative risks
sp            = linspace(1,3,1000)';
[rr_au,rr_uy] = ndgrid(sp,sp);

% Corresponding bounds
B = (rr_au.*rr_uy)./(rr_au+rr_uy-1);


% Counter plot relative error as function of relative risks
PrettyFig
hold on
contourf(sp,sp,B-1)
legend off
colorbar
xlabel('RR_{AU}','FontWeight','bold')
ylabel('RR_{UY}','FontWeight','bold')
print('sensitivityanalysis_vanderweele','-dpng','-r1000')
