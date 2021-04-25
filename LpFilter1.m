classdef LpFilter1
    %LPFilter1 Represets a low pass filter 
    %   given an inpuit signal will run a lowpass calculation on it
    
    properties
        sampleRate %of synthesiser
        a %filter coefficients
        b %filter coefficients
        y1 % previous outut value 
        passthrough
        muted
 
    end
    
    methods
        function obj = LpFilter1(sampleRate)
            %construtor Construct an instance of obj LpFilter1
            obj.sampleRate = sampleRate;
            obj.y1 = 0;
            obj.passthrough = true;
            obj.muted = false;
            
            
        end
        
        function obj = set(obj,f,g,extraGain)
            %set sets the value for the low pass filter
            %   checks that values are as expected - throws error if not
            %extraGain should = 1 :) 
            if (f <=0 || f >= obj.sampleRate / 2 || g <= 0 || g >=1 ||  isinf(f) || isinf(g) || isinf(extraGain) )
                error("Invalid Filter Parametes")
            end
            w = 2 * pi * f / obj.sampleRate;
            q = (1 - g ^ 2 * cos(w)) / (1 - g ^ 2);
            obj.b = q - sqrt(q ^ 2 - 1);
            obj.a = (1 - obj.b) * extraGain;
            obj.passthrough = false;
            obj.muted = false; 
        end
        
        function obj = setPassthrough(obj)% turns lowpass filter into pass through mode
           obj.passthrough = true;
           obj.muted = false;
           obj.y1 = 0;
        end  
        
        function obj = setMute(obj) % mutes low pass filter
           obj.passthrough = false;
           obj.muted = true;
           obj.y1 = 0;
        end
        
        
        %% steps value for low-pass filter for next computation
        function [obj, y] = step(obj,x)
            if(obj.passthrough == true)
                y = x;
            elseif(obj.muted == true)
                 y =0;
            else
            y = obj.a * x + obj.b * obj.y1; %calculation for low pass filter
            obj.y1 = y;
            
            end
             
        end
    end
end

