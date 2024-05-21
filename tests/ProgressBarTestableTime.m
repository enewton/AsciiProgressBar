classdef ProgressBarTestableTime < ProgressBar
    %ProgressBarTestableTime   sub-class of ProgressBar so we can override
    %time-based functions for testing purposes

    properties
        nextNowTime
        nextTocTime
    end

    methods
        function obj = ProgressBarTestableTime(totalIterations)
            obj = obj@ProgressBar(totalIterations);
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
