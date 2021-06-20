DistData = xlsread('Distancing.xls');

d = DistData(:,6);
clear DistData

ds = smoothdata(d,'gaussian',25);

ds = ds/100;

T = size(d,1);

for t=1:T
    if ds(t,1)<0
        ds(t,1) = 0;
    end
end

dates = datetime({'2/14/2020'})+caldays(1:T);
dates = dates';

ts = datetime(2020,02,10);
te = datetime(2020,12,15);

figure(2)
plot(dates(1:end-1,1),d(1:end-1,1),'LineWidth',1.25)
hold on
plot(dates(1:end-1,1),100*ds(1:end-1,1),'Color',[0.95 0.45 0.45],'LineWidth',3)
yline(0,'Color','green','LineWidth',1.5)
text(dates(26,1),18,'First case','Rotation',90,'HorizontalAlignment','right','FontSize',9);
text(dates(30,1),-5,'Mobility restrictions','Rotation',90,'HorizontalAlignment','right','FontSize',9);
text(dates(56,1),-5,'Weekend curfew','Rotation',90,'HorizontalAlignment','right','FontSize',9);
text(dates(108,1),-5,'June 1st relaxations','Rotation',90,'HorizontalAlignment','right','FontSize',9);
text(dates(194,1),-5,'Workplace measures','Rotation',90,'HorizontalAlignment','right','FontSize',9);
text(dates(277,1),-5,'Weekend curfew','Rotation',90,'HorizontalAlignment','right','FontSize',9);
hold off
grid on
xlim([ts te])
ylim([-32 40])
ylabel('percent')
legend('Distancing Term','Smoothed Distancing Term')
saveas(gcf,'fig2','epsc')

clear ts te dates d ds

%% END OF THE *.M FILE   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%