classdef ProgressBarTestableTime < ProgressBar
    %PROGRESSBARTESTABLETIME Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nextTocTime
    end
    
    methods
        function obj = ProgressBarTestableTime(totalIterations)
            obj = obj@ProgressBar(totalIterations);
            obj.funTic = @obj.tic;
            obj.funToc = @obj.toc;
        end
        
        function outputArg = tic(obj) %#ok<MANU> 
            outputArg = [];
        end
        
        function outputArg = toc(obj, ~)
            outputArg = obj.nextTocTime;
        end
    end
end
