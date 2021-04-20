function [newStr] = findAbbreviations(text)
%findAbbreviations function to locate abbreviated terms and replace them
% with terms that the synthesizer can say


%%should be rewritten to exit after correct case is found 
%%loop through 2 array of strings with conversion and then replace if
%%matchfound - then exit makes the sytem faster and more readable

newStr = regexprep(text,"Mr", "mister",'ignorecase');
newStr = regexprep(newStr,"Ms", "miz",'ignorecase');
newStr = regexprep(newStr,"Mrs", "mizzes",'ignorecase');
newStr = regexprep(newStr,"Dr", "doctor",'ignorecase');
newStr = regexprep(newStr,"Num", "number",'ignorecase');
newStr = regexprep(newStr,"Jan", "january",'ignorecase');
newStr = regexprep(newStr,"Feb", "february",'ignorecase');
newStr = regexprep(newStr,"Mar", "march",'ignorecase');
newStr = regexprep(newStr,"Apr", "april",'ignorecase');
newStr = regexprep(newStr,"Aug", "august",'ignorecase');
newStr = regexprep(newStr,"Sept", "september",'ignorecase');
newStr = regexprep(newStr,"Oct", "october",'ignorecase');
newStr = regexprep(newStr,"Nov", "november",'ignorecase');
newStr = regexprep(newStr,"Dec", "december",'ignorecase');
newStr = regexprep(newStr,"etc", "et cetera",'ignorecase');
newStr = regexprep(newStr,"Jr", "junior",'ignorecase');
newStr = regexprep(newStr,"Dr", "proffessor",'ignorecase');
newStr = regexprep(newStr,"Prof", "mizzes",'ignorecase');
newStr = regexprep(newStr,"'", "",'ignorecase');
newStr = regexprep(newStr,"-", " ",'ignorecase');
newStr = regexprep(newStr,"%", "per cent",'ignorecase');
newStr = regexprep(newStr,"&", "and",'ignorecase');

end

