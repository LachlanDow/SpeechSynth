function [outputnumber] = wholenumberConvert(number)
%%function to conver a 1 to 3 digit number to it's word equivalent
    numberLength = strlength(number);
    wordArray = string(missing);
    teenNum = false;
    for i = 1:numberLength
        if numberLength == 3 && i == 1
            switch extractBetween(number,i,i)% hundereds
                case "0"
                  wordArray(i) = " ";
              case "1"
                  wordArray(i) = "One Hundred and";
              case "2"
                  wordArray(i) = "Two Hundred and";
              case "3"
                  wordArray(i) = "Three Hundred and";
              case "4"
                  wordArray(i) = "Four Hundred and";
              case "5"
                  wordArray(i) = "Five Hundred and";
              case "6"
                  wordArray(i) = "Six Hundred and";
              case "7"
                  wordArray(i) = "Seven Hundred and";
              case "8"
                  wordArray(i) = "Eight Hundred and";
              case "9"
                  wordArray(i) = "Nine Hundred and";
            end
        end
        if ((numberLength > 2 && i == 2) ||(numberLength == 2 && i == 1))
            switch extractBetween(number,i,i)% tens
               case "0"
                  wordArray(i) = " ";
              case "1" %this is teens
                  switch extractBetween(number,i,numberLength)
                      case "11"
                          wordArray(i) = "Eleven";
                      case "12"
                          wordArray(i) = "Twenlve";
                      case "13"
                          wordArray(i) = "Thirteen";
                      case "14"
                          wordArray(i) = "Fourteen";
                      case "15"
                          wordArray(i) = "Fifteen";
                      case "16"
                          wordArray(i) = "Sixteen";
                      case "17"
                          wordArray(i) = "Seventeen";
                      case "18"
                          wordArray(i) = "Eighteen";
                      case "19"
                          wordArray(i) = "Nineteen";
                  end
                  teenNum = true;
              case "2"
                  wordArray(i) = "Twenty";
              case "3"
                  wordArray(i) = "Thirty";
              case "4"
                  wordArray(i) = "Fourty";
              case "5"
                  wordArray(i) = "Fifty";
              case "6"
                  wordArray(i) = "Sixty";
              case "7"
                  wordArray(i) = "Seventy";
              case "8"
                  wordArray(i) = "Eighty";
              case "9"
                  wordArray(i) = "Ninety";
            end
        end 
        if (((numberLength > 2 && i ==3) || (numberLength == 2 && i ==2) || (numberLength == 1 && i ==1)) && teenNum == false)
          switch  extractBetween(number,i,i)%digits
              case "0"
                  wordArray(i) = "";
              case "1"
                  wordArray(i) = "one";
              case "2"
                  wordArray(i) = "two";
              case "3"
                  wordArray(i) = "three";
              case "4"
                  wordArray(i) = "four";
              case "5"
                  wordArray(i) = "five";
              case "6"
                  wordArray(i) = "six";
              case "7"
                  wordArray(i) = "seven";
              case "8"
                  wordArray(i) = "eight";
              case "9"
                  wordArray(i) = "nine";
          end
        end
    end
    
      outputnumber = strjoin(wordArray); %join all strings
end

