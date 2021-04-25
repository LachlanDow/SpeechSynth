classdef FrameParms
    %FrameParms class that represents the frame parameters to passed into
    %the synthesiser
    
    properties
   duration         %Frame Duration(sec)
   f0               %fundamental Frequency
   flutterLevel     %F0 flutter level generally 0.25
   openPhaseRatio   %relative length of the open phase of the glottis
   breathinessDb    %breathiness of voicing in Db amplify or reduce
   tiltDb           %spectral tilt for glottal source in dB
   gainDb           %overall gain of system
   agcRmsLevel      %RootMean square level
   nasalFormantFreq %nasal formant frequency in Hz
   nasalFormantBW   %nasal formant Bandwidth in Hz
   oralFormantFreq  %oral formant frequency in Hz
   oralFormantBW    %oral formant bandwidth in Hz
   
   %Parameters for the cascade synth
   cascadeEnabled   %toggles cascade on or off
   cascadeVoicingDb %voicing amplification for cascade branch
   cascadeAspirationDb %aspiration level in dB
   cascadeAspirationMod %Modualtion factor for apiration in cascade
   nasalAntiformantFreq %nasal anti-formant frequency
   nasalAntiformantBW %nasal anti-formant bandwidth
   
    %Parameters for the parallel synth
   parallelEnabled     %toggles parallel on/off              
   parallelVoicingDb     %amplification for parallel branch in dB           
   parallelAspirationDb  %amplification of parallel aspiratoin in dB
   parallelAspirationMod          %parallel aspiration modulation between 0 and 1
   fricationDb                 %frication for parallel branch in dB
   fricationMod                %frication modulation for prallel branch
   parallelBypassDb            %bypass level for parallel branch       
   nasalFormantDb              %nasal formant decibel level for parallel branch
   oralFormantDb               %oral formant frequencies for parallel branch
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

