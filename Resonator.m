classdef Resonator
    %Resonator Summary of obj class goes here
    %   Detailed explanation goes here
    
    properties
        sampleRate
        a % fitler coefficient a
        b % fitler coefficient a
        c % fitler coefficient a
        y1 %y[n-1], last output value
        y2 %y[n-2], second-last output value
        r % temp val for calculation
        passthrough
        muted
    end
    methods
        function obj = Resonator(sampleRate)
            obj.sampleRate = sampleRate;
            obj.y1=0;
            obj.y2=0;
            obj.passthrough = true;
            obj.muted = false;            
        end
        
        % Adjusts the filter parameters without resetting the inner state.
        % @param f
        %    Frequency of resonator in Hz. May be 0 for LP filtering.
        % @param bw
        %    Bandwidth of resonator in Hz.
        % @param dcGain
        %    DC gain level.
        function obj = set(obj,f,bw,dcGain)
            
            if (f <0 || f >= obj.sampleRate / 2 ||bw <=0 || dcGain <=0 ||  isinf(f) || isinf(bw) || isinf(dcGain) )
                error("Invalid Resonator Parametes")
            end
            obj.r = exp(-pi * bw / obj.sampleRate);
            w = 2 *  pi * f / obj.sampleRate;
            obj.c = - (obj.r ^ 2);
            obj.b = 2 * obj.r * cos(w);
            obj.a = (1 - obj.b - obj.c) * dcGain;
            obj.passthrough = false;
            obj.muted = false;
        end
        function obj = setPassthrough(obj)
            obj.passthrough = true;
            obj.muted= false;
            obj.y1 = 0;
            obj.y2 = 0;
            
        end
        function obj = setMute(obj)
            obj.passthrough = false;
            obj.muted= true;
            obj.y1 = 0;
            obj.y2 = 0;
            
        end
        function obj = adjustImpulseGain(obj,newA)
            obj.a = newA;
        end
        
        function obj = adjustPeakGain(obj,peakGain)
            if(peakGain <= 0 || isinf(peakGain))
                error("Invalid Resonator Peak Gain")
            else
                obj.a = peakGain * (1-obj.r);
            end
            
        end
        
        
        function [obj, y] = step(obj,x)
             % Performs a filter step.
             % @param x
             %    Input signal value.
             % @returns
             %    Output signal value
            if (obj.passthrough == 1)
                y = x;
            elseif (obj.muted == 1)
                    y = 0;
            else
                    
            y = obj.a * x + obj.b * obj.y1 + obj.c * obj.y2;
            obj.y2 = obj.y1;
            obj.y1 = y;
            end
                
            
        end
    end
    
end

