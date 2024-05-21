classdef timingTests < matlab.unittest.TestCase

    methods (Test)

        function secondsRemaining(testCase)
            pb = ProgressBarTestableTime(10);
            pb.nextTocTime = 0.5; % seconds

            pb.disp('')

            % If 1 iteration took 0.5s, then we have 9 x 0.4s = 4.5 remaining
            testCase.verifyEqual(pb.secondsRemaining(), 4.5);
        end

        function timeRemaining_seconds(testCase)
            pb = ProgressBarTestableTime(10);
            pb.nextTocTime = 0.5; % seconds

            pb.disp('')

            % If 1 iteration took 0.5s, then we have 9 x 0.4s = 4.5 remaining
            testCase.verifyEqual(pb.timeRemaining(), '4.5 seconds');
        end

        function timeRemaining_minutes(testCase)
            pb = ProgressBarTestableTime(100);
            pb.nextTocTime = 6; % seconds

            pb.disp('')

            % If 1 iteration took 6s, then we have 99 x 6 / 60 = 9.9 minutes remaining
            testCase.verifyEqual(pb.timeRemaining(), '9.9 minutes');
        end

        function timeRemaining_hours(testCase)
            pb = ProgressBarTestableTime(6);
            pb.nextTocTime = 30*60; % seconds

            % After 3 iterations
            pb.disp('')
            pb.disp('')
            pb.disp('')

            % If each iteration took 1/2hr, then we have 3 * 1/2hr = 1.5 hours remaining
            testCase.verifyEqual(pb.timeRemaining(), '1.5 hours');
        end

        function timeElaspsed_seconds(testCase)
            pb = ProgressBarTestableTime(10, datenum('12:00:00'));

            pb.disp('')
            pb.disp('')

            pb.nextNowTime = datenum('12:00:23');
            pb.disp('')

            elapsedTime = pb.timeElapsed();

            testCase.verifyEqual(elapsedTime, '23.0 seconds');
        end

        function timeElaspsed_minutes(testCase)
            pb = ProgressBarTestableTime(10, datenum('12:00:00'));

            pb.disp('')
            pb.disp('')

            pb.nextNowTime = datenum('12:45:00');
            pb.disp('')

            elapsedTime = pb.timeElapsed();

            testCase.verifyEqual(elapsedTime, '45.0 minutes');
        end

        function timeElaspsed_hours(testCase)
            pb = ProgressBarTestableTime(10, datenum('12:00:00'));

            pb.disp('')
            pb.disp('')

            pb.nextNowTime = datenum('14:00:00');
            pb.disp('')

            elapsedTime = pb.timeElapsed();

            testCase.verifyEqual(elapsedTime, '2.0 hours');
        end

        function secondsRemaining_averagingAfter5Measurements(testCase)
            pb = ProgressBarTestableTime(15);

            pb.nextTocTime = 5.1; % seconds
            pb.disp('')

            pb.nextTocTime = 5.2; % seconds
            pb.disp('')

            pb.nextTocTime = 5.3; % seconds
            pb.disp('')

            pb.nextTocTime = 5.4; % seconds
            pb.disp('')

            pb.nextTocTime = 5.5; % seconds
            pb.disp('')

            % Time taken to run first 5 iterations = sum([5.1 5.2 5.3 5.4 5.5]) = 26.5 seconds
            % So remaining 10 iterations will be estimated to take 2x26.5 seconds
            testCase.verifyEqual(pb.secondsRemaining(), 53);
        end

        function secondsRemaining_averagingAfter7Measurements(testCase)
            pb = ProgressBarTestableTime(10);

            % These times will be discarded
            pb.nextTocTime = 5.1; % seconds
            pb.disp('')

            pb.nextTocTime = 5.2; % seconds
            pb.disp('')

            % These times will be included in the running average
            pb.nextTocTime = 5.3; % seconds
            pb.disp('')

            pb.nextTocTime = 5.4; % seconds
            pb.disp('')

            pb.nextTocTime = 5.5; % seconds
            pb.disp('')

            pb.nextTocTime = 5.6; % seconds
            pb.disp('')

            pb.nextTocTime = 5.7; % seconds
            pb.disp('')

            % Time taken to run first 2 iterations has been discarded from
            % running average
            % Average time taken to run iterations 3-7 = mean([5.3 5.4 5.5 5.6 5.7]) = 5.5 seconds
            % So remaining 3 iterations will be estimated to take 3x5.5 seconds
            testCase.verifyEqual(pb.secondsRemaining(), 16.5, 'AbsTol',1e-12);
        end
    end
end
