function outBuf = generateSound(mParms,fParmsA)
    generator = Generator(mParms);
    disp(generator)

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
        frameBuf = outBuf(outBufPos:outBufPos + frameLen -1);
        
        [generator,outBuf] = generator.generateFrame(fParms,frameBuf);
        outBufPos = outBufPos + frameLen;
    end
    

end

