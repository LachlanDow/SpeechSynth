function rms =  computeRms (buf) 
   n = length(buf);
   acc = 0;
   for i = (1 : n) 
      acc = acc +  buf(i) ^ 2;
   end
    rms = sqrt(acc / n);