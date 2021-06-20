function Q = sol(x,delt,ifr)

alfa = 1/7;   % Average incubation period = 7 days   (He et al., 2020)   
bett = 0.111; % Estimated pure prob. of transmission (He et al., 2020)

zeta = x(1,1);
gama = x(2,1);

Pop = 83429607;

Data = xlsread('C-R-D-d_m.xls');

ts = datetime(2020,06,12);
te = datetime(2020,12,10);
dates = (ts:1:te)';

T = size(dates,1);

Cd = Data(1:T+1,1);
d  = Data(1:T+1,4)/100;
ds = smoothdata(d,'gaussian',25);

R0 = 0.001787159;          R(1,1) = R0;
D0 = 5.7270e-05;           D(1,1) = D0;
e0 = 0.344961475005424;    % e = E/I
I0 = 0.000255761;          I(1,1) = I0;
E0 = e0*I0;                E(1,1) = E0;
S0 = 1-E0-I0-R0-D0;        S(1,1) = S0;

for t=1:T+1
    if ds(t,1)<=0
        ds(t,1)=0;
    end
end

for t=1:T
    S(t+1,1) = S(t,1) - bett*zeta*((1-ds(t,1))^2)*S(t,1)*I(t,1);
    E(t+1,1) = E(t,1) + bett*zeta*((1-ds(t,1))^2)*S(t,1)*I(t,1) - alfa*E(t,1);
    I(t+1,1) = I(t,1) + alfa*E(t,1) - (gama/delt)*I(t,1);
    R(t+1,1) = R(t,1) + ((gama*(1-delt))/delt)*I(t,1);
    D(t+1,1) = D(t,1) + gama*I(t,1);
end

TotI = Pop*I(1:T,1);
TotR = Pop*R(1:T,1);
TotD = Pop*D(1:T,1);
TotC = TotI + TotR + TotD;

if (isnan(TotC(T,1))==1) || (isnan(TotD(T,1))==1)
    Q = 10^10;
elseif (isinf(TotC(T,1))==1) || (isinf(TotD(T,1))==1)
    Q = 10^10;
elseif TotC(T,1) >= Pop/2
    Q = 10^10;
else
    datmom1 = ifr;
    modmom1 = 100*(TotD(T,1)/TotC(T,1));

    Oct3cm = TotC(114,1)-TotC(113,1);
    Oct3cd = Cd(114,1)-Cd(113,1);

    datmom2 = 6.87;
    modmom2 = Oct3cm/Oct3cd;

    Q = (modmom1-datmom1)^2 + (modmom2-datmom2)^2;
end

%% END OF THE *.M FILE   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%