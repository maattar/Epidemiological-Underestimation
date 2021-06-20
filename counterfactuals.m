alfa = 1/7;   % Average incubation period = 7 days   (He et al., 2020)   
bett = 0.111; % Estimated pure prob. of transmission (He et al., 2020)

zeta = 0.354069666907130;                    % delt = 0.04, ifr = 1.33
gama = 0.000356782747967748;                 % delt = 0.04, ifr = 1.33

delt = 0.04;

Pop = 83429607;

Data = xlsread('C-R-D-d_m.xls');

ts = datetime(2020,06,12);
te = datetime(2020,12,10);
dates = (ts:1:te)';

T = size(dates,1);

Cd = Data(1:T+1,1); Rd = Data(1:T+1,2); Dd = Data(1:T+1,3); 

R0 = 0.001787159;          Rb(1,1) = R0; R1(1,1) = R0; R2(1,1) = R0;
D0 = 5.7270e-05;           Db(1,1) = D0; D1(1,1) = D0; D2(1,1) = D0;
e0 = 0.344961475005424;    % e = E/I
I0 = 0.000255761;          Ib(1,1) = I0; I1(1,1) = I0; I2(1,1) = I0;
E0 = e0*I0;                Eb(1,1) = E0; E1(1,1) = E0; E2(1,1) = E0;
S0 = 1-E0-I0-R0-D0;        Sb(1,1) = S0; S1(1,1) = S0; S2(1,1) = S0;

CF_d = xlsread('cf_distancing.xls');
db = CF_d(:,1); d1 = CF_d(:,2); d2 = CF_d(:,3); 

for t=1:T
    Sb(t+1,1) = Sb(t,1) - bett*zeta*((1-db(t,1))^2)*Sb(t,1)*Ib(t,1);
    S1(t+1,1) = S1(t,1) - bett*zeta*((1-d1(t,1))^2)*S1(t,1)*I1(t,1);
    S2(t+1,1) = S2(t,1) - bett*zeta*((1-d2(t,1))^2)*S2(t,1)*I2(t,1);
    Eb(t+1,1) = Eb(t,1) + bett*zeta*((1-db(t,1))^2)*Sb(t,1)*Ib(t,1) - alfa*Eb(t,1);
    E1(t+1,1) = E1(t,1) + bett*zeta*((1-d1(t,1))^2)*S1(t,1)*I1(t,1) - alfa*E1(t,1);
    E2(t+1,1) = E2(t,1) + bett*zeta*((1-d2(t,1))^2)*S2(t,1)*I2(t,1) - alfa*E2(t,1);
    Ib(t+1,1) = Ib(t,1) + alfa*Eb(t,1) - (gama/delt)*Ib(t,1);
    I1(t+1,1) = I1(t,1) + alfa*E1(t,1) - (gama/delt)*I1(t,1);
    I2(t+1,1) = I2(t,1) + alfa*E2(t,1) - (gama/delt)*I2(t,1);
    Rb(t+1,1) = Rb(t,1) + ((gama*(1-delt))/delt)*Ib(t,1);
    R1(t+1,1) = R1(t,1) + ((gama*(1-delt))/delt)*I1(t,1);
    R2(t+1,1) = R2(t,1) + ((gama*(1-delt))/delt)*I2(t,1);
    Db(t+1,1) = Db(t,1) + gama*Ib(t,1);
    D1(t+1,1) = D1(t,1) + gama*I1(t,1);
    D2(t+1,1) = D2(t,1) + gama*I2(t,1);
end

TotIb = Pop*Ib(1:T,1); TotI1 = Pop*I1(1:T,1); TotI2 = Pop*I2(1:T,1);
TotRb = Pop*Rb(1:T,1); TotR1 = Pop*R1(1:T,1); TotR2 = Pop*R2(1:T,1);
TotDb = Pop*Db(1:T,1); TotD1 = Pop*D1(1:T,1); TotD2 = Pop*D2(1:T,1);
TotCb = TotIb + TotRb + TotDb;
TotC1 = TotI1 + TotR1 + TotD1;
TotC2 = TotI2 + TotR2 + TotD2;

Cd = Cd(1:T,1);
Dd = Dd(1:T,1);

tlim1 = datetime(2020,06,7);
tlim2 = datetime(2020,12,15);

figure(6)
plot(dates,TotDb,'Color',[0.55 0.55 0.55],'LineWidth',2)
hold on
plot(dates,TotD2,'^m-','MarkerEdgeColor',[0 0 0.99],'MarkerFaceColor',[153/256 204/256 255/256],'LineWidth',1,'Color',[0 0 0.99],'MarkerSize',3.5)
plot(dates,TotD1,'vc-','MarkerEdgeColor',[0 102/256 0],'MarkerFaceColor',[102/256 255/256 178/256],'LineWidth',1,'Color',[0 102/256 0],'MarkerSize',3.5)
plot(dates,Dd,'or-','MarkerEdgeColor',[0.99 0 0],'MarkerFaceColor',[1 1 1],'LineWidth',1,'Color',[0.99 0 0],'MarkerSize',3.5)
hold off
grid on
legend('SEIRD model benchmark: \delta=4%, IFR=1.33%','longer lockdown (ending on July 1st not on June 1st)','distancing sustained at its historical maximum','official statistics','Location','NorthWest')
%title('COVID-19 Deaths (Cumulative)')
xlim([tlim1 tlim2])
yticks([0 5000 10000 15000 20000 25000 30000])
yticklabels({'0','5,000','10,000','15,000','20,000','25,000','30,000'})
saveas(gcf,'fig6','epsc')

figure(7)
plot(dates,TotCb,'Color',[0.55 0.55 0.55],'LineWidth',2)
hold on
plot(dates,TotC2,'^m-','MarkerEdgeColor',[0 0 0.99],'MarkerFaceColor',[153/256 204/256 255/256],'LineWidth',1,'Color',[0 0 0.99],'MarkerSize',3.5)
plot(dates,TotC1,'vc-','MarkerEdgeColor',[0 102/256 0],'MarkerFaceColor',[102/256 255/256 178/256],'LineWidth',1,'Color',[0 102/256 0],'MarkerSize',3.5)
plot(dates,Cd,'or-','MarkerEdgeColor',[0.99 0 0],'MarkerFaceColor',[1 1 1],'LineWidth',1,'Color',[0.99 0 0],'MarkerSize',3.5)
hold off
grid on
legend('SEIRD model benchmark: \delta=4%, IFR=1.33%','longer lockdown (ending on July 1st not on June 1st)','distancing sustained at its historical maximum','official statistics','Location','NorthWest')
%title('COVID-19 Cases (Cumulative)')
xlim([tlim1 tlim2])
yticks([0 500000 1000000 1500000 2000000 2500000])
yticklabels({'0','0.5 million','1 million','1.5 million','2 million','2.5 million'})
saveas(gcf,'fig7','epsc')

%% END OF THE *.M FILE   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%