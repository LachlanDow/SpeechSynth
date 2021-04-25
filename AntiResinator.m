classdef AntiResinator
    %UNTITLED3 klatt antiresinator
    
    properties
        sampleRate
        a  %filter coefficient a 
        b  %filter coefficient b 
        c  %filter coefficient c 
        x1 %x[n-1], last input value
        x2 %x[n-2], second-last input value
        passthrough
        muted 
    end
    
    methods
       function obj = AntiResinator(sampleRate)
           %constructor for antiresonator object
            obj.sampleRate = sampleRate;
            obj.x1=0;
            obj.x2=0;
            obj.passthrough = true;
            obj.muted = false;
       end
        
        
        function obj = set(obj,f,bw) 
            % Adjusts the filter parameters without resetting the inner state.
            % @param f
            %    Frequency of anti-resonator in Hz.
            % @param bw
            %    bandwidth of anti-resonator in Hz.
             if (f <=0 || f >= obj.sampleRate / 2 ||bw <=0 ||  isinf(f) || isinf(bw))
                error("Invalid AntiResonator Parametes")
            end
             r = exp(- pi * bw / obj.sampleRate);
             w = 2 * pi * f / obj.sampleRate;
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
        obj.passthrough = true;
        obj.muted = false;
        obj.x1 = 0;
        obj.x2 = 0;
        end
        
        function obj = setMute(obj)
            obj.passthrough = false;
            obj.muted = true;
            obj.x1 = 0;
            obj.x2 = 0;
        end 
        
      
        function [obj,y] = step(obj,x)
            % Performs a filter step.
            % @param x
            %    Input signal value.
            % @returns
            %    Output signal value.
            if obj.passthrough == true
                y = x;
            elseif obj.muted == true
                y = 0;
            else 
                y = obj.a * x + obj.b * obj.x1 + obj.c * obj.x2; %anti-resonator calculation a * x[n] + b * x[n-1] + c * x[n-2]
                obj.x2 = obj.x1;
                obj.x1 = x;
            end       
        end
    end
end

