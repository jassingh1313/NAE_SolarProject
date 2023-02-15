function [StateDevCost,StateEPCCost,CheapestDevCosts,CheapestEPCCosts,MostExpensiveDevCosts,...
    MostExpensiveEPCCosts, MatrixCosts, TotalPrice] = PriceFinder(StateID,EPCCost,DevelopmentCost)

if StateID <= 1 || StateID >= 52
    error("Not valid a StateID number please select a valid state ID number"); 
end

MostExpensiveDevCosts = maxk(DevelopmentCost(:),5);
MostExpensiveEPCCosts = maxk(EPCCost(:),5);
CheapestDevCosts = mink(DevelopmentCost(:),5); 
CheapestEPCCosts = mink(EPCCost(:),5); 
CostsMatrix = [MostExpensiveDevCosts,MostExpensiveEPCCosts,CheapestDevCosts,CheapestEPCCosts]; 
Title={'MostExpensive Development Costs' 'Most Expensive EPC Costs'  'Cheapest Development Costs' 'Cheapest EPC Costs'}
MatrixCosts=[Title;num2cell(CostsMatrix)];
StateDevCost = DevelopmentCost(StateID);
StateEPCCost = EPCCost(StateID);
TotalPrice = StateDevCost+StateEPCCost;

end
