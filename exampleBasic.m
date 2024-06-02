% Example script demonstrating how to get a Progress Bar in your application by
% adding 2 lines:

numX = 10;
numY = 5;

fprintf('Please wait: ');

% Need to tell it how many iterations there will be
pb = ProgressBar(numX * numY);

for lpx = 1:numX
    for lpy = 1:numY

        % Do some work
        pause(0.2);

        % Display the progress, with your own format
        pb.disp('Progress: {bar} Time remaining: {timeRemaining}');

    end
end

fprintf('\nAll done.\n');
