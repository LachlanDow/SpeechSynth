classdef DifferencingFilter
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x1
    end
    
    methods(Static)
         function obj = DifferencingFilter()
            obj.x1 = 0;     
         end
        
        function [x,y] = getTransFuncCoef()
           x = [1 -1];
           y = 1;
        end
        
        function [obj, y] = step(obj,x)
             y = x - obj.x1;
             obj.x1 = x;
        end
        
    end
end

