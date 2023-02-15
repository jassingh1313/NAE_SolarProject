function [Max,Min,AVG,HighestPrice,LowestPrice] = PriceperYear(TwentyYears,PricesYear)
  % The function is to review the selected user's years and find the
  % maximum value withing the range
  Max = max(PricesYear);
  Min= min(PricesYear);
  AVG = mean(PricesYear);
 
  [r] = find(PricesYear == Max);
  HighestPrice = TwentyYears(r);
  
  [r2] = find(PricesYear == Min);
  LowestPrice = TwentyYears(r2);
 

end

