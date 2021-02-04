classdef LpFilter1
    %UNTITLED3 Summary of obj class goes here
    %   Detailed explanation goes here
    
    properties
        sampleRate
        a
        b
        y1
        passthrough
        muted
 
    end
    
    methods
        function obj = LpFilter1(sampleRate)
            %UNTITLED3 Construct an instance of obj class
            %   Detailed explanation goes here
            obj.sampleRate = sampleRate;
            obj.y1 = 0;
            obj.passthrough = true;
            obj.muted = false;
            
            
        end
        
        function obj = set(obj,f,g,extraGain)
            %METHOD1 Summary of obj method goes here
            %   Detailed explanation goes here
            extraGain = 1;
            w = 2 * pi * f / obj.sampleRate;
            q = (1 - g ^ 2 * cos(w)) / (1 - g ^ 2);
            obj.b = q - sqrt(q ^ 2 - 1);
            obj.a = (1 - obj.b) * extraGain;
            obj.passthrough = false;
            obj.muted = false; 
        end
        
        function obj = setPassThrough(obj)
           obj.passthrough = true;
           obj.muted = false;
           obj.y1 = 0;
        end  
        
        function obj = setMute(obj)
           obj.passthrough = false;
           obj.muted = true;
           obj.y1 = 0;
        end  
    end
end

