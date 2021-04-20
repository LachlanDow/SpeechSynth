classdef DifferencingFilter
    %DifferencingFilter class to represent the differencing filter in the
    %klatt cascade/parallel model
    
    properties
        x1
    end
    
    methods(Static)
         function obj = DifferencingFilter()%Constructor
            obj.x1 = 0;     
         end
        
        function [x,y] = getTransFuncCoef()
           x = [1 -1];
           y = 1;
        end
        
        function [obj, y] = step(obj,x) % step to next char
             y = x - obj.x1;
             obj.x1 = x;
        end
        
    end
end

