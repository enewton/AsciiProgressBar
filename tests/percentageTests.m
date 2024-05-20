classdef percentageTests < matlab.unittest.TestCase
    
    methods (Test)
        
        function fractionComplete_ShouldInitiallyBeZero(testCase)      
            pb = ProgressBar(10);

            testCase.verifyEqual(pb.fractionComplete(), 0);
        end

        function fractionComplete_ShouldUpdateAfterDisp(testCase)      
            pb = ProgressBar(10);

            pb.disp('');
            testCase.verifyEqual(pb.fractionComplete(), 0.1);
        end
    end
end
