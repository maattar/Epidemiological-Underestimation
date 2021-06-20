% This program loads the calibration results and draws the figures.
%
% April 15, 2021
% M. Aykut Attar & Ayca Tekin-Koru

%% Clean
clc; clear; close all;

%% Save the calibration results for all specifications
calibration_results;

%% Draw and save Figure 2
distancing_figure;

%% Draw and save Figures 3, 4 & 5
main_figures;

%% Draw and save Figures 6 & 7
counterfactuals;

%% Clean the workspace and load the calibration results
clear;
load('d001.mat')
load('d0012.mat')
load('d0015.mat')
load('d002.mat')
load('d003.mat')
load('d004.mat')
load('d005.mat')

clc

%% END OF THE *.M FILE   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%