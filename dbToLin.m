function result = dbToLin(db)
%% dbToLin Converting dB value to a linear value
%   dB values of below -99 converted to 0
if (db <= -99)
    result =  0;
else 
        result = 10 ^ (db / 20); % conversion code
end

end

