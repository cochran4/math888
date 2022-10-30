% Matching histogram
for k=1:70
    matching_exact_1to1_binaryX;
    h(k,1) = diff/count;
    matching_exact_kto1;
    h(k,2) = diff/count;
end

PrettyFig
hold on
Colors
histogram(h(:,1),'FaceColor',clr(2,:),'FaceAlpha',0.7)
histogram(h(:,2),'FaceColor',clr(3,:),'FaceAlpha',0.7)
xlabel('Estimate','FontWeight','bold')
ylabel('Count','FontWeight','bold')
legend({'1-to-1','8-to-1'})
