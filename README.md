# ASCII Progress Bar

## Introduction

This class creates a progress message in the MATLAB console, useful when
processing long loops. It can display an ASCII progress bar as well as estimate
the remaining time by profiling the initial loops.

There are many other MATLAB progress bars out there, but here are a few reasons
why this one is worth considering:

1. It is designed to be simple to use initially, and yet be very powerful and
   configurable.

2. It can be distributed via a single file `ProgressBar.m` which also contains a
   duplicate of the `LICENSE`.

You need to construct an instance of `ProgressBar` telling it how many
iterations the loop will be. If running nested loops, then initialise it with
the product of all the loop sizes (See exampleBasic.m)

## Example

In the example below, we have a loop, with a `pause` to simulate some work being
done. In a real application, this is where you would be running your slow
algorithm, loading a file etc.

    numSteps = 100;

    % Need to tell ProgressBar how many steps there will be
    pb = ProgressBar(numSteps);
    
    for lp = 1:numSteps
    
        % Do some work
        pause(0.1);
    
        % Display the progress bar
        pb.disp("Progress: {bar} Time remaining: {timeRemaining}");
    end

The above code wiil display the following animated display in the console:

```
Progress: [########............] Time remaining: 5.4 seconds
```

## Options

The following placeholder strings enclosed in {braces} can be used in the `disp`
format string:

| Field Placeholder | Description                                                               | Associated Example |
| ----------------- | ------------------------------------------------------------------------- | ------------------ |
|  {bar}            | ASCII graphical progress bar                                              | exampleBasic.m     |
|  {eta}            | 'Estimated Time of Arrival'. Estimate of absolute date/time of completion | exampleEta.m       |
|  {timeRemaining}  | Estimated time remaining in sensible units. (seconds/minutes/hours)       | exampleBasic.m     |
|  {timeElapsed}    | Elapsed time in sensible units. (seconds/minutes/hours)                   | exampleEta.m       |
|  {step}           | Current iteration number.                                                 | exampleSteps.m     |
|  {steps}          | Total number of iterations to complete                                    | exampleSteps.m     |

In addition to defining your own format string, you can also set a number of
other properties via the `ProgressBar` constructor. See `exampleOptions.m`.

## Tests

The project is fully unit tested. To run the tests on your version of MATLAB,
simply run the script `runTests.m`. Please report any failures, mentioning the
MATLAB version and ProgressBar version you used.

## Limiations

1. Not looked at parfor support yet.
