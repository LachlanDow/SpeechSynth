function [generateSoundInput] = createWord(soundList)
%createWord function to create the 5ms sound frames that will make up a
% word, the word is then outputted as these frame parametersto an array of
% of array of frames that will be then sent to the synthesizer to be
% processed into sound inputs and concattenated into sentences. 

generateSoundInput = soundList(1).dataFrame;

%loop through every frame in list -1 as last frame is acounted for by
%interal loop logic
if length(soundList) == 1
    transitionFrames = soundList.transitionLength;
    generateSoundInput = interpolateFrame(soundList.dataFrame,soundList.dataFrame,soundList.duration,transitionFrames *4);
return
end
for i = 1:(length(soundList))
    transitionFrames = soundList(i).transitionLength;
    
    %combine with horzcat the current array of frameparamters and with next
    %chunk of the data frame
    if i ~= length(soundList)
        generateSoundInput = horzcat(generateSoundInput,interpolateFrame(soundList(i).dataFrame,soundList(i+1).dataFrame,soundList(i).duration / 3,10));
    else
        generateSoundInput = horzcat(generateSoundInput,interpolateFrame(soundList(i).dataFrame,soundList(i).dataFrame,soundList(i).duration*2,1));
    end
end

end

