function soundArray = phone2Sound(word,soundMap,phonemeList,durationMap)
    conversionArray = word.phoneWord;
    dipthongTracker = 0;
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
            tempDipthong = split(conversionArray(i),"/");
            for j = 1:length(tempDipthong)
                soundArray(phonemeTracker) = Sound(phonemeList(soundMap(tempDipthong(j))),durationMap(tempDipthong(j)),20);
                phonemeTracker = phonemeTracker + 1;
            end
        end
        
       i = i + 1; 
    end
end

