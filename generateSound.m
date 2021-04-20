function outBuf = generateSound(mParms,fParmsA)
%% generateSound function create a sound from a array of frame paramters
% function takes in array of frame paramters and a main parameter and will
% generate sound from these in the from of an array of double values
% representing a signal
    generator = Generator(mParms);

    outBufLen = 0;
    for i = (1:length(fParmsA))% loop for every fram of data (5ms) to calculate length of array
        fParms = fParmsA(i);
        outBufLen = outBufLen +  round(fParms.duration*mParms.sampleRate);
    end
    outBuf = (1:outBufLen);
    outBufPos = 1;
    for i = (1:length(fParmsA)) % loop for every fram of data (5ms)
        %% calculate outputframes
        fParms = fParmsA(i);
        frameLen = round(fParms.duration * mParms.sampleRate);
        frameBuf = zeros(1,frameLen);
        
       [generator,tempOut] = generator.generateFrame(fParms,frameBuf);
       %% add sound to the final output
      for n = (outBufPos:outBufPos + frameLen-1)
          outBuf(n) = tempOut(n+1-outBufPos);
      end
      
        outBufPos = outBufPos + frameLen;
    end
end

