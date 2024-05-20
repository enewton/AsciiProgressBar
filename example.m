
loopSize = 20;

disp('Please wait:')

pb = ProgressBar(loopSize);

for lp = 1:loopSize

    % Do some work
    pause(0.5);

    % Display the progress bar
    pb.disp('Progress: {bar} Time remaining: {timeRemaining}');

end
