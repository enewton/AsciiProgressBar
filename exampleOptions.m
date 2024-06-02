% Example script demonstrating how to set options for Progress Bar

numLp = 30;

fprintf('Please wait:\n');

% Can specify optional parameters directly as follows:
pb = ProgressBar(numLp, ...
    progressWidth = 30, ...
    progressCharDone = '@', ...
    progressCharTodo = '-', ...
    formatTime = '%03.2f');

for lp = 1:numLp

    % Do some work
    pause(0.1);

    % Display the progress bar
    pb.disp('Progress: {bar} Time remaining: {timeRemaining}');

end

fprintf(' DONE.\n');

% Can specify optional parameters as a struct:
% You could then reuse this struct for subsequent Progress Bars
options = struct( ...
    progressWidth = 30, ...
    progressCharDone = '@', ...
    progressCharTodo = '-', ...
    formatTime = '%03.2f');

pb = ProgressBar(numLp, options);

for lp = 1:numLp

    % Do some work
    pause(0.1);

    % Display the progress bar
    pb.disp('Progress: {bar} Time remaining: {timeRemaining}');

end

fprintf(' DONE.\n');
