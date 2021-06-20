d001i066 = xlsread('d001i066e');
d001i039 = xlsread('d001i039e');
d001i133 = xlsread('d001i133e');
d0012i066 = xlsread('d0012i066e');
d0012i039 = xlsread('d0012i039e');
d0012i133 = xlsread('d0012i133e');
d0015i066 = xlsread('d0015i066e');
d0015i039 = xlsread('d0015i039e');
d0015i133 = xlsread('d0015i133e');
d002i066 = xlsread('d002i066e');
d002i039 = xlsread('d002i039e');
d002i133 = xlsread('d002i133e');
d003i066 = xlsread('d003i066e');
d003i039 = xlsread('d003i039e');
d003i133 = xlsread('d003i133e');
d004i066 = xlsread('d004i066e');
d004i039 = xlsread('d004i039e');
d004i133 = xlsread('d004i133e');
d005i066 = xlsread('d005i066e');
d005i039 = xlsread('d005i039e');
d005i133 = xlsread('d005i133e');

Ca = d001i066(:,1);  Da = d001i066(:,2);
Cb = d001i039(:,1);  Db = d001i039(:,2);
Cc = d001i133(:,1);  Dc = d001i133(:,2);
Cd = d0012i066(:,1); Dd = d0012i066(:,2);
Ce = d0012i039(:,1); De = d0012i039(:,2);
Cf = d0012i133(:,1); Df = d0012i133(:,2);
Cg = d0015i066(:,1); Dg = d0015i066(:,2);
Ch = d0015i039(:,1); Dh = d0015i039(:,2);
Ci = d0015i133(:,1); Di = d0015i133(:,2);
Cj = d002i066(:,1);  Dj = d002i066(:,2);
Ck = d002i039(:,1);  Dk = d002i039(:,2);
Cl = d002i133(:,1);  Dl = d002i133(:,2);
Cm = d003i066(:,1);  Dm = d003i066(:,2);
Cn = d003i039(:,1);  Dn = d003i039(:,2);
Co = d003i133(:,1);  Do = d003i133(:,2);
Cp = d004i066(:,1);  Dp = d004i066(:,2);
Cq = d004i039(:,1);  Dq = d004i039(:,2);
Cr = d004i133(:,1);  Dr = d004i133(:,2);
Cs = d005i066(:,1);  Ds = d005i066(:,2);
Ct = d005i039(:,1);  Dt = d005i039(:,2);
Cu = d005i133(:,1);  Du = d005i133(:,2);

CC = [Ca Cb Cc Cd Ce Cf Cg Ch Ci Cj Ck Cl Cm Cn Co Cp Cq Cr Cs Ct Cu];
DD = [Da Db Dc Dd De Df Dg Dh Di Dj Dk Dl Dm Dn Do Dp Dq Dr Ds Dt Du];

Cmin = (min(CC'))';
Cmax = (max(CC'))';

Dmin = (min(DD'))';
Dmax = (max(DD'))';

Data = xlsread('C-R-D-d_m.xls');

ts = datetime(2020,06,12);
te = datetime(2020,12,10);
dates = (ts:1:te)';

T = size(dates,1);

Cdat = Data(1:T,1); Ddat = Data(1:T,3);

tlim1 = datetime(2020,06,7);
tlim2 = datetime(2020,12,15);

figure(3)
ciplot(Dmin,Dmax,dates,[0.85 0.85 0.85])
hold on
plot(dates,Ddat,'or-','MarkerEdgeColor',[0.99 0 0],'MarkerFaceColor',[1 1 1],'LineWidth',1,'Color',[0.99 0 0],'MarkerSize',3.5)
hold off
grid on
legend('SEIRD model','official statistics','Location','NorthWest')
xlim([tlim1 tlim2])
yticks([0 5000 10000 15000 20000 25000 30000 35000 40000])
yticklabels({'0','5,000','10,000','15,000','20,000','25,000','30,000','35,000','40,000'})
saveas(gcf,'fig3','epsc')

figure(4)
ciplot(Cmin,Cmax,dates,[0.85 0.85 0.85])
hold on
plot(dates,Cdat,'or-','MarkerEdgeColor',[0.99 0 0],'MarkerFaceColor',[1 1 1],'LineWidth',1,'Color',[0.99 0 0],'MarkerSize',3.5)
hold off
grid on
legend('SEIRD model','official statistics','Location','NorthWest')
%title('COVID-19 Cases (Cumulative)')
xlim([tlim1 tlim2])
yticks([0 500000 1000000 1500000 2000000 2500000])
yticklabels({'0','0.5 million','1 million','1.5 million','2 million','2.5 million'})
saveas(gcf,'fig4','epsc')

IFR = (DD./CC)*100;
IFRmin = (min(IFR'))';
IFRmax = (max(IFR'))';
IFRoff = (Ddat./Cdat)*100;

figure(5)
ciplot(IFRmin,IFRmax,dates,[0.85 0.85 0.85])
hold on
plot(dates,IFRoff,'or-','MarkerEdgeColor',[0.99 0 0],'MarkerFaceColor',[1 1 1],'LineWidth',1,'Color',[0.99 0 0],'MarkerSize',3.5)
hold off
grid on
ylabel('percent')
legend('SEIRD model','official statistics','Location','SouthWest')
%title('Infection Fatality Rate (%)')
xlim([tlim1 tlim2])
yticks([0 0.5 1 1.5 2 2.5 3])
yticklabels({'0','0.5','1','1.5','2','2.5','3'})
saveas(gcf,'fig5','epsc')

%% END OF THE *.M FILE   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%