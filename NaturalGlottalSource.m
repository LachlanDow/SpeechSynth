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
            obj  = startPeriod(obj,number);
        end
        
        function obj = startPeriod(obj,number)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.openPhaseLength = number;
            obj.x = 0;
            amplification = 5;
            bTemp = -amplification / number ^ 2;
            obj.b = bTemp;
            obj.a = - bTemp * number / 3;
            obj.positionInPeriod = 0;
        end
        
        function [obj, x] = getNext(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if (obj.positionInPeriod + 1 >= obj.openPhaseLength) 
                obj.x = 0;
            else
                obj.a = obj.a + obj.b;
                obj.x = obj.x + obj.a;   
                x = obj.x;
            end 
            disp("worked")
       end
    end
end

