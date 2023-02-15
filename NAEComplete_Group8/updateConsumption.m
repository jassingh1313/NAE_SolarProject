function [newYearData, expData, r2] = updateConsumption(year,...
    consumption,predictForward) 
%{
%% DESCRIPTION
    
% Name: Preston Satterfield
% cougarnet : pdsatter
% UH ID : 1972081
% NAE project

% PURPOSE:
% Predict the growth in consumption of solar energy.  This function will
% produce an vector of new values based on an exponential growth formula 
% and then calculate the corresponding R^2 value.

% ASSUMPTIONS:
% year and consumption are vectors, predictForward is an integer
% Length of year == length of consumption
% years are positive
% consumption is positive (consumption > 0)
% predictForward is positive

% OUTPUTS:
% newYearData: Years + number of future years wanted to predict
% expData: Values predicted from exponential model
% r2: R^2 value, shows correlation between exponential data and actual data


% INPUTS:
% year: vector of years i.e. [1980,1981,..., 2005,2006]
% consumption: known values of consumption datas in US (or other country if
% wanted)
% predictForward: How far into future to predict

% FORMULA FOR EXPONENTIAL:
% Pn = P0(1+r)^n

%% ALGORITHM: 
% STEP 0: Check assumptions
% STEP 1: initiate vectors and variables:
% STEP 2: REMOVE INITIAL ZEROS FROM CALCULATIONS
% STEP 3: Calculate r
% STEP 4: Append extra years to end of year vector
% STEP 5: Calculate new values using exponential function
% STEP 6: CALCULATE R^2

%}

%% CODE STARTS
% STEP 0: Check consumption and year vectors have same length
% check if vector and check if they both are same length
if length(consumption) ~= length(year) || length(consumption) == 1
    error('consumption and year must be VECTORS with SAME LENGTH');
elseif predictForward < 0
    error('Prediction cannot be negative');
end
% check consumption is positive
if sum(0 > consumption) ~= 0
    error('Consumption has a value less than zero');
end
% Checks years are positive
if sum(0 > year) ~=0 
    error('Years cannot be negative');
end

% STEP 1: initiate vectors and variables:

% Initiate vectors:
% NewYearData size of year + range
% expData size of consumption + range

r2 = 1;
newYearData = [year; zeros(predictForward,1)];
expData = zeros(length(consumption)+predictForward,1);

% Initiate Variables:
% Pn = end result, initiate it as last value in input vector
% P0 = starting value, set it as first value, will change to first non-zero
% element later
% n = total years, initiate as total years, remove years with value of zero later

Pn = consumption(end); % sets Pn = to end value, used to find r
P0 = consumption(1);
n = length(consumption) - 1;

% STEP 2: REMOVE INITIAL ZEROS FROM CALCULATIONS

% Loop goes through until first non-zero value is found
% i will later be used to index first value of non-zero, so i = 0 means
% starting value ~= 0
i = 1;
numZeros = 0;
while consumption(i) == 0 && (i) <= length(consumption)
    i = i + 1; 
    numZeros = numZeros + 1; % Counts how many nonzeros are in beginning of vector
end
P0 = consumption(i+1);  % Sets P0 as first non-zero value
n = n - i;  % takes out all the initially zero years from total years
    
    % expData(1:i) = 0; % keeps all zero values as zero % TEST AND DELETE, USELESS

%numZeros = i-1; % sets numZeros to how many initial zero values 
% STEP 3: Calculate r
% FIND r using Pn P0 and n 
% FORMULA r = ((Pn/P0)^(1/n)) -1
% Formula found from Pn = P0 * (r + 1)^n

r = ((Pn/P0)^(1/n)) -1;

% STEP 4: Append extra years to end of year vector

endYear = year(end); % last year in vector
yearLength = length(year); % Length of vector 'year'

% loop uses increments and appends last year in vector 'predictForward' times
j=1;
while j<= predictForward
    newYearData(yearLength+j) = (endYear + j); 
    j = j+1;
end

% STEP 5: Calculate new values using exponential function

% FORMULA FOR EXPONENTIAL
% Pn = P0(1+r)^n



% WHILE LOOP calculates Pn for each year
% *calculates numbers after the initial zeros* (if P0 = 0 all values = 0)
j = numZeros + 1; % j starts with first non-zero value
n = 0; % (first year - first year = 0, so n = 0), it increments every year
while j <= length(newYearData) 
    %       Pn = P0(1+r)^n
    expData(j) = P0*((1+r)^(n));
    
    n = n+1; % Increments n, n is number of years from original year
    j = j+1; % Increment j to proceed w/ loop: DO NOT DELETE
end

% STEP 6: CALCULATE R^2
% x = years
% y = consumption
% y2 = expData

% squared error of line: sError = (y-y2)^2
% squared mean for y: sMean = (y-mean(y))^2

% R^2: R2 = 1 - (sum(sError) / sum(sMean))

y = consumption;
y2 = expData(1:length(y));
yMean = mean(y);

sError = zeros(1,length(y));
sMean = zeros(1,length(y));

for i = 1:length(consumption)
    % sError
    sError(i) = (y(i)-y2(i))^2;
    
    % sMean
    sMean(i) = (y(i)-yMean)^2;
end

sErrorTotal = sum(sError);
sMeanTotal = sum(sMean);

r2 = 1 - (sErrorTotal/ sMeanTotal);


end