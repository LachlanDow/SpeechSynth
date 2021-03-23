function phonemes =  test(string, docMap,rules)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
string = FORMAT(string);
phonemes = word();
%textversion = "";
for i = 1:length(string)
    phonemes(i).phoneWord = word2phone(string(i),docMap,rules);
    %phonemes(i).phoneWord = join(phonemes(i).phoneWord);
    %textversion(i) = phonemes(i).phoneWord;
end
%phonemes = join(textversion, "");
%phonemes = convertStringsToChars(phonemes);
end

