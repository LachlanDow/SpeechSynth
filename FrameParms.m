classdef FrameParms
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
   duration         %Frame Duration(sec)
   f0               %fundamental Frequency
   flutterLevel
   openPhaseRatio
   breathinessDb
   tiltDb
   gainDb
   agcRmsLevel
   nasalFormantFreq
   nasalFormantBW
   oralFormantFreq
   oralFormantBW
   
   %Parameters for the cascade synth
   cascadeEnabled
   cascadeVoicingDb
   cascadeAspirationDb
   cascadeAspirationMod
   nasalAntiformantFreq
   nasalAntiformantBW
   
    %Parameters for the parallel synth
   parallelEnabled                   
   parallelVoicingDb                 
   parallelAspirationDb  
   parallelAspirationMod          
   fricationDb                 
   fricationMod                      
   parallelBypassDb                   
   nasalFormantDb                     
   oralFormantDb                      
    end
    
   methods
    function obj = FrameParms(f0,cascadeEnabled,parallelEnabled)
            obj.duration =0.005;
            obj.f0 = f0;
            obj.flutterLevel = 0.25;
            obj.openPhaseRatio = 1;
            obj.breathinessDb = 0;
            obj.tiltDb = 0.01;
            obj.gainDb = 10;
            obj.agcRmsLevel = 0.5;
            obj.oralFormantFreq = (1:4);
            obj.oralFormantBW = (1:4);
            obj.nasalFormantFreq = [];
            obj.nasalFormantBW = [];
            
            obj.cascadeEnabled = cascadeEnabled;
            obj.cascadeVoicingDb = 0;
            obj.cascadeAspirationDb  = 0;
            obj.cascadeAspirationMod = 1;
            obj.nasalAntiformantFreq = [];
            obj.nasalAntiformantBW = [];
            
            obj.parallelEnabled = parallelEnabled;                  
            obj.parallelVoicingDb = 52;                 
            obj.parallelAspirationDb  = 0;
            obj.parallelAspirationMod = 31;    
            obj.fricationDb = 0;                
            obj.fricationMod = 0;                   
            obj.parallelBypassDb =0;                
            obj.nasalFormantDb = [];                    
            obj.oralFormantDb = [0,0,0,0,0,0];
            
            
        end
   
   end
   
    
 
end

