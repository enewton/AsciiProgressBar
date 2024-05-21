classdef ProgressBar < handle
    %PROGRESSBAR Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access=public)
        outputStream = 1;
        timeFilterWindow = 5;
        formatString = 'Progress: {bar} Time remaining: {timeRemaining}';
        formatTime = '%0.1f'
        formatDateTime = 'dd-mmm-yyyy HH:MM:SS'

        progressWidth = 20
        progressCharFirst = '['
        progressCharDone = '#'
        progressCharTodo = '.'
        progressCharEnd = ']'
    end

    % Only overridable for testing
    properties (Access=protected)
        startTime
        funTic = @tic
        funToc = @toc
        funNow = @now
    end

    properties (Access=private)
        latestTime
        totalIterations
        currentIteration = 0
        lastTic
        measurements
        numCharsLastPrinted = 0
    end

    methods
        function obj = ProgressBar(totalIterations)
            obj.totalIterations = totalIterations;
            obj.startTime = obj.funNow();
            obj.latestTime = obj.funNow();
            obj.lastTic = obj.funTic();
            obj.measurements = [];
        end

        function disp(obj, formatString)
            obj.latestTime = obj.funNow();
            obj.measurements = [obj.measurements, obj.funToc(obj.lastTic)];
            if length(obj.measurements) > obj.timeFilterWindow
                obj.measurements = obj.measurements(2:end);
            end

            obj.currentIteration = obj.currentIteration + 1;

            if nargin < 2
                formatString = obj.formatString;
            end

            output = strrep(formatString, '{timeRemaining}', obj.timeRemaining());
            output = strrep(output, '{timeElapsed}', obj.timeElapsed());
            output = strrep(output, '{bar}', obj.progressBar());
            output = strrep(output, '{eta}', obj.etaString());
            output = strrep(output, '{step}', num2str(obj.currentIteration));
            output = strrep(output, '{steps}', num2str(obj.totalIterations));

            fprintf(obj.outputStream, repmat('\b', 1, obj.numCharsLastPrinted));

            obj.numCharsLastPrinted = fprintf(obj.outputStream, '%s', output);

            obj.lastTic = obj.funTic();
        end

        function timeRemaining = timeRemaining(obj)
            timeRemaining = obj.timeAsString(obj.secondsRemaining());
        end

        function timeElaspsed = timeElapsed(obj)
            timeElaspsed = obj.timeAsString((obj.latestTime - obj.startTime)*24*60*60);
        end

        function eta = etaString(obj)
            eta = datestr(obj.latestTime + obj.secondsRemaining()/60/60/24, obj.formatDateTime);
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

    methods (Access=private)
        function str = timeAsString(obj, timeSeconds)
            if timeSeconds < 100
                str = sprintf([obj.formatTime ' seconds'], timeSeconds);
            elseif timeSeconds < 60*60
                str = sprintf([obj.formatTime ' minutes'], timeSeconds/60);
            else
                str = sprintf([obj.formatTime ' hours'], timeSeconds/60/60);
            end
        end
    end
end
