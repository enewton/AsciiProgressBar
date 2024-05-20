classdef ProgressBar < handle
    %PROGRESSBAR Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access=public)
        outputStream = 1;
        timeFilterWindow = 5;
        formatString = 'Progress: {bar} Time remaining: {timeRemaining}';
        formatTime = '%0.1f'

        progressWidth = 20
        progressCharFirst = '['
        progressCharDone = '#'
        progressCharTodo = '.'
        progressCharEnd = ']'
    end

    properties (Access=private)
        totalIterations
        currentIteration = 0
        lastTic
        measurements
        numCharsLastPrinted = 0
    end

    methods
        function obj = ProgressBar(totalIterations)
            obj.totalIterations = totalIterations;
            obj.lastTic = tic();
            obj.measurements = [];
        end

        function disp(obj, formatString)
            obj.measurements = [obj.measurements, toc(obj.lastTic)];
            if length(obj.measurements) > obj.timeFilterWindow
                obj.measurements = obj.measurements(2:end);
            end

            obj.currentIteration = obj.currentIteration + 1;

            if nargin < 2
                formatString = obj.formatString;
            end

            output = strrep(formatString, '{timeRemaining}', obj.timeRemaining());
            output = strrep(output, '{bar}', obj.progressBar());

            fprintf(obj.outputStream, repmat('\b', 1, obj.numCharsLastPrinted));

            obj.numCharsLastPrinted = fprintf(obj.outputStream, '%s', output);

            obj.lastTic = tic();
        end

        function timeRemaining = timeRemaining(obj)
            secondsRemaining = obj.secondsRemaining();
            if secondsRemaining < 100
                timeRemaining = sprintf([obj.formatTime ' seconds'], secondsRemaining);
            elseif secondsRemaining < 60*60
                timeRemaining = sprintf([obj.formatTime ' minutes'], secondsRemaining/60);
            else
                timeRemaining = sprintf([obj.formatTime ' hours'], secondsRemaining/60/60);
            end
        end

        function seconds = secondsRemaining(obj)
            seconds = (obj.totalIterations - obj.currentIteration) * mean(obj.measurements);
        end

        function fraction = fractionComplete(obj)
            fraction = obj.currentIteration / obj.totalIterations;
        end

        function barString = progressBar(obj)
            numCompleteChars = floor(obj.progressWidth * obj.fractionComplete());
            barString = [obj.progressCharFirst, ...
                repmat(obj.progressCharDone,1,numCompleteChars), ...
                repmat(obj.progressCharTodo,1,obj.progressWidth-numCompleteChars), ...
                obj.progressCharEnd];
        end
    end
end
