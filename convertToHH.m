function [soundFrame] = convertToHH(soundFrame)
%convertToHH function will convert a sound to the HH equivalent of itself
%   function lters the first formants freqency of a given vowe
soundFrame.oralFormantBW(1) = soundFrame.oralFormantBW(1) + 300;
soundFrame.cascadeAspirationDb = soundFrame.cascadeVoicingDb;
soundFrame.cascadeVoicingDb = 0;
end

