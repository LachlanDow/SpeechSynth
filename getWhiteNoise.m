function y = getWhiteNoise()
%getWHiteNoise function returns value between -1 and 1
%   uses rand function to to generate funcftion between -1 and 1
%y = random('Normal',-1,1);
y = 0.1 * (rand-1 * 2);
end

 