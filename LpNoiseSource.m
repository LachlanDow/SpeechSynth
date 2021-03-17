classdef LpNoiseSource
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lpFilter
    end
    
    methods
        function obj = LpNoiseSource(sampleRate)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            oldB = 0.75;
            oldSampleRate = 10000;
            
            f = 1000;
            g = (1 - oldB) / sqrt(1 - 2 * oldB * cos(2 * pi * f / oldSampleRate) + oldB ^ 2);
            extraGain = 2.5 * (sampleRate / 10000) ^ 0.33; 
            
            obj.lpFilter = LpFilter1(sampleRate);
            obj.lpFilter = obj.lpFilter.set(f, g, extraGain);
            
        end
        
        function [obj,outputValue] = getNext(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            x = getWhiteNoise();
            [obj.lpFilter,outputValue] = obj.lpFilter.step(x);
            
        end
    end
end

