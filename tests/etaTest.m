classdef etaTest < matlab.unittest.TestCase

    methods (Test)
        function secondsRemaining(testCase)   
            pb = ProgressBarTestableTime(6);
            pb.nextNowTime = datenum('22-May-2024 12:00');
            pb.nextTocTime = 60*60; % 1 hour

            output = evalc("pb.disp('ETA: {eta}')");
            
            % If 1 iteration took 1Hr, then we have another 5hrs remaining
            testCase.verifyEqual(output, 'ETA: 22-May-2024 17:00:00');
        end
    end
end
