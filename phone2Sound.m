function soundArray = phone2Sound(word,soundMap,phonemeList,durationMap)
%% function to conver from phonemes to sound frames
   initialArray = word.phoneWord;
   conversionArray = "";
   
   %%loop will extract words split with "/"
    for i = 1:length(initialArray)
        if(contains(initialArray(i),"/") == true)
            unSlashed = rot90(split(initialArray(i),"/"));
            for j = 1:length(unSlashed)
            conversionArray(length(conversionArray) + 1 ) = unSlashed(j);  
            end
        else
            conversionArray(length(conversionArray) + 1 ) = initialArray(i);  
        end 
    end
   conversionArray  = conversionArray(2:end);
   
   %loops for each phoneme and translate to sound frame equivelent
    i = 1;
    phonemeTracker = 1;
    while i <= length(conversionArray)
        if(contains(conversionArray(i),"/") ~= true)
            if conversionArray(i) == "_"
                
                tempSound = Sound(phonemeList(soundMap(conversionArray(i+1))),durationMap(conversionArray(i+1)) * 3,20);
                tempSound.dataFrame = convertToHH(tempSound.dataFrame);
                soundArray(phonemeTracker) = tempSound;
                phonemeTracker = phonemeTracker + 1;
                i = i + 1;
            else
                soundArray(phonemeTracker) = Sound(phonemeList(soundMap(conversionArray(i))),durationMap(conversionArray(i)),20);
                phonemeTracker = phonemeTracker + 1;
            end
        else 
            %%unneeded now but kept incase of errors in original code
            tempDipthong = split(conversionArray(i),"/");
            for j = 1:length(tempDipthong)
                soundArray(phonemeTracker) = Sound(phonemeList(soundMap(tempDipthong(j))),durationMap(tempDipthong(j)),20);
                phonemeTracker = phonemeTracker + 1;
            end
        end
        
       i = i + 1; 
    end
end

