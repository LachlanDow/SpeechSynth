function outBuf = generateSound(mParms,fParmsA)
    generator = Generator(mParms);

    outBufLen = 0;
    for i = (1:length(fParmsA))
        fParms = fParmsA(i);
        outBufLen = outBufLen +  round(fParms.duration*mParms.sampleRate);
    end
    outBuf = (1:outBufLen);
    outBufPos = 1;
    for i = (1:length(fParmsA))
        fParms = fParmsA(i);
        frameLen = round(fParms.duration * mParms.sampleRate);
        frameBuf = zeros(1,frameLen);
        
       [generator,tempOut] = generator.generateFrame(fParms,frameBuf);
       
      for n = (outBufPos:outBufPos + frameLen-1)
          outBuf(n) = tempOut(n+1-outBufPos);
      end
      
        outBufPos = outBufPos + frameLen;
    end
end

