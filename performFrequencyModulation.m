function y = performFrequencyModulation(f0,flutterLevel,time)
%UNTITLED modulates fundamental frequency
%   creates deviation from constant pitch
    if flutterLevel <= 0
     y = f0;
    else
     w = 2 * pi * time;
     a = sin(12.7 * w) + sin(7.1 * w) + sin(4.7 * w);
     y = f0 * (1 + a * flutterLevel / 50);
    
    end
end


