% First example script demonstrating how to get a Progress Bar to indicate the
% estimated time for completion, or 'Estimated Time of Arrival'.

numLp = 200;

fprintf('Please wait: ');

% Need to tell it how many iterations there will be
pb = ProgressBar(numLp);

for lp = 1:numLp

        % Do some work
        pause(1);

        % Display the progress bar
        pb.disp('Remaining: {timeRemaining} ETA: {eta}');

end

fprintf('\nAll done.\n');
