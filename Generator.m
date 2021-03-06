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
        IGS%Impulsive GLottal Source
        NGS  %Natural Glottal source
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
        OFP  %oral formant filters for parallel branch
        DFP  %differencing filter for the parallel branch
    end
    
    methods
        function obj = Generator(mainParms)
            %UNTITLED7 Construct an instance of this class
            %   Detailed explanation goes here
            obj.mParms = mainParms;
            obj.fState = CurrentFrameParameters;
            obj.absPosition = 1;
            obj.tiltFilter = LpFilter1(mainParms.sampleRate);
            obj.flutterTimeOffset = rand(1,1) * 1000;
            obj.outputLpFilter = Resonator(mainParms.sampleRate);
            obj.outputLpFilter = obj.outputLpFilter.set(0,mainParms.sampleRate/2,1);
            obj = obj.initGlottalSource();
            
            obj.ASC = LpNoiseSource(mainParms.sampleRate);
            obj.ASP = LpNoiseSource(mainParms.sampleRate);
            obj.FSP = LpNoiseSource(mainParms.sampleRate);
            
           
            obj.NFC = Resonator(mainParms.sampleRate);
            obj.NAFC = AntiResinator(mainParms.sampleRate);
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
        
        function [obj,outArr] = generateFrame(obj,fParmsIn,outBuf)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
         
            
            obj.newFParms = fParmsIn;
            
            outPos = 1;
            outArr = outBuf;
            
            while (outPos < length(outArr)+1)
                if (isempty(obj.pState.f0) || (obj.pState.positionInPeriod >= obj.pState.periodLength))
                    obj = obj.startNewPeriod();
                end
           [obj, outArr(outPos)] = obj.computeNextOutputSignalSample();
           obj.pState.positionInPeriod = obj.pState.positionInPeriod + 1;
           obj.absPosition = obj.absPosition + 1;
           outPos = outPos + 1;       
            end
           
           if (isnumeric(obj.fParms.gainDb) == 1)
             outArr =  obj.adjustSignalGain(outArr,obj.fParms.agcRmsLevel);
           end   
        end
        
        
        function [obj,out] = computeNextOutputSignalSample(obj)
             voice = obj.glottalSource;
             
             [obj.tiltFilter,voice] = obj.tiltFilter.step(voice);
             if(obj.pState.positionInPeriod < obj.pState.openPhaseLength)
                 voice = voice + (getWhiteNoise() * obj.fState.breathinessLin);
             end
             
             if(obj.fParms.cascadeEnabled == true)
                 [obj,cascadeOut] = obj.computeCascadeBranch(voice);
             else
                 cascadeOut = 0;
             end
             
             if(obj.fParms.parallelEnabled == true)
                 [obj,parallelOut] = obj.computeParallelBranch(voice);
             else
                 parallelOut = 0;
             end
             
             out = cascadeOut+ parallelOut;
             [obj.outputLpFilter,out] = obj.outputLpFilter.step(out);
             out = out * obj.fState.gainLin;
             
        end
        
        function [obj,v] = computeCascadeBranch(obj,voice)          
             cascadeVoice = voice * obj.fState.cascadeVoicingLin;
             
             if (obj.pState.positionInPeriod >= obj.pState.periodLength / 2) 
                currentAspirationMod = obj.fParms.cascadeAspirationMod; 
             else
                currentAspirationMod =   0;
             end
             
             [obj.ASC, outputVal] = obj.ASC.getNext();
             aspiration = outputVal * obj.fState.cascadeAspirationLin * (1 - currentAspirationMod);
             v = cascadeVoice + aspiration;
             [obj.NAFC, v] = obj.NAFC.step(v);
             [obj.NFC, v] = obj.NFC.step(v);
             
             for i = 1:obj.mParms.maxOralFormants
                [obj.OFC(i), v] = obj.OFC(i).step(v);
             end
             
        end
        
        function [obj,v] = computeParallelBranch(obj,voice)
            obj.fParms = obj.fParms;
            obj.fState = obj.fState;
            obj.pState = obj.pState;
            
            parallelVoice = voice * obj.fState.parallelVoicingLin;
            
            if (obj.pState.positionInPeriod >= obj.pState.periodLength / 2)
                currentAspirationMod = obj.fParms.parallelAspirationMod;
            else
                currentAspirationMod = 0;
            end
            
            [obj.ASC, outputVal] = obj.ASC.getNext();
            aspiration = outputVal * obj.fState.parallelAspirationLin * (1-currentAspirationMod);
            source = parallelVoice + aspiration;
            [obj.DFP,sourceDifference] = obj.DFP.step(obj.DFP,source);
            
            if obj.pState.positionInPeriod >= obj.pState.periodLength/2
                currentFricationMod = obj.fParms.fricationMod;
            else
                currentFricationMod = 0;
            end
            
            [obj.FSP,retVal] = obj.FSP.getNext();
            fricationNoise = retVal * obj.fState.fricationLin * (1 - currentFricationMod);
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
            
            v = v + obj.fState.parallelBypassLin * source2;
        end
        
        
        %startNewPeriod,  method to apply new frame parms at the start of a
        %certain period
        function obj = startNewPeriod(obj)
          if (isempty(obj.newFParms) == 0 )
              obj.fParms = obj.newFParms;
              obj.newFParms = [];
              obj = obj.startUsingNewFrameParameters();
          end 
         
          if (isempty(obj.pState) == 1)
              obj.pState = CurrentFrameParameters();
          end

          flutterTime = obj.absPosition / obj.mParms.sampleRate + obj.flutterTimeOffset;
          obj.pState.f0 = performFrequencyModulation(obj.fParms.f0, obj.fParms.flutterLevel, flutterTime);
          
          if obj.pState.f0 > 0
              obj.pState.periodLength = round(obj.mParms.sampleRate / obj.pState.f0);
          else
              obj.pState.periodLength = 1;
          end
          
          
          if obj.pState.periodLength > 1
              obj.pState.openPhaseLength = round(obj.pState.periodLength * obj.fParms.openPhaseRatio);
          else
              obj.pState.openPhaseLength = 0;
          end
          obj.pState.positionInPeriod = 1;
          obj = obj.startGlottalSourcePeriod();
        end
        
        
        %function to change the frame parameters to the using stage 
        function obj = startUsingNewFrameParameters(obj)
            obj.fState.breathinessLin = dbToLin(obj.fParms.breathinessDb);
            obj.fState.gainLin = dbToLin(obj.fParms.gainDb);
            obj = obj.setTiltFilter(obj.fParms.tiltDb);
            
            obj.fState.cascadeVoicingLin = dbToLin(obj.fParms.cascadeVoicingDb);
            obj.fState.cascadeAspirationLin = dbToLin(obj.fParms.cascadeAspirationDb);
            obj = obj.setNasalFormantCasc(obj.fParms);
            obj = obj.setNasalAntiFormantCasc(obj.fParms);
            for i = (1: obj.mParms.maxOralFormants)
                obj = obj.setOralFormantCasc(obj.fParms, i);
            end
            
            obj.fState.parallelVoicingLin = dbToLin(obj.fParms.parallelVoicingDb);
            obj.fState.parallelAspirationLin = dbToLin(obj.fParms.parallelAspirationDb);
            obj.fState.fricationLin = dbToLin(obj.fParms.fricationDb);
            obj.fState.parallelBypassLin = dbToLin(obj.fParms.parallelBypassDb);
            obj = obj.setNasalFormantPar(obj.fParms);
             for i = (1: obj.mParms.maxOralFormants)
                obj = obj.setOralFormantPar(obj.mParms, obj.fParms, i);
            end
        end 
        
        function obj = initGlottalSource(obj)
            switch (obj.mParms.glottalSourceType)
                case 'impulsive'
                    obj.IGS = ImpulsiveGlottalSource(obj.mParms.sampleRate);
                    [obj.IGS,obj.glottalSource] = obj.IGS.getNext();
                    
                case 'natural'
                    obj.NGS = NaturalGlottalSource(obj.mParms.sampleRate);
                    [obj.NGS,x] = obj.NGS.getNext();
                    obj.glottalSource = x;
                case 'noise'
                    obj.glottalSource = getWhiteNoise();
                otherwise
                    error("Undefined glottal source type")
            end
        end
        
        function obj = startGlottalSourcePeriod(obj)
           switch(obj.mParms.glottalSourceType)
               case 'impulsive'
                   obj.IGS = obj.IGS.startPeriod(obj.pState.openPhaseLength);
               case 'natural'
                   obj.NGS = obj.NGS.startPeriod(obj.pState.openPhaseLength);
           end
        
          
        
        end
        
        function obj = setTiltFilter(obj,tiltDb)
            if(isempty(obj.fParms.tiltDb) || obj.fParms.tiltDb == 0)
                
                obj.tiltFilter = obj.tiltFilter.setPassthrough();
            else
                
                obj.tiltFilter =  obj.tiltFilter.set(3000,dbToLin(-tiltDb),1);
            end
        end
        
        function obj = setNasalFormantCasc(obj,fParms)
            
            if (fParms.nasalFormantFreq == 0 || fParms.nasalFormantBW == 0 )
                 obj.NFC = obj.NFC.setPassthrough();
            else
               obj.NFC =  obj.NFC.set(fParms.nasalFormantFreq,fParms.nasalFormantBW,1);
            end
            
        end
        
        function obj = setNasalAntiFormantCasc(obj,fParms)
            if (isempty(fParms.nasalAntiformantFreq) || isempty(fParms.nasalAntiformantBW))
                 obj.NAFC = obj.NAFC.setPassthrough();
            else
                obj.NAFC = obj.NAFC.set(fParms.nasalAntiformantFreq, fParms.nasalAntiformantBW);
            end
            
        end
        
        function obj = setOralFormantCasc(obj,fParms,i)
            if i < length(fParms.oralFormantFreq)
                f = fParms.oralFormantFreq(i);
            else
                f = [];
            end
            
            if i < length(fParms.oralFormantBW)
                Bw = fParms.oralFormantBW(i);
            else
                Bw = [];
            end
            
            if( isempty(f) == 0  && isempty(Bw)== 0 )
                obj.OFC(i) = obj.OFC(i).set(f,Bw,1);
            else
                obj.OFC(i) = obj.OFC(i).setPassthrough();
            end
        end
        
        function obj = setOralFormantPar(obj, mParms, fParms, i)
                formant = i + 1;
                if( i < length(fParms.oralFormantFreq))
                    f = fParms.oralFormantFreq(i);
                else
                   f =[];
                end
                
                if( i < length(fParms.oralFormantBW))
                    bw = fParms.oralFormantBW(i);
                else
                   bw =[];
                end
                
                if( i < length(fParms.oralFormantBW))
                    db = fParms.oralFormantDb(i);
                else
                   db =[];
                end
                
                peakGain = dbToLin(db);
                
                if(isempty(f) == 0 && isempty(bw) ==0 && isempty(peakGain) == 0)
                    obj.OFP(i) = obj.OFP(i).set(f,bw,1);
                w = 2 * pi / obj.mParms.sampleRate;
                diffGain = sqrt(2-2 * cos(w));
                    if(formant >= 2)
                        filterGain = peakGain/diffGain;
                    else
                        filterGain = peakGain;
                    end
                obj.OFP(i) = obj.OFP(i).adjustPeakGain(filterGain);   
                else
                    obj.OFP(i) = obj.OFP(i).setMute();
                end
                
        end
        
        function obj = setNasalFormantPar(obj,fParms)
            if (fParms.nasalFormantFreq == 0 && fParms.nasalFormantBW == 0 && dbToLin(fParms.nasalFormantDb) ==0)
                obj.NFP = obj.NFP.set(fParms.nasalFormantFreq, fParms.nasalFormantBW,1);
                obj.NFP = obj.NFP.adjustPeakGain(dbToLin(fParms.nasalFormantDb));
            else
                obj.NFP = obj.NFP.setMute();
            end
        end
        
        function buf = adjustSignalGain(obj,buf, targetRms)
         n = length(buf);
         rms = computeRms(buf);
            if (isempty(n) ==1)
                buf = buf;
            elseif (isempty(rms) == 1) 
              buf = buf;
            else
            
                r = targetRms / rms;
                
                for i = 1:n 
                    buf(i) = buf(i) * r; 
                end
            end
        end
         
        function obj = setFState(obj)
            obj.fState.breathinessLin = obj.fParms.breathinessDb;
            obj.fState.gainLin = obj.fParms.gainDb;
            
            
             obj.fState.cascadeVoicingLin = obj.fParms.breathinessDb;
            obj.fState.cascadeAspirationLin = obj.fParms.cascadeAspirationDb;
            
            obj.fState.parallelVoicingLin =  obj.fParms.parallelVoicingDb;
            obj.fState.parallelAspirationLin =  obj.fParms.parallelAspirationDb;                                 
            obj.fState.fricationLin =      obj.fParms.fricationDb;       
            obj.fState.parallelBypassLin =   obj.fParms.parallelBypassDb;
        end
        
    end
    
 end


