clc; clear; close all 
%% Mayra Martinez
% ENGI 1331
% 2074058
% mmart227
% Group #8 "Economic effects of solar energy production and consumption"
% NAE project 

%This set of data allows the user to review prices by year rom 2001 to 2019
list_price = readmatrix('Solar-pv-prices.csv'); %loading data
Years = list_price(:,1); % creating a list of years
Prices = list_price(:,2); % creating a list for prices
PricesYear = Prices(26:44); % Taking out the last 20 years
TwentyYears = Years(26:44); % getting values for the last twenty years
TwentyYearsNum = TwentyYears;
TwentyYears = string(TwentyYears); %converting into a string

%TASK 2 
% allow the user to review the prices between 2001 and 2019 by choosing a
% year from the menu
YearSelection = menu('User please select a year from the menu:',TwentyYears);% asking the user to choose a yer
 % If after 5 attempts the user do  not select a year display an error and
 % terminates the program
c=1; %initializing count
while YearSelection == 0
    YearSelection = menu('User please select a year from the menu:',TwentyYears);
    c = c+1;
        if c == 5
        	error('User did not make a selection. Program Terminated.')
        end
end

% YearSelection = menu('User please select a year from the menu:',TwentyYears);% asking the user to choose a yer
Price = PricesYear(YearSelection);
ChoosenYear = TwentyYears(YearSelection);
fprintf('\n The price of Solar PV Module Cost in %s was $%.2f [USD/W]\n',ChoosenYear,Price)%outpout fo the choosen year

% adding both years and prices together 
 NewData = [TwentyYears PricesYear];
 
 %TASK 3
 
 % %Call this function 3 times in your main script to outpout the highest
 % and mininimum price with its corresponding year.Also,output the average for t he range of twenty years. 
 
[Max,Min,AVG,HighestPrice,LowestPrice] = PriceperYear(TwentyYears,PricesYear);
%  Max = Max;
%   fprintf('\nThe maximum price of installed Solar PV Module in a range of twenty years was $%0.2f [USD/W]',Max)
fprintf('\nThe highest price of installed Solar PV Module in a range of twenty years was $%0.2f [USD/W] in %s. ',Max,HighestPrice)
fprintf('\nThe lowest price of installed Solar PV Module in a range of twenty years was $%0.2f [USD/W] in %s. ',Min,LowestPrice)
fprintf('\nThe average price of installed Solar PV Module in a range of twenty years was $%0.2f [USD/W]\n',AVG)
 
%Difference in price in a range of 20 years
DChangeinPrice = (Max - Min);
fprintf('\nIn a range of twenty years the price of installed Solar PV Module decreased $%0.2f [USD/W]',DChangeinPrice)

plot(TwentyYearsNum,PricesYear,'or')
title('Prices Vs Time')
xlabel('Years')
ylabel('Prices')
grid on

% Average =[];
% for i= 2:length(PricesYear)-1 % creating a list from 2 to lenght of price
% Average(i-1) = mean(PricesYear(i),PricesYear(i-1),PricesYear(i+1))
% end
% hold on
% plot(TwentyYearsNum(2:end-1),Average,'-b')

% Mayra Martinez
% ENGI 1331
% 2074058
% mmart227
% Group #8 "Economic effects of solar energy production and consumption"
% NAE project 

moveon = menu('Would you like to move to next program?', 'Yes', 'No');
c = 1;
while moveon == 0 && c < 5 
    moveon = menu('Would you like to move to next program?', 'Yes', 'No');
    c = c+1;
end
if moveon == 2 || moveon == 0 
    error('program terminated')
end
%% Name: ETHAN 

%Price Finder for Companies the Summary of this function is below
%The function will alow the user to select the state then the function will
%output the total price it costs to create solar energy in that state and
%create a list of the 5 most expensive and 5 cheapest state to invest in creating solar energy infrastucture 
%Input = selected State by the user 
%Output = total price of creating solar energy in that state and a list of the 5 most expensive and 5 cheapest state to create solar energy is created.

[num,txt,raw] = xlsread('workersolarcosts.xlsx');
States = txt(:,2);
States(1,:)=[];
DevelopmentCost = num(:,4);
EPCCost = num(:,5);
StateSelector = menu('Choose a State:', States);
StateID = StateSelector-1;

