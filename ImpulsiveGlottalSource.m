classdef ImpulsiveGlottalSource
    %UNTITLED7 Generates a glottal source signal LP filtering a pulse
    %
    
    properties
        sampleRate
        resonator
        positionInPeriod
        
    end
    
    methods
        function obj = ImpulsiveGlottalSource(sampleRate)
            %UNTITLED7 Construct an instance of this class
            %   Detailed explanation goes here
            obj.sampleRate = sampleRate;
            obj.resonator = [];
        end
        
        function obj = startPeriod(obj,openPhaseLength)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if(isempty(openPhaseLength))
                obj.resonator = [];
            end  
            if(isempty(obj.resonator))
                obj.resonator = Resonator(obj.sampleRate);
            end
           bw = obj.sampleRate / openPhaseLength;
           obj.resonator = obj.resonator.set(100,bw,1);
           obj.resonator = obj.resonator.adjustImpulseGain(1);
           obj.positionInPeriod = 1;
            
        end
        
        function [obj,y] = getNext(obj)
            if(isempty(obj.resonator))
                y = 0;
            else
                if obj.positionInPeriod == 1
                    pulse = 1;
                elseif obj.positionInPeriod == 2
                    pulse = -1;
                else
                    pulse =0;
                end
           
            obj.positionInPeriod = obj.positionInPeriod + 1;
            [obj.resonator,y] = obj.resonator.step(pulse);
            
            end
        end
        
           
    end
end

