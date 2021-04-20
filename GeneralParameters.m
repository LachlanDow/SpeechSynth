classdef GeneralParameters
    %GeneralParameters class to represent the main parameters for the
    %synthesiser
    
    properties
        maxOralFormants = 6; %%number of formants currently running on the synth
        glottalSourceType = GlottalSourceType.natural; %%excitation device
        sampleRate = 44100;
    end
    
    methods
        function obj = GeneralParamters(obj)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
           obj.maxOralFormants = 6;
        end
        
     
    end
end

