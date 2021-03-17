function [outputArray] = movingAverage(array,smoothingFactor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

coeffMA = ones(1, smoothingFactor)/smoothingFactor;
outputArray = filter(coeffMA, 1, array);
end

