classdef Generator
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mParms
        fParms
        newFParms
        fState
        pState = PeriodState;
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
            obj.flutterTimeOffset = rand(1,1) * 1000;
            obj.outputLpFilter = Resonator(mainParms.sampleRate);
            obj.outputLpFilter = obj.outputLpFilter.set(0,mainParms.sampleRate/2,1);
            obj = obj.initGlottalSource();
            
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
        
        function [obj,outBuf] = generateFrame(obj,fParmsIn,outBuf)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            obj.newFParms = fParmsIn;
            outPos = 0;
            while outPos < length(outBuf)
                if (exist('obj.pState') ~= 1 || obj.pState.positionInPeriod >= obj.pState.periodLength)
                    obj = obj.startNewPeriod();
                end
          
           outBuf(outPos) = obj.computeNextOutputSignalSample();
           obj.pState.positionInPeriod = obj.pState.positionInPeriod + 1;
           obj.absPosition = obj.absPosition + 1;
           end
           if (isnumeric(fParmsIn.gainDb))
            adjustSignalGain(outBuf,fParmsIn.agcRmsLevel)
           end   
        end
        
        
        function [obj,out] = computeNextOutputSignalSample(obj)
             fParmsIn = obj.fParms;
             fStateIn = obj.fState;
             pStateIn = obj.pState;
             
             voice = obj.glottalSource;
             
             voice = this.tiltFilter.step(voice);
             if(pStateIn.positioninPeriod < pStateIn.openPhaseLength)
                 voice = voice + getWhiteNoise() * fStateIn.breathinessLin;
             end
             
             if(fParmsIn.cascadeEnabled == true)
                 cascadeOut = obj.computeCascadeBranch(voice);
             else
                 cascadeOut = 0;
             end
             
             if(fParmsIn.parallelEnabled == true)
                 parallelOut = obj.computeParallelBranch(voice);
             else
                 parallelOut = 0;
             end
             
             out = cascadeOut+ parallelOut;
             out = obj.outputLpFilter.step(out);
             out = out * fStateIn.gainLin;
             
        end
        
        function [obj,v] = computeCascadeBranch(obj,voice)
             fParmsIn = obj.fParms;
             fStateIn = obj.fState;
             pStateIn = obj.pState;
             
             cascadeVoice = voice * fStateIn.cascadeVoicingLin;
             
             if (pStateIn.positionInPeriod >= pStateIn.periodLength / 2) 
                currentAspirationMod = fParmsIn.cascadeAspirationMod; 
             else
                currentAspirationMod =   0;
             end
             
             aspiration = obj.ASC.getNext() * fStateIn.cascadeAspirationLin * (1 - currentAspirationMod);
             v = cascadeVoice + aspiration;
             [obj.NAFC, v] = obj.NAFC.step(v);
             [obj.NFC, v] = obj.NFC.step(v);
             
             for i = 1:obj.mParms.maxOralFormants
                v = this.OFC(i).step(v);
             end
             
        end
        
        function [obj,v] = computeParallelBranch(obj,voice)
            fParmsIn = obj.fParms;
            fStateIn = obj.fState;
            pStateIn = obj.pState;
            
            parallelVoice = voice * fStateIn.parallelVoicingLin;
            
            if (pStateIn.positionInPeriod >= pStateIn.periodLength / 2)
                currentAspirationMod = fParmsIn.parallelAspirationMod;
            else
                currentAspirationMod = 0;
            end
            aspiration = obj.ASP.getNext() * fstateIn.parallelAspirationLin * (1-currentAspirationMod);
            source = parallelVoice + aspiration;
            sourceDifference = obj.DFP.step(source);
            
            if pStateIn.positionINperiod >= pStateIn.periodLength/2
                currentFricationMod = fParmsIn.fricationMod;
            else
                currentFricationMod = 0;
            end
            
            [obj.FSP,retVal] = obj.FSP.getnext();
            fricationNoise = retVal * fSatateIn.fricationLin * (1 - currentFricationMod);
            source2 = sourceDifference + fricationNoise;
            
            v = 0;
            [obj.NFP,NFPstepVal] =  obj.NFP.step(source);
            [obj.OFP(1),OFPstepVal] =   obj.OFP(1).step(source);
            
            v = v + NFPstepVal;
            v = v + OFPstepVal;
            
            for i = 2:obj.mParms.maxOralFormants
                if (mod(i,2) == 1)
                    alternatingSign = 1;
                else
                    alternatingSign = -1;
                end
                [obj.OFP(i),OFPstepVal] = obj.OFP(i).step(source2);
                v = v + alternatingSign * OFPstepVal;
            end
            
            v = v + fStateIn.parallelByPassLin * source2;
        end
        
        
        %startNewPeriod,  method to apply new frame parms at the start of a
        %certain period
        function obj = startNewPeriod(obj)
          if (obj.newFParms.f0  ~= 0)
              obj.fParms = obj.newFParms;
              obj.newFParms.f0 = 0;
              obj.startUsingNewFrameParameters();
          end 
          debug = obj.pState
          if (obj.pState.f0 == 0)
              obj.pState = CurrentFrameParameters();
          end
          fParmsIn = obj.fParms;
          pStateIn = obj.pState;
          mParmsIn = obj.mParms;
          
          flutterTime = obj.absPosition / mParmsIn.sampleRate + obj.flutterTimeOffset;
          pStateIn.f0 = performFrequencyModulation(fParmsIn.f0, fParmsIn.flutterLevel, flutterTime);
          
          if pStateIn.f0 > 0
              pStateIn.periodLength = round(obj.mParms.sampleRate / pStateIn.f0);
          else
              pStateIn.periodLength = 1;
          end
          
          
          if pStateIn.periodLength > 1
              pStateIn.openPhaseLength = round(pStateIn.periodLength * fParmsIn.openPhaseRatio);
          else
              pStateIn.openPhaseLength = 0;
          end
          pStateIn.positionInPeriod = 0;
          obj.startGlottalSourcePeriod()
        end
        
        
        %function to change the frame parameters to the using stage 
        function obj = startUsingNewFrameParameters(obj)
            mParmsIn = obj.mParms;
            fParmsIn = obj.fParms;
            fStateIn = obj.fState;
            
            fStateIn.breathinessLin = dbToLin(fParmsIn.breathinessDb);
            fStateIn.gainLin = dbToLin(fParmsIn.gainDb || 0);
          %  setTiltFilter(obj.tiltFilter,fParmsIn.tiltDb)
            
            fStateIn.cascadeVoicingLin = dbToLin(fParmsIn.cascadeVoicingDb);
            fStateIn.cascadeAspirationLin = dbToLin(fParmsIn.cascadeAspirationDb);
            %setNasalFormantCasc(this.NFC,fParmsIn)
            %setNasalAntiFormantCasc(obj.NAFC,fParmsIn)
           % for i = (1: mParmsIn.maxOralFormants)
             %   setOralFormantPar(obj.OFP(i), mParmsIn, fParmsIn, i)
            %end
        end 
        
        function obj = initGlottalSource(obj)
            switch (obj.mParms.glottalSourceType)
                case 'impulsive'
                    obj.IGS = ImpulsiveGlottalSource(obj.mParms.sampleRate);
                    obj.IGS = obj.IGS.startPeriod(1);
                    [obj.IGS,obj.glottalSource] = obj.IGS.getNext();
                    
                case 'natural'
                    obj.NGS = NaturalGlottalSource(obj.mParms.sampleRate);
                    obj.NGS = obj.NGS.getNext();
                    obj.glottalSource = obj.NGS.x;
                case 'noise'
                    obj.glottalSource = getWhiteNoise();
                otherwise
                    error("Undefined glottal source type")
            end
        end
        
        function obj = startGlottalSourcePeriod(obj)
           switch(obj.mParms.glottalSourceType)
               case 'impulsive'
                   obj.IGS.startPeriod(this.pState.openPhaseLength)
               case 'natural'
                   obj.NGS.startPeriod(obj.pState.openPhaseLength)
           end
        
          
        
        end
        
        function obj = setTiltFilter(obj,tiltDb)
           obj.NFC =  obj.tiltFilter.set(3000,dbToLin(-tiltDb));
        end
        
        function obj = setNasalFormantCasc(obj,fParms)
            if (isempty(fParms.nasalFormantFreq) || isempty(fParms.nasalFormantBw))
                 obj.NFC = obj.NFC.setPassthrough();
            else
               obj.NFC =  obj.NFC.set(fParms.nasalFormantFreq,fParms.nasalFormantBw);
            end
            
        end
        
        function obj = setNasalAntiformantCasc(obj,fParms)
            if (isempty(fParms.nasalAntiformantFreq) || isempty(fParms.nassalAntiformantBW))
                 obj.NAFC = obj.NAFC.setPassthrough();
            else
                obj.NAFC = obj.NAFC.set(fParms.nasalAntiformantFreq, fParms.nasalAntiformantBw);
            end
            
        end
        
        function obj = setOralFormantCasc(obj,fParms,i)
            if i < fParms.oralFormantFreq.length
                f = fParms.oralFormantFreq(i);
            else
                f = [];
            end
            
            if i < fParms.oralFormantBw.length
                Bw = fParms.oralFormantBw(i);
            else
                Bw = [];
            end
            
            if( isempty(f) && is empty(Bw))
                obj.OFB
            
        end
        
        
            
            
        
        
        
        
        
            
    end
end

