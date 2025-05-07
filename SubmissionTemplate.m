% Insert name here
% Insert email address here


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

% Turn ON the LED
writeDigitalPin(a, 'D9', 1);

% Turn OFF the LED
writeDigitalPin(a, 'D9', 0);

% Make the LED blink at 0.5 second intervals, 10 times
for i = 1:10 
    writeDigitalPin(a, 'D9', 1);
    pause(0.5);                   
    writeDigitalPin(a, 'D9', 0); 
    pause(0.5);                   
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.