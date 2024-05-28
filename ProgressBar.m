classdef ProgressBar < handle
    %ProgressBar   ASCII Progress Bar and time prediction class
    %
    % Example usage:
    %
    %     numSteps = 100;
    %     
    %     % Construct class, telling ProgressBar how many steps there will be
    %     pb = ProgressBar(numSteps);
    %     
    %     for lp = 1:numSteps
    %     
    %         % Do some work
    %         pause(0.1);
    %     
    %         % Display the progress bar
    %         pb.disp("Progress: {bar} Time remaining: {timeRemaining}");
    %     end
    %
    % Written by Erik Newton (https://github.com/enewton/AsciiProgressBar)

    % MIT License
    %
    % Copyright (c) 2024 Erik Newton
    %
    % Permission is hereby granted, free of charge, to any person obtaining a copy
    % of this software and associated documentation files (the "Software"), to deal
    % in the Software without restriction, including without limitation the rights
    % to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    % copies of the Software, and to permit persons to whom the Software is
    % furnished to do so, subject to the following conditions:
    %
    % The above copyright notice and this permission notice shall be included in all
    % copies or substantial portions of the Software.
    %
    % THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    % IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    % FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    % AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    % LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    % OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    % SOFTWARE.

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
