
classdef Sound
    %Sound sound instance to be used to construct words
    %each instance is a chunck of data to be inputed into the word class
    %the class contains the framedata,the duration of the frame in number of 5ms chuncks and the first part of the transition length  
    
    properties
        dataFrame
        duration
        transitionLength
        
    end
    
    methods
        %% constutor function for the sound input [ soundFrame= FrameParms,duration=int(number of 5ms inputFrames),transitionLength=int(number of 5ms frames for the transition betweensounds to take place)
        function obj = Sound(soundFrame,duration,transitionLength)
             obj.dataFrame = soundFrame;
             obj.duration = duration;
             obj.transitionLength = transitionLength;
        end    
    end
end

