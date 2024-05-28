% Example script demonstrating how to get a Progress Bar to indicate 'step
% number'

numLp = 100;

fprintf('Please wait: ');

% Need to tell it how many iterations there will be
pb = ProgressBar(numLp);

for lp = 1:numLp

        % Do some work
        pause(0.1);

        % Display the progress bar
        pb.disp('Step {step} of {steps}');

end

fprintf('\nAll done.\n');
