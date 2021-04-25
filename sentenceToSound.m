function output = sentenceToSound(string)
%converts a sentence to a soundby combine functions already constructed
%and their returned values
vars = load('recentVars.mat');
sentence = test(string,vars.docMap,vars.rules);
output =[];
pause = zeros(1,500);
for i = 1:length(sentence)
   dataFrameTemp =  createWord(phone2Sound(sentence(i),vars.soundMap,vars.phonemeList,vars.durationMap));
   
   %for d = 1:length(dataFrameTemp)
     %   disp(dataFrameTemp(d).duration)
   %end
   
   outputTemp = generateSound(vars.mParms,dataFrameTemp);
   output = horzcat(output,outputTemp,pause); %concatenates the final sounds for each word
end


end
