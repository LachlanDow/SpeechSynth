function [textArray] = FORMAT(text)
%FORMAT Takes input of text and outputs the texts in a processed form that
%the syntesizer will be able to further process
% 

tempText = findAbbreviations(text);


textArray = split(tempText, " ");
textArray = rot90(textArray);
for i = 1:length(textArray)
    
 %check for Acronyms
  expression = '[A-Z](?![a-z])';
  matchStr = regexp(textArray(i),expression,'match');
  matchStr = join(matchStr,"");
 %end of check for acronyms
  
  expression = '\d?\d?.?\d';
  matchNumber = regexp(textArray(i),expression,'match');
  matchNumber = join(matchNumber,"");
  disp(matchNumber);
 
  %% if acronym is found - replace with translated text
  if (isempty(matchStr) == 0)
     tempStrArray= replaceAcronyms(matchStr);
     s1 = textArray(1:i);
     s2 = textArray(i + 1: end);
     s1(i) = [];
     s1 =horzcat(s1,tempStrArray);
     textArray =horzcat(s1,s2);
  end
 
%% if number is found replace with text version
   if (isempty(matchNumber) == 0)
     tempStrArray= num2words(matchNumber);
     s1 = textArray(1:i);
     s2 = textArray(i + 1: end);
     s1(i) = [];
     s1 =horzcat(s1,tempStrArray);
     textArray =horzcat(s1,s2);
  end
end

%%join array pf strings back together to remove any missed upper case
%%letters then split the array again into indevidual words
textArray = strjoin(textArray);
textArray = lower(textArray);
textArray = split(textArray, " ");

end

