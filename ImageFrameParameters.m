classdef ImageFrameParamters
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
   duration         %Frame Duration(sec)
   f0               %fundamental Frequency
   flutterLevel
   openPhaseRatio
   brethinessDb
   tiltDb
   gainDg
   agcRmsLevel
   NasalFormatFrequency
   NasalFormantBW
   oralFormantFrequency
   oralFormantBW
   
   %Parameters for the cascade synth
   cascadeEnabled
   cascadceVoicingDB
   cascadeAspirationDB
   cascadeAspitrationMod
   nasalAntiFormantFrequency
   
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

