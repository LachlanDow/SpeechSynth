function [outputArg1,outputArg2] = getCascadeBranchTransferCoefficients(mParms,fParms)
cascadeVoicingLin = dbToLin(fParms.cascadeVoicingDb);
v = [cascadeVoicingLin,1];
nasalAntiFormantCasc =  AntiResonator(mParms.sampleRate);
nasalAntiFormantCasc = setNasalAntiformantCascGen(nasalAntiFormantCasc, fParms);
nasalAntiFormantTrans = nasalAntiFormantCasc.getTransferFunctionCoefficients();
v = multiplyFractions(v, nasalAntiFormantTrans, eps);
nasalFormantCasc = Resonator(mParms.sampleRate);
nasalFormantCasc = setNasalFormantCascGen (nasalFormantCasc, fParms);
nasalFormantTrans = nasalFormantCasc.getTransferFunctionCoefficients();
v = multiplyFractions(v, nasalFormantTrans, eps);
for i = 1 : mParms.maxOralFormants
    oralFormantCasc = Resonator(mParms.sampleRate);
    oralFormantCasc =  setOralFormantCascGen(oralFormantCasc, fParms, i);
    oralFormantCascTrans = oralFormantCasc.getTransferFunctionCoefficients();
    v = multiplyFractions(v, oralFormantCascTrans, eps);
end

end

