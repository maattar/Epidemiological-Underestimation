% This program minimizes Q(zeta,gamma) and saves the results for
% alternative "delta" and "IFR" values.
%
% The user should specify "delta" and "IFR" in rows 18 & 19, respectively.
% The user should also change the name of the ``*.xls" file for each
% specification.
%
% This program calls ``sol.m" to evaluate Q(.,.) and ``pos.m'' to
% simulate the SEIRD model after minimization.
%
% April 15, 2021
% M. Aykut Attar & Ayca Tekin-Koru

%% Cleaning
clc; clear; close all;

%% Specify delta and IFR
delt = 0.05;               % \in \{ 0.01,0.012,0.015,0.02,0.03,0.04,0.05 \}
ifr  = 1.33;               % \in \{ 0.39,0.66,1.33 \}

%% Bounds: zeta and gamma
lb = [0.000;                                         % lower bound of zeta
      0.000];                                        % lower bound of gamma
ub = [2.000;                                         % upper bound of zeta
      0.005];                                        % upper bound of gamma
  
%% Initial guesses: zeta and gamma
x0 = [0.4;                                        % initial guess for zeta
      0.001];                                     % initial guess for gamma
  
%% Optimization options
options = optimoptions('fmincon','Display','iter','StepTolerance',1e-20);

%% Minimization
[x,fval,exitflag] = fmincon(@sol,x0,[],[],[],[],lb,ub,[],options,delt,ifr);

%% Export simulation results for optimal (zeta,gamma)
pos; % Simulating SEIRD model for optimal (zeta,gamma) given (delt,ifr).

% Epidemiological Simulated Data
OutEpi = [string(dates) TotC TotD TotR];
xlswrite('d005i133e',OutEpi);

% Optimization Results
OutOpt = [zeta;gama;modmom1;modmom2;fval;exitflag;TotD(end);TotC(end)];
xlswrite('d005i133o',OutOpt);

%% END OF THE *.M FILE   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%