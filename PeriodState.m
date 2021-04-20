classdef PeriodState
    %PeriodState clas represents the currect state of the synthesiser 
    %  these values are altered every period run by the generator class
    
    properties
        f0
        periodLength
        openPhaseLength
        
        positionInPeriod
        lpNoise
    end 
end

