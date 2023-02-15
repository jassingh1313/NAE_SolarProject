% code that gives the TWh(terawatt-hours) for the energy and country that
% was selected, for only 2019
clear;close;clear all
[NUM,TXT,RAW] = xlsread('NAE_ProjectDataRenewableEnergyGenerationWorld2019.xlsx');

E=0;
C=0;
S=0;
[S] = TWh_Generated(C,E);
%outputs the TWh generated from the country and energy chosen
fprintf('The TWh outputted by the country and choice of energy you selected in 2019 was %s     ',S)
