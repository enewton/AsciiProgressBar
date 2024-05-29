classdef optionsTest < matlab.unittest.TestCase
    methods (Test)
        function construct_withMultipleParameters(testCase)
            pb = ProgressBar(10, progressWidth=10, progressCharFirst='{', progressCharEnd='}');

            result = pb.progressBar();

            testCase.verifyEqual(result, '{..........}');
        end

        function construct_withParameterStructure(testCase)
            options = struct(progressWidth=10, progressCharFirst='{', progressCharEnd='}');
            pb = ProgressBar(10, options);

            result = pb.progressBar();

            testCase.verifyEqual(result, '{..........}');
        end

        function construct_invalidOption(testCase)
            pb = @() ProgressBar(10, notAnOption=12);

            testCase.verifyError(pb, 'PROGRESS_BAR:INVALID_OPTION');
        end
    end
end
