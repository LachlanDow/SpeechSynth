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
   cascadeAspitrationMod
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
    
    
 
end

