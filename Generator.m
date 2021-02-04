classdef Generator
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mParms
        fParms
        newFParms
        fState
        pState
        absPosition
        tiltFilter
        outputLpFilter
        flutterTimeOffset
        
        
        %Glottal Sources
        IGS %Impulsive GLottal Source
        NGS %Natural Glottal source
        glottalSource %glottal Source
        
        %Noise Sources
        ASC %aspiration in cascadebranch
        ASP % aspiration in the parallel branch 
        FSP % frication in parallel branch
        
        
        %cascade variables
        NFC % nasal formant filter for cascade synth
        NAFC% nasal antiformant filter for cascade synth
        OFC % oral formant filter for cascade branch
        
        
        %parallel variable
        NFP %nasal formant filter for the parallel branch
        OFP %oral formant filters for parallel branch
        DFP %differencing filter for the parallel branch
    end
    
    methods
        function obj = Generator(mainParms)
            %UNTITLED7 Construct an instance of this class
            %   Detailed explanation goes here
            obj.mParms = mainParms;
            obj.fState = FrameState;
            obj.absPosition = 0;
            obj.tiltFilter = LpFilter1(mainParms.sampleRate);
            obj.flutterTimeOffset = Resonator(mainParms.sampleRate);
            obj.outputLpFilter = resonator(mainParms.sampleRate);
            obj.outputLpFilter = obj.outputLpFilter.set(0,mainParms.sampleRate/2);
            
            obj.ASC = LpNoiseSource(mainParms.sampleRate);
            ibj.ASP = LpNoiseSource(mainParms.sampleRate);
            obj.FSP = LpNoiseSource(mainParms.sampleRate);
            
            obj.NFC = Resonator(mainParms.sampleRate);
            obj.NAFC  AntiResinator(mainParms.sampleRate);
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

