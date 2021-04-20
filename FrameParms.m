classdef FrameParms
    %FrameParms class that represents the frame parameters to passed into
    %the synthesiser
    
    properties
   duration         %Frame Duration(sec)
   f0               %fundamental Frequency
   flutterLevel
   openPhaseRatio 
   breathinessDb
   tiltDb
   gainDb
   agcRmsLevel %RootMean square level
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
            obj.flutterLevel = 0;
            obj.openPhaseRatio = 0.1;
            obj.breathinessDb = -25;
            obj.tiltDb = 0.001;
            obj.gainDb = 0;
            obj.agcRmsLevel = 0.18;
            obj.oralFormantFreq = [0,0,0,3168,4135,5020];
            obj.oralFormantBW = [0,0,0,102,816,596];
            obj.nasalFormantFreq = [];
            obj.nasalFormantBW = [];
            
            obj.cascadeEnabled = cascadeEnabled;
            obj.cascadeVoicingDb = 50;
            obj.cascadeAspirationDb  = -25;
            obj.cascadeAspirationMod = 0.5;
            obj.nasalAntiformantFreq = [];
            obj.nasalAntiformantBW = [];
            
            obj.parallelEnabled = parallelEnabled;                  
            obj.parallelVoicingDb = 50;                 
            obj.parallelAspirationDb  = -25;
            obj.parallelAspirationMod = 0.5;    
            obj.fricationDb = -30;                
            obj.fricationMod = 0.5;                   
            obj.parallelBypassDb =0;                
            obj.nasalFormantDb = [];                    
            obj.oralFormantDb = [0,-8,-15,-19,-30,-35];
    end
       
    
   end
   
    
 
end

