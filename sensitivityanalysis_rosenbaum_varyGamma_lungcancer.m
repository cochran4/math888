% Sensitivity analysis Rosenbaum (lung cancer example)


for m=1:51
    Gamma = 1 + (m-1)/10; 
    sensitivityanalysis_rosenbaum_lungcancer; 
    p(m,:) = [Gamma,pvalue1,pvalue,pvalue2]; 
end

PrettyFig
Colors
hold on
plot(p(:,1),p(:,2),'Color',clr(2,:),'LineWidth',1.5)
plot(p(:,1),p(:,3),'Color',clr(3,:),'LineWidth',1.5)
plot(p(:,1),p(:,4),'Color',clr(4,:),'LineWidth',1.5)
plot(p(:,1),p(:,4)*0+0.05,'--','Color',clr(1,:),'LineWidth',1.5)
xlabel('\Gamma','FontWeight','bold')
ylabel('p-value','FontWeight','bold')
legend({'worst','actual','best'},'Location','northwest')
print('sensitivityanalysis_rosenbaum_lungcancer','-dpng','-r1000')