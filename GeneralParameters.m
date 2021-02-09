classdef GeneralParameters
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        maxOralFormants = 6;
        glottalSourceType = GlottalSourceType.natural;
        sampleRate = 44100;
    end
    
    methods
        function obj = GeneralParamters(obj)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
           obj.maxOralFormants = 6;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

