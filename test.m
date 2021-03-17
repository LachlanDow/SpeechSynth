function phonemese =  test(string, docMap,rules)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
string = FORMAT(string);
phonemese = word();
for i = 1:length(string)
    phonemese(i).phoneWord = word2phone(string(i),docMap,rules);
end
end

