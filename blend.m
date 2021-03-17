function midsound = blend(sound1,sound2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

 blendingportionsound1 = sound1((length(sound1)/100)*80:end-1);
 blendingportionsound2 = sound1(1:(length(sound1)/100)*20);
 temp = blendingportionsound1
    
    for i = 1:length(blendingportionsound1)
        temp(i) = (blendingportionsound1(i)+blendingportionsound2(i)) / 2;
    end
   midsound =  horzcat(blendingportionsound1,temp,blendingportionsound2);
    
    
end

