classdef AntiResinator
    %UNTITLED3 klatt antiresinator
    
    properties
        sample_rate
        a
        b
        c
        x1
        x2
        passthrough
        muted 
    end
    
    methods
       function obj = AntiResonator(sample_rate)
            obj.sample_rate = sample_rate;
            obj.y1=0;
            obj.y2=0;
            obj.passthrough = true;
            obj.mute = false;
        end
        
        function obj = set(obj,f,bw)
             r = exp(- pi * bw / obj.sample_rate);
             w = 2 * pi * f / obj.sample_rate;
             c0 = - (r * r);
             b0 = 2 * r * cos(w);
             a0 = 1 - b0 - c0;
            if (a0 == 0) 
                obj.a = 0;
                obj.b = 0;
                obj.c = 0;
            else
                obj.a = 1 / a0;
                obj.b = - b0 / a0;
                obj.c = - c0 / a0;
                obj.passthrough = false;
                obj.muted = false;
            end   
        end
        
        function obj = setPassthrough(obj)
        obj.passthrough = flase;
        obj.muted = true;
        obj.x1 = 0;
        obj.x2 = 0;
        end
        
        function obj = setMute(obj)
            obj.passthrough = false;
            obj.muted = true;
            obj.x1 = 0;
            obj.x2 = 0;
        end 
        
        function [x,y] = getTransferFuncCoef(obj)
            if(obj.passthrough)
                 x = 1;
                 y = 1;
            elseif(obj.muted)
               x = o;
               y = 1;
            else 
               x = [obj.a obj.b obj.c];
               y = 1;
            end
        end
    end
end

