function acroLetter = replaceAcronyms(text)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
expression = '. *';
pat = regexpPattern(expression);
acroLetter = extract(text,pat);

for i = 1:length(acroLetter)
   acroLetter(i) =  strcat('LETTER-',acroLetter(i));
end
acroLetter = rot90(acroLetter); 
end

