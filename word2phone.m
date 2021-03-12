function z = word2phone(word,docMap,rules)
letterPos = 1;
while letterPos <= strlength(word) %loop for every letter in string
    indexPos = docMap(extract(word,letterPos)); % extract index of start of rules in array
    soundRule = string(rules(indexPos)); %get the first rule for the letter from the array
    comparison = extractBefore(soundRule,"="); % extract the part of the rule used for analysis eg "[augh]=aa/f" extracted to [augh] 
   
    %% TODO Compare the contents of square brackets with the word
    matchFound = false;cv
    exit = false;
    while(matchFound == false && exit ==false)
        ruleContents = extractBetween(comparison,"[","]");
        matching = true;
        for i = 1:length(ruleContents)
            if ruleContents(i) ~= word(letterPos + (i-1))
                matching = false;
            end
        end
        if(matching ==true)
            %% TODO compare surroundings of square brackets with word
            beforeRules = extractBefore(comparison,"[");
            afterRules = extractAfter(comparison,"]"); 
        end
        
    end   
end
z =  soundRule;
end