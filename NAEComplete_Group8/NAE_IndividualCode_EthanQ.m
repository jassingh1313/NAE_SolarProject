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
    MostExpensiveDevCosts,MostExpensiveEPCCosts] = PriceFinder(StateID,EPCCost,DevelopmentCost)