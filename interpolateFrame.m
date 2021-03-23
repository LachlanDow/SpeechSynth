function [inputFrames] = interpolateFrame(startFrame,endFrame, durationStart,transitionFrames)


f0 = 150;
inputFrames = FrameParms(f0,1,1);
startFrames = FrameParms(f0,1,1);
endFrames = FrameParms(f0,1,1);
for h = 1:durationStart
    startFrames(h) = startFrame;
end
for i = 1:transitionFrames
    inputFrames(i) = FrameParms(f0,1,1);
end
f0 = linspace(startFrame.f0(1),endFrame.f0(1),transitionFrames);

f1 = linspace(startFrame.oralFormantFreq(1),endFrame.oralFormantFreq(1),transitionFrames);
f2 = linspace(startFrame.oralFormantFreq(2),endFrame.oralFormantFreq(2),transitionFrames);
f3 = linspace(startFrame.oralFormantFreq(3),endFrame.oralFormantFreq(3),transitionFrames);
f4 = linspace(startFrame.oralFormantFreq(4),endFrame.oralFormantFreq(4),transitionFrames);

bw1 = linspace(startFrame.oralFormantBW(1),endFrame.oralFormantBW(1),transitionFrames);
bw2 = linspace(startFrame.oralFormantBW(2),endFrame.oralFormantBW(2),transitionFrames);
bw3 = linspace(startFrame.oralFormantBW(3),endFrame.oralFormantBW(3),transitionFrames);
bw4 = linspace(startFrame.oralFormantBW(4),endFrame.oralFormantBW(4),transitionFrames);

of1 = linspace(startFrame.oralFormantDb(1),endFrame.oralFormantDb(1),transitionFrames);
of2 = linspace(startFrame.oralFormantDb(2),endFrame.oralFormantDb(2),transitionFrames);
of3 = linspace(startFrame.oralFormantDb(3),endFrame.oralFormantDb(3),transitionFrames);
of4 = linspace(startFrame.oralFormantDb(4),endFrame.oralFormantDb(4),transitionFrames);
of5 = linspace(startFrame.oralFormantDb(5),endFrame.oralFormantDb(5),transitionFrames);
of6 = linspace(startFrame.oralFormantDb(6),endFrame.oralFormantDb(6),transitionFrames);

gainDb = linspace(startFrame.gainDb,endFrame.gainDb,transitionFrames);
agcRmsLevel = linspace(startFrame.agcRmsLevel,endFrame.agcRmsLevel,transitionFrames);
flutterLevel = linspace(startFrame.flutterLevel,endFrame.flutterLevel,transitionFrames);
openPhaseRatio = linspace(startFrame.openPhaseRatio,endFrame.openPhaseRatio,transitionFrames);
nasalFormantFreq = linspace(startFrame.nasalFormantFreq,endFrame.nasalFormantFreq,transitionFrames);
nasalFormantBW = linspace(startFrame.nasalFormantBW,endFrame.nasalFormantBW,transitionFrames);



breathiness = linspace(startFrame.breathinessDb,endFrame.breathinessDb,transitionFrames);
cascVoicing = linspace(startFrame.cascadeVoicingDb,endFrame.cascadeVoicingDb,transitionFrames);
cascAsp = linspace(startFrame.cascadeAspirationDb,endFrame.cascadeAspirationDb,transitionFrames);
cascadeAspirationMod = linspace(startFrame.cascadeAspirationMod,endFrame.cascadeAspirationMod,transitionFrames);

parallelVoicingDb = linspace(startFrame.parallelVoicingDb,endFrame.parallelVoicingDb,transitionFrames);
parallelAspirationDb = linspace(startFrame.parallelAspirationDb,endFrame.parallelAspirationDb,transitionFrames);
parallelAspirationMod = linspace(startFrame.parallelAspirationMod,endFrame.parallelAspirationMod,transitionFrames);
fricationDb = linspace(startFrame.fricationDb,endFrame.fricationDb,transitionFrames);
fricationMod = linspace(startFrame.fricationMod,endFrame.fricationMod,transitionFrames);
parallelBypassDb = linspace(startFrame.parallelBypassDb,endFrame.parallelBypassDb,transitionFrames);
nasalFormantDb = linspace(startFrame.nasalFormantDb,endFrame.nasalFormantDb,transitionFrames);

for j = 1:transitionFrames
    inputFrames(j).f0(1) = f0(j);
    
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
    
    
    inputFrames(1,j).gainDb = gainDb(j);
    inputFrames(1,j).agcRmsLevel = agcRmsLevel(j);
    inputFrames(1,j).flutterLevel = flutterLevel(j);
    inputFrames(1,j).openPhaseRatio = openPhaseRatio(j);
    inputFrames(1,j).nasalFormantFreq = nasalFormantFreq(j);
    inputFrames(1,j).nasalFormantBW = nasalFormantBW(j);
    
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
    inputFrames(1,j).nasalFormantDb = nasalFormantDb(j);

   % for h = 1:durationStart
   % endFrames(h) = endFrame;
   % end
end
    inputFrames = horzcat(startFrames,inputFrames);
end

