function [parmOutputList] = createFrameParms(parmList)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
parmOutputList(1:height(parmList)) = FrameParms(200,1,1);
disp(height(parmList))

for i = 1:height(parmList)
    for j = 1:3
        parmOutputList(i).oralFormantFreq(j) =  parmList(i,j);
    end
    for k = 4:6
        parmOutputList(i).oralFormantBW(k-3) = parmList(i,k);
    end
    
    if ~isempty(parmList(i,7))
        for l = 7:11
            parmOutputList(i).oralFormantDb(l-5) = parmList(i,l);
        end
        parmOutputList(i).parallelBypassDb = parmList(i,12);
        parmOutputList(i).fricationDb = parmList(i,13);
        parmOutputList(i).cascadeVoicingDb = parmList(i,14);
        parmOutputList(i).parallelVoicingDb = parmList(i,14);
        parmOutputList(i).tiltDb = parmList(i,15);
    end
    
    
end

end

