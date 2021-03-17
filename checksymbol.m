function match = checksymbol(word,index,symbol,movement)
match = false;
switch symbol
    case"#"
        if isempty(regexp(extract(word,index),"[aeiou]", 'once')) == false
            match = true;
        end
    case ";"
        if isempty(regexp(extract(word,index),"[vrlf]", 'once')) == true
            match = true;
        end
    case"."
        if isempty(regexp(extract(word,index),"[bdvgjlmnrwz]", 'once')) == false
            match = true;
        end
    case "%"
        if isempty(regexp(extract(word,index),"e", 'once')) == false
            match = true;
        end
        if match == false
            if (index + movement >= 1) && (index + movement <= strlength(word))
                switch movement
                    case -1
                        if isempty(regexp(extractBetween(word,index-1,index),"e[rsd]", 'once')) == false; match = true; end
                    case 1
                        if isempty(regexp(extractBetween(word,index,index+1),"e[rsd]", 'once')) == false; match = true; end
                end
            end
        end
        if match == false
            if index +2*movement >= 1 && index+movement*2 <= strlength(word)
                switch movement
                    case -1
                        if isempty(regexp(extractBetween(word,index-2,index),"ing", 'once')) == false; match = true; end
                    case 1
                        if isempty(regexp(extractBetween(word,index,index+2),"ely", 'once')) == false; match = true; end
                end
            end
        end
    case"&"
        if isempty(regexp(extract(word,index),"[scgzxj]", 'once')) == false
            match = true;
        end
        if (match ==false)
            if index + movement >= 1 && index + movement <= strlength(word)
                switch movement
                    case -1
                        if isempty(regexp(extractBetween(word,index-1,index),"[sc]h", 'once')) == false; match = true; end
                    case 1
                        if isempty(regexp(extractBetween(word,index,index+1),"[sc]h", 'once')) == false; match = true; end
                end
            end
        end
    case"'"
        if isempty(regexp(extract(word,index),"[tsrdlznj]", 'once')) == false
            match = true;
        end
        if (match ==false)
            if index + movement >= 1 && index + movement <= strlength(word)
                switch movement
                    case -1
                        if isempty(regexp(extractBetween(word,index-1,index),"[sct]h", 'once')) == false; match = true; end
                    case 1
                        if isempty(regexp(extractBetween(word,index,index+1),"[sct]h", 'once')) == false; match = true; end
                end
            end
        end
    case "^"
        if isempty(regexp(extract(word,index),"[b-df-hj-np-vwxz]", 'once')) == false
            match = true; 
        end
    case"+"
        if isempty(regexp(extract(word,index),"[eiy]", 'once')) == false
            match = true; 
        end
    case ":"
        if isempty(regexp(extract(word,index),"[aeiouy]", 'once')) == true
            match = true;
        end
    case"<"
        if index > 1
            match = true;
        end
    case">"
        if index == strlength(word)
            match = true;
        end
    otherwise
        if index > strlength(word)
            match = false;
        else
        match = strcmp(extract(word,index),symbol);
        end
end
end