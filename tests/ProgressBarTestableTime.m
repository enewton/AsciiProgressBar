classdef ProgressBarTestableTime < ProgressBar
    %ProgressBarTestableTime   sub-class of ProgressBar so we can override
    %time-based functions for testing purposes

    properties
        nextNowTime
        nextTocTime = 1/24/60/60
    end

    methods
        function obj = ProgressBarTestableTime(totalIterations, startTime)
            obj = obj@ProgressBar(totalIterations);
            if nargin >= 2
                obj.startTime = startTime;
            end
            obj.funNow = @obj.now;
            obj.funTic = @obj.tic;
            obj.funToc = @obj.toc;
        end

        function outputArg = now(obj) %#ok<*MANU>
            outputArg = obj.nextNowTime;
        end

        function outputArg = tic(obj)
            outputArg = [];
        end

        function outputArg = toc(obj, ~)
            outputArg = obj.nextTocTime;
        end
    end
end
