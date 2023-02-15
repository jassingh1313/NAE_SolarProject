%WAHEGURU JI 


%Nae project:
%Name: Jaskaran Singh 
%Cougarnet: jsingh34
%UH ID: 2027724

%Purpose and Questions this code is trying to answer:
% what state is best for purchasing a solar system?  
% What is the cost for installing a solar system?
% savings from switching from standard electricity to solar
%Would solar energy be economically sustainable for long time? 
%What are the Cost savings in power bill?  
%What are the environmental benefits? 


%% Initial average cost of a 6kW solar system to decide if one wants to consider purchasing a solar system in the specific state.
clc; clear; close all
[Solarnum,  Solartxt, Solarraw] =  xlsread('SolarPanelsCostByState.xlsx');
Solartxt(1,:) = [];
Solartxt(:,[2,5]) = [];
Statechoice = menu('Choose your state:', Solartxt);
c=1;
while Statechoice == 0 && c<5
    c = c+1;
    menu('Choose your state:', Solartxt);
end
if Statechoice == 0 
    error('not valid choice. program terminated');
end

Solarcost = Solarnum(Statechoice, 1);
Name = Solartxt(Statechoice, 1);
Statename = string(Name);

fprintf('A 6kW solar system will initially cost $%0.0f on average in the selected state of %s.\n\n', Solarcost, Statename)

 [Cheapestcost, CheapLOC] = min(Solarnum(:,1)); 
 Cheapstatename = (Solartxt(CheapLOC)); 
 Cheapstatename = string(Cheapstatename); 
 fprintf('The cheapest 6kW solar system will cost $%0.0f in the state of %s.\n\n', Cheapestcost, Cheapstatename)


%% Standard Electricity cost 
[StandardNum, StandardTxt, StandardRaw] = xlsread('StandardElectricRates.xlsx'); % cents per kWh
Powerusage = input('Enter the amount of energy monthly needed for your household in [kWh]: ');
StandardElecCost = StandardNum(Statechoice)/100*Powerusage;
fprintf('\nWith standard electricity generation you pay $%0.2f per month in %s\n\n', StandardElecCost, Statename);
 
 
 
 
 %%  Comparison of solar energy vs. standard electricity costs for your specific needs
[SunNum, SunTxt, SunRaw] = xlsread('AveragePeakSunHours.xlsx');
SunTxt(:,2) = [];


fprintf('\n\nFun fact: Your state gets an average of %0.2f hours of peak sunlight for the system.', SunNum(Statechoice)) 
SolarSystemCapacityneeded = Powerusage/(SunNum(Statechoice)*30); % in kW
fprintf('\ntherefore the solar energy system needs a capacity of at least %0.2f kW to meet the household energy needs.', SolarSystemCapacityneeded);

SolarCost1 = Solarnum(Statechoice, 2)*(SolarSystemCapacityneeded*1000);

fprintf('\n\nFor your monthly energy consumption, a solar system will cost $%0.2f', SolarCost1);


TimeBreakEven = SolarCost1/StandardElecCost;
YearBreakEven = SolarCost1/StandardElecCost/12;

fprintf('\nYour initial cost for the solar system will be compensated by the free solar energy in %0.0f months\n or approximately %0.0f years.', TimeBreakEven, YearBreakEven);


[Savings, Profit] = FifteenYearStatistics(StandardElecCost, SolarCost1);


