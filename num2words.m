function [wordArray] = num2words(number)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
numLength = (strlength(number));
wordArray = string(missing);
if contains(number,".")
    splitNumber = split(number,".");
    wholePart = splitNumber(1);
    decimalPart = splitNumber(2);
else 
    wholePart = number;
end
    

remainingLength = strlength(wholePart);
remainder = mod(remainingLength,3);
start = true;
wordArrayCounter = 1;
placecounter = 1;
while remainingLength > 0
    
        if remainder ~= 0 && start == true
            resultantstring = extractBetween(wholePart,1,remainder);
            wordArray(wordArrayCounter) = wholenumberConvert(resultantstring);
            if (remainingLength > 6)
               wordArray(wordArrayCounter+1) ="Million";
            elseif (remainingLength > 3)
               wordArray(wordArrayCounter+1) ="Thousand";
            else
              wordArray(wordArrayCounter+1) ="";
            end
            remainingLength = remainingLength - remainder;
            start = false;
            wordArrayCounter = wordArrayCounter + 2;
            placecounter = placecounter + remainder;
            remainingLength = remainingLength - remainder;
        else
            resultantstring = extractBetween(wholePart,placecounter,placecounter + 2);
            wordArray(wordArrayCounter) = wholenumberConvert(resultantstring);
             if (remainingLength > 6)
               wordArray(wordArrayCounter+1) ="Million";
            elseif (remainingLength > 3)
               wordArray(wordArrayCounter+1) ="Thousand";
            else
              wordArray(wordArrayCounter+1) ="";
             end
             wordArrayCounter = wordArrayCounter + 2;
             placecounter = placecounter + 3;
             remainingLength = remainingLength - 3;
        end
end
if isempty(decimalPart) == 0
    wordArray(wordArrayCounter - 1) = "point";
    for i = 1:strlength(decimalPart)
        decimalNumber = extractBetween(decimalPart,i,i);
        wordArray(wordArrayCounter) = wholenumberConvert(decimalNumber);
        wordArrayCounter = wordArrayCounter + 1;
end
    wordArray = strjoin(wordArray);
end

