function [soundFrame] = convertToHH(soundFrame)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
soundFrame.oralFormantBW(1) = soundFrame.oralFormantBW(1) + 300;
soundFrame.cascadeAspirationDb = soundFrame.cascadeVoicingDb;
soundFrame.parallelAspirationDb = soundFrame.parallelVoicingDb;
soundFrame.cascadeVoicingDb = 0;
 soundFrame.parallelVoicingDb = 0;
end

