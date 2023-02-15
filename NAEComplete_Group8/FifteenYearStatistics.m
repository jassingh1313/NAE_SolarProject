function [Savings, Profit] = FifteenYearStatistics(StandardElecCost, SolarCost1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Savings = StandardElecCost*(180);
if Savings > SolarCost1
    Profit = Savings-SolarCost1;
    fprintf('\n\nAnd you will save $%0.2f over a period of 15 years by switching to solar.!', Savings);
    fprintf('\n The profit is $%0.2f over time period', Profit);
else
    fprintf('\n\nAnd you will save $%0.2f over a period of 15 years by switching to solar.!', Savings);
    fprintf('\n over a larger period of time, the savings will be greater.');
end

end

