function soundArray = phone2Sound(word,soundMap,phonemeList,durationMap)
    conversionArray = word.phoneWord;
    dipthongTracker = 0;
    
    for i = 1:length(conversionArray)+dipthongTracker
        if(contains(conversionArray(i),"/") ~= true)
            soundArray(i) = Sound(phonemeList(soundMap(conversionArray(i))),durationMap(conversionArray(i)),20);
        else 
            tempDipthong = split(conversionArray(i),"/");
            dipthongTracker = dipthongTracker +1;
            for j = 1:length(tempDipthong)
                 soundArray(i+j-1) = Sound(phonemeList(soundMap(tempDipthong(j))),durationMap(tempDipthong(j)),20);
            end
        end
        
    end
end