[StateDevCost,StateEPCCost,CheapestDevCosts,CheapestEPCCosts,...
    MostExpensiveDevCosts,MostExpensiveEPCCosts,MatrixCosts, TotalPrice] = PriceFinder(StateID,EPCCost,DevelopmentCost);
disp(MatrixCosts);
disp(TotalPrice);
% Name: ETHAN
moveon = menu('Would you like to move to next program?', 'Yes', 'No');
c = 1;
while moveon == 0 && c < 5 
    moveon = menu('Would you like to move to next program?', 'Yes', 'No');
    c = c+1;
end
if moveon == 2 || moveon == 0 
    error('program terminated')
end
%% Name: Preston Satterfield
% cougarnet : pdsatter
% UH ID : 1972081
% NAE project


% Load Data/ inputs
% load data and create arrays
[numbers,String,Raw] = xlsread('ConsumptionDataUSA.xlsx');
yearData = numbers(:,1);
consumptionData = numbers(:,2);

% Take inputs (round to make them ints)
prediction = [0,5,10];
desiredPredictionRange = menu('Predict how many years? ', num2cell(prediction));
desiredPredictionRange = prediction(desiredPredictionRange);

% Function Call
[newYearData, expData, r2] = updateConsumption(...
    yearData,consumptionData,desiredPredictionRange);


% PLOT
% Plot Exponential line first
% Plot Normal line next


x = newYearData;
y = expData;
scatter(x,y)

title('US Energy Consumption Per Year')
xlabel('Year');
ylabel('Consumption [TWh]');
hold on  % allows multiple lines on same graph

x1 = yearData;
y1 = consumptionData;
scatter(x1,y1)

legend('Exponential Growth', 'Actual Data')
hold off

% Calculate Growth
% Percent change Formula: pChange = ((new - old)/ old) * 100%
growthPercent = 100 * (expData(end) - consumptionData(end))/ consumptionData(end);
chgYears = newYearData(end) - yearData(end);

% Print Results
fprintf('US solar energy consumption is estimated to be %0.3f [TWh] by the year %0.0f based on Exponential approximations. \n',...
    expData(end),newYearData(end))
fprintf('A Exponential graph has an R^2 value of %0.2f. \n', r2)
fprintf('In %0.0f the US solar energy consumption was %0.2f [TWH] and in %0.0f it was %0.2f [TWH]. \n',...
    yearData(end), consumptionData(end), yearData(end-chgYears), consumptionData(end-chgYears))
fprintf('From %0.0f to %0.0f, a growth of %0.2f%% is expected in a span only %0.0f years! \n',...
    yearData(end), newYearData(end), growthPercent, chgYears)

%
% Name: Preston Satterfield
% cougarnet : pdsatter
% UH ID : 1972081
% NAE project

moveon = menu('Would you like to move to next program?', 'Yes', 'No');
c = 1;
while moveon == 0 && c < 5 
    moveon = menu('Would you like to move to next program?', 'Yes', 'No');
    c = c+1;
end
if moveon == 2 || moveon == 0 
    error('program terminated')
end

%% Name: Diego
% code that gives the TWh(terawatt-hours) for the energy and country that
% was selected, for only 2019
[NUM,TXT,RAW] = xlsread('NAE_ProjectDataRenewableEnergyGenerationWorld2019.xlsx');

E=0;
C=0;
S=0;
[S] = TWh_Generated(C,E);
%outputs the TWh generated from the country and energy chosen
fprintf('The TWh outputted by the country and choice of energy you selected in 2019 was %s \n',S)

moveon = menu('Would you like to move to next program?', 'Yes', 'No');
c = 1;
while moveon == 0 && c < 5 
    moveon = menu('Would you like to move to next program?', 'Yes', 'No');
    c = c+1;
end
if moveon == 2 || moveon == 0 
    error('program terminated')
end
% Diego
%% Name: Jaskaran Singh
%Nae project:
%Name: Jaskaran Singh 
%Cougarnet: jsingh34
%UH ID: 2027724

%Purpose and Questions this code is trying to answer:
% what state is best for purchasing a solar system?  
% Wha is the cost for installing a solar system?
% savings from switching from standard electricity to solar
%Would solar energy be economically sustainable for long time? 
%What are the Cost savings in power bill?  

%% Initial average cost of a 6kW solar system to decide if one wants to consider purchasing a solar system in the specific state.
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
