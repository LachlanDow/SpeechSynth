function  out = getVocalTractTransferFunctionCoefficients(mParms,fParms)
eps = 1E-10;
voice = [1,1];
tiltFilter = LpFilter1(mParms.sampleRate);
tiltFilter = setTiltTilterGen(tiltFilter,fParms.tiltDb);
tiltTrans = tiltFilter.getTransferFuncCoef();

voice = multiplyFractions(voice,tiltTrans,eps);

if (fParms.cascadeEnabled == true)
    cascadeTrans = getCascadeBranchTransferfunctionCoefficients();
else
    cascadeTrans = [0, 1];
end

if (fParms.parallelEnabled == true)
    parallelTrans = getParallelBranchTransferfunctionCoefficients();
else
    parallelTrans = [0, 1];
end

branchesTrans = addFractions(cascadeTrans, parallelTrans, eps);
out = multiplyFractions(voice, branchesTrans, eps);
outputLpFilter = Resonator(mParms.sampleRate);
outputLpFilter = outputLpFilter.set(0, mParms.sampleRate / 2);
outputLpTrans = outputLpFilter.getTransferFuncCoeff();
out = multiplyFractions(out, outputLpTrans, eps);
gainLin = dbToLin(fParms.gainDb);
out = multiplyFractions(out, [gainLin, 1], eps);
end

