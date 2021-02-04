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
            obj.fState = CurrentFrameParameters;
            obj.absPosition = 0;
            obj.tiltFilter = LpFilter1(mainParms.sampleRate);
            obj.flutterTimeOffset = Resonator(mainParms.sampleRate);
            obj.outputLpFilter = Resonator(mainParms.sampleRate);
            obj.outputLpFilter = obj.outputLpFilter.set(0,mainParms.sampleRate/2,1);
            obj.initGlottalSource()
            
            obj.ASC = LpNoiseSource(mainParms.sampleRate);
            obj.ASP = LpNoiseSource(mainParms.sampleRate);
            obj.FSP = LpNoiseSource(mainParms.sampleRate);
            
            obj.NFC = Resonator(mainParms.sampleRate);
            obj.NAFC = AntiResinator();
            obj.OFC = Resonator(mainParms.sampleRate);
            
            for i = 1:mainParms.maxOralFormants
                obj.OFC(i) = Resonator(mainParms.sampleRate);
            end
            
            obj.NFP = Resonator(mainParms.sampleRate);
            obj.OFP = Resonator(mainParms.sampleRate);
            for k = 1:mainParms.maxOralFormants
                obj.OFP(k) = Resonator(mainParms.sampleRate);
            end
            
            obj.DFP = DifferencingFilter();
        end
        
        function obj = generateFrame(obj,fParmsIn,outBuf)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if(fParmsIn == obj.fParms)
                error "Frame Parms must be different"
            end
            obj.newFParms = fParmsIn;
            
            while outPos < outBuf.length
                if (obj.pState ~= PeriodState || obj.pState.positionInPeriod >= obj.pState.periodLength)
                    obj.stertNewPeriod()
                end
          
           outBuf(outPos) = obj.computeNextOutputSignalSample();
           obj.pState.positionInPeriod = obj.pState.positionInPeriod + 1;
           obj.absPosition = obj.absPosition + 1;
           end
           if (isnumeric(fParmsIn.gainDb))
            adjustSignalGain(outBuf,fParmsIn.agcRmsLevel)
           end   
        end
        
        function obj = computeNectOutputSignalSample(obj)
            
        end
        
        function obj = initGlottalSource()
            
        end
    end
end
