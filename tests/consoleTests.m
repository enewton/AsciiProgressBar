classdef consoleTests < matlab.unittest.TestCase

    methods (Test)

        function disp_progressBar(testCase)
            str = testCase.applyFixture(StdoutFixture);
            
            pb = ProgressBar(10);

            pb.outputStream = str.stream();

            pb.disp('Progress {bar}')

            testCase.verifyEqual(str.currentOutput(), 'Progress [##..................]');
        end
    end
end
