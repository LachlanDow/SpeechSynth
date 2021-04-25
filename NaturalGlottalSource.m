classdef NaturalGlottalSource
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x %current outputvalue
        a %filter coefficients 
        b %filter coefficients
        openPhaseLength % open phaseration and sample rate provideds open phase length
        positionInPeriod %current period position
    end
    
    methods
        function obj = NaturalGlottalSource(number)
            %NaturalGlottalSource Construct an instance of this class
            number = 0;
            obj  = startPeriod(obj,number);
        end
        
        function obj = startPeriod(obj,openPhaseLength)
            %startPeriod starts a new period for the natual glottal source
            obj.openPhaseLength = openPhaseLength;
            obj.x = 0;
            amplification = 2;
            bTemp = -amplification / openPhaseLength ^ 2;
            obj.b = bTemp;
            obj.a = -bTemp * openPhaseLength / 3;
            obj.positionInPeriod = 1;
        end
        
        function [obj, y] = getNext(obj)
            %getNext gets the next output vaule from the source
            obj.positionInPeriod = obj.positionInPeriod +1;
            if (obj.positionInPeriod  >= obj.openPhaseLength) 
                obj.x = 0;
            else
                obj.a = obj.a + obj.b; % first calculation
                obj.x = obj.x + obj.a;   %second calculation
            end 
            y = obj.x;
       end
    end
end

