classdef NaturalGlottalSource
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x
        a
        b
        openPhaseLength
        positionInPeriod
    end
    
    methods
        function obj = NaturalGlottalSource(number)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            number = 0;
            obj  = startPeriod(obj,number);
        end
        
        function obj = startPeriod(obj,openPhaseLength)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.openPhaseLength = openPhaseLength;
            obj.x = 0;
            amplification = 5;
            bTemp = -amplification / openPhaseLength ^ 2;
            obj.b = bTemp;
            obj.a = -bTemp * openPhaseLength / 3;
            obj.positionInPeriod = 1;
        end
        
        function [obj, y] = getNext(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.positionInPeriod = obj.positionInPeriod +1;
            if (obj.positionInPeriod  >= obj.openPhaseLength) 
                obj.x = 0;
            else
                obj.a = obj.a + obj.b;
                obj.x = obj.x + obj.a;   
            end 
            y = obj.x;
       end
    end
end

