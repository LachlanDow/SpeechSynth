function [wordArray] = num2words(number)
%num2words this function will convert a integer number into the word
%equivalent
%  the function looks at every number given and then will give the correct
%  adjustment given the conversions that it has
wordArray = string(missing);
decimalPart =[];
if contains(number,".") %check for decimal point
    splitNumber = split(number,"."); % split at decimal point
    wholePart = splitNumber(1);
    decimalPart = splitNumber(2);
else 
    wholePart = number;
end
    

remainingLength = strlength(wholePart);
remainder = mod(remainingLength,3); % check the number of numbers at the start of the string eg 23,000 it is important to extract the first two
start = true;
wordArrayCounter = 1;
placecounter = 1;
while remainingLength > 0 % loop until end of number
    
        if remainder ~= 0 && start == true %% this if statement accounts for numbers that don't divide well into 3 
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
        else % rest of number
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
if isempty(decimalPart) == 0 %% translate decimal part
    wordArray(wordArrayCounter - 1) = "point";
    for i = 1:strlength(decimalPart)
        decimalNumber = extractBetween(decimalPart,i,i);
        wordArray(wordArrayCounter) = wholenumberConvert(decimalNumber);
        wordArrayCounter = wordArrayCounter + 1;
    end
    wordArray = strjoin(wordArray);
end

