function z = word2phone(word,docMap,rules)
letterPos = 1;
z = [];
while letterPos <= strlength(word) %loop for every letter in string
    indexPos = docMap(extract(word,letterPos)); % extract index of start of rules in array
    
    matchFound = false;
    exit = false;
    while(matchFound == false && exit ==false)
        soundRule = string(rules(indexPos)); %get the first rule for the letter from the array
        comparison = extractBefore(soundRule,"="); % extract the part of the rule used for analysis eg "[augh]=aa/f" extracted to [augh]
        
        %% TODO Compare the contents of square brackets with the word
        
        ruleContents = extractBetween(comparison,"[","]");
        i = 1;
        matchingInner = 1;
        while i <= strlength(ruleContents) && matchingInner == 1
            if letterPos + (i-1) > strlength(word)
                matchingInner = 0;
            elseif strcmp(extract(ruleContents,i),(extract(word,letterPos +(i-1))))  == false
                matchingInner = 0;
            end
            i = i +1; 
        end
        if(matchingInner ==true)
            %% TODO compare surroundings of square brackets with word
            beforeRules = extractBefore(comparison,"[");
            if(strcmp(beforeRules,"") == false)
                ruleCheck = strlength(beforeRules) + 1;
                while (ruleCheck > 0  && matchingInner == true)
                   if ruleCheck <= strlength(beforeRules)
                       matchingInner = checksymbol(word,letterPos- (strlength(beforeRules)+ruleCheck-1),extract(beforeRules,ruleCheck),-1);
                   else
                       matchingInner = false;
                   end
                   
                    ruleCheck = ruleCheck - 1;
                end
            end
            afterRules = extractAfter(comparison,"]");
            if(strcmp(afterRules,"") == false)
                ruleCheck = 1;
                while (ruleCheck <= strlength(afterRules) && matchingInner == true)
                    if (ruleCheck+letterPos) <= strlength(beforeRules)
                        matchingInner =  checksymbol(word,(letterPos+(ruleCheck-1)+strlength(ruleContents)),extract(afterRules,ruleCheck),1);
                    else
                        matchingInner = false;
                    end
                    
                    ruleCheck = ruleCheck + 1;
                end
            end
        else
          matchingInner= false;  
        end
        if matchingInner == true
            matchFound = true;
            z =  horzcat(z,extractAfter(soundRule,"="));
            letterPos = letterPos + strlength(ruleContents);
        else
            indexPos = indexPos + 1;
        end
        
    end
end



