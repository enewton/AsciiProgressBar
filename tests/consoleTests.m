classdef consoleTests < matlab.unittest.TestCase

    methods (Test)
        function disp_defaultFormatString(testCase)
            pb = ProgressBar(10);

            output = evalc("pb.disp()");

            testCase.verifyEqual(output, 'Progress: [##..................] Time remaining: 0.0 seconds');
        end

        function disp_progressBar(testCase)
            pb = ProgressBar(10); %#ok<*NASGU> 

            output = evalc("pb.disp('Progress {bar}')");

            testCase.verifyEqual(output, 'Progress [##..................]');
        end
    end
end
