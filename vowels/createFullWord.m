function hello = createFullWord(parm1,parm2,parm3,mParms,transitionPeriod)

fParmsA = interpolateFrame(parm1,parm2,transitionPeriod);
fParmsB = interpolateFrame(parm2,parm3,transitionPeriod);

hello = horzcat(fParmsA,fParmsB);
for i = 1:40
    hello(length+i) = parm3;
end
hello = generateSound(mParms,hello);

end

