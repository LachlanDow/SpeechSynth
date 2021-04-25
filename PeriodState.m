classdef PeriodState
    %PeriodState class represents the currect state of the synthesiser 
    %  these values are altered every period run by the generator class
    
    properties
        f0 %fundamental frequency
        periodLength %length of glottal period from sample rate 
        openPhaseLength % length of glottal opening in from openphase ratio of period
        
        positionInPeriod
        lpNoise % low pass noise source
    end 
end

