function wordReplace = word2Phon(word,rules,index)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
exit = false;
wordReplace = "";
editableWord = extractBetween(word,index,strlength(word));



while (exit == false)
    
    
    if (isKey(rules,editableWord))
        wordReplace = horzcat(wordReplace,rules(editableWord));
        index = index + strlength(editableWord);
        if (index > strlength(word))
            exit = true
        else   
            editableWord = extractBetween(word,index,strlength(word));
        end
    else  
        editableWord = extractBetween(editableWord,1,strlength(editableWord)-1);
    end
end
end

