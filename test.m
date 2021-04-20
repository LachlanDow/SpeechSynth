function phonemes =  test(string, docMap,rules)
%test creates phonetic transcription of input text
%  main function for program, will combine everythinf made so far
string = FORMAT(string);
phonemes = word();
%textversion = "";
for i = 1:length(string)
    phonemes(i).phoneWord = word2phone(string(i),docMap,rules);  
end
end

