function [inputFrames] = interpolateFrame(startFrame,endFrame, numFrames)

inputFrames = FrameParms(150,1,1);
for i = 1:numFrames
    inputFrames(i) = FrameParms(150,1,1);
end

f1 = linspace(startFrame.oralFormantFreq(1),endFrame.oralFormantFreq(1),numFrames);
f2 = linspace(startFrame.oralFormantFreq(2),endFrame.oralFormantFreq(2),numFrames);
f3 = linspace(startFrame.oralFormantFreq(3),endFrame.oralFormantFreq(3),numFrames);
f4 = linspace(startFrame.oralFormantFreq(4),endFrame.oralFormantFreq(4),numFrames);

bw1 = linspace(startFrame.oralFormantBW(1),endFrame.oralFormantBW(1),numFrames);
bw2 = linspace(startFrame.oralFormantBW(2),endFrame.oralFormantBW(2),numFrames);
bw3 = linspace(startFrame.oralFormantBW(3),endFrame.oralFormantBW(3),numFrames);
bw4 = linspace(startFrame.oralFormantBW(4),endFrame.oralFormantBW(4),numFrames);

of1 = linspace(startFrame.oralFormantDb(1),endFrame.oralFormantDb(1),numFrames);
of2 = linspace(startFrame.oralFormantDb(2),endFrame.oralFormantDb(2),numFrames);
of3 = linspace(startFrame.oralFormantDb(3),endFrame.oralFormantDb(3),numFrames);
of4 = linspace(startFrame.oralFormantDb(4),endFrame.oralFormantDb(4),numFrames);
of5 = linspace(startFrame.oralFormantDb(5),endFrame.oralFormantDb(5),numFrames);
of6 = linspace(startFrame.oralFormantDb(6),endFrame.oralFormantDb(6),numFrames);

breathiness = linspace(startFrame.breathinessDb,endFrame.breathinessDb,numFrames);
cascVoicing = linspace(startFrame.cascadeVoicingDb,endFrame.cascadeVoicingDb,numFrames);
cascAsp = linspace(startFrame.cascadeAspirationDb,endFrame.cascadeAspirationDb,numFrames);
cascadeAspirationMod = linspace(startFrame.cascadeAspirationMod,endFrame.cascadeAspirationMod,numFrames);

parallelVoicingDb = linspace(startFrame.parallelVoicingDb,endFrame.parallelVoicingDb,numFrames);
parallelAspirationDb = linspace(startFrame.parallelAspirationDb,endFrame.parallelAspirationDb,numFrames);
parallelAspirationMod = linspace(startFrame.parallelAspirationMod,endFrame.parallelAspirationMod,numFrames);
fricationDb = linspace(startFrame.fricationDb,endFrame.fricationDb,numFrames);
fricationMod = linspace(startFrame.fricationMod,endFrame.fricationMod,numFrames);
parallelBypassDb = linspace(startFrame.parallelBypassDb,endFrame.parallelBypassDb,numFrames);

for j = 1:numFrames
    inputFrames(j).oralFormantFreq(1) = f1(j);
    inputFrames(j).oralFormantFreq(2) = f2(j);
    inputFrames(j).oralFormantFreq(3) = f3(j);
    inputFrames(j).oralFormantFreq(4) = f4(j);
    
    inputFrames(1,j).oralFormantBW(1) = bw1(j);
    inputFrames(1,j).oralFormantBW(2) = bw2(j);
    inputFrames(1,j).oralFormantBW(3) = bw3(j);
    inputFrames(1,j).oralFormantBW(4) = bw4(j);
    
    inputFrames(1,j).oralFormantDb(1) = of1(j);
    inputFrames(1,j).oralFormantDb(2) = of2(j);
    inputFrames(1,j).oralFormantDb(3) = of3(j);
    inputFrames(1,j).oralFormantDb(4) = of4(j);
    inputFrames(1,j).oralFormantDb(5) = of5(j);
    inputFrames(1,j).oralFormantDb(6) = of6(j);
    
    inputFrames(1,j).breathinessDb = breathiness(j);
    inputFrames(1,j).cascadeVoicingDb = cascVoicing(j);
    inputFrames(1,j).cascadeAspirationDb = cascAsp(j);
    inputFrames(1,j).cascadeAspirationMod = cascadeAspirationMod(j);
    
    
    inputFrames(1,j).parallelVoicingDb = parallelVoicingDb(j);
    inputFrames(1,j).parallelAspirationDb = parallelAspirationDb(j);
    inputFrames(1,j).parallelAspirationMod = parallelAspirationMod(j);
    inputFrames(1,j).fricationDb = fricationDb(j);
    inputFrames(1,j).fricationMod = fricationMod(j);
    inputFrames(1,j).parallelBypassDb = parallelBypassDb(j);
end

end

