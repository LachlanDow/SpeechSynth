classdef CurrentFrameParameters
    %CurrentFrameParameters this class represents the currently active
    %frame parameters in their linear from for the synthesiser to use in
    %caclulations.
    
    properties
        %general Parameters
        breathinessLin
        gainLin
        
        %cascade Parameters
        cascadeVoicingLin
        cascadeAspirationLin
        
        
        %Parallel Parameters
        parallelVoicingLin
        parallelAspirationLin
        fricationLin
        parallelBypassLin
    end
    
   
end

