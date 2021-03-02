function [parmOutputList] = createFrameParms(parmList)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
parmOutputList(1:length(parmList)) = FrameParms(200,1,1);

for i = 1:length(parmList)
    for j = 1:3
        parmOutputList(i).oralFormantFreq(j) =  parmList(i,j);
    end
    for k = 4:6
        parmOutputList(i).oralFormantBW(k-3) = parmList(i,k);
    end  
end

end

