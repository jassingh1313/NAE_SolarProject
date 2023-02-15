function [S] = TWh_Generated(C,E)
% this function asks the user to selecta country and 
% type of energy and with that info it will output
% the TWh generated for 2019

%open data
[NUM,TXT,RAW] = xlsread('NAE_ProjectDataRenewableEnergyGenerationWorld2019.xlsx');

En = TXT(1,2:end);

Co =TXT(2:end,1);
%prompts user to select a country 
C = menu('Select a country:', Co);
% prompts the user to select one of the 4 energys
E = menu('Select a energy:', En);
if C == 1;
    
    C = 2;
else
    C = C + 1;
end

if E ==1;
    E = 2;
else
    E = E + 1;
end

S = TXT(C,E);
S= string(S);


end

