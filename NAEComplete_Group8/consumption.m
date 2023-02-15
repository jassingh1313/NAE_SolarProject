% Name: Preston Satterfield
% cougarnet : pdsatter
% UH ID : 1972081
% NAE project


%% Load Data/ inputs
% load data and create arrays
[numbers,String,Raw] = xlsread('ConsumptionDataUSA.xlsx');
yearData = numbers(:,1);
consumptionData = numbers(:,2);

% Take inputs (round to make them ints)
prediction = [0,5,10];
desiredPredictionRange = menu('Predict how many years? ', num2cell(prediction));
desiredPredictionRange = prediction(desiredPredictionRange);

%% Function Call
[newYearData, expData, r2] = updateConsumption(...
    yearData,consumptionData,desiredPredictionRange);


%% PLOT
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

%% Calculate Growth
% Percent change Formula: pChange = ((new - old)/ old) * 100%
growthPercent = 100 * (expData(end) - consumptionData(end))/ consumptionData(end);
chgYears = newYearData(end) - yearData(end);

%% Print Results
fprintf('US solar energy consumption is estimated to be %0.3f [TWh] by the year %0.0f based on Exponential approximations. \n',...
    expData(end),newYearData(end))
fprintf('A Exponential graph has an R^2 value of %0.2f. \n', r2)
fprintf('In %0.0f the US solar energy consumption was %0.2f [TWH] and in %0.0f it was %0.2f [TWH]. \n',...
    yearData(end), consumptionData(end), yearData(end-chgYears), consumptionData(end-chgYears))
fprintf('From %0.0f to %0.0f, a growth of %0.2f%% is expected in a span only %0.0f years! \n',...
    yearData(end), newYearData(end), growthPercent, chgYears)

writematrix(expData, 'expDataExcel.csv');
%
% Name: Preston Satterfield
% cougarnet : pdsatter
% UH ID : 1972081
% NAE project

