function rms =  computeRms (buf) 
%% computeRms - function will run the root mean square calclation on a iven value
   n = length(buf);
   acc = 0;
   for i = (1 : n) 
      acc = acc +  buf(i) ^ 2; % root mean square calculation
   end
    rms = sqrt(acc / n);
end