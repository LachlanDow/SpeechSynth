function hello = createFullWord(parm1,parm2,parm3,mParms,transitionPeriod)

fParmsA = interpolateFrame(parm1,parm2,transitionPeriod);
fParmsB = interpolateFrame(parm2,parm3,transitionPeriod);

hello = horzcat(fParmsA,fParmsB);

hello = generateSound(mParms,hello);

end

