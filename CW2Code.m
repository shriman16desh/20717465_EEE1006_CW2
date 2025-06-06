% Shriman Niranjan Deshpande
% egysd8@nottingham.ac.uk

% Tasks 1,2 and 3 may be run individually, as tasks 2 and 3 are on a loop
% with infinite duration and utilise the same LEDs. A clear command is to
% be run after each task.

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

% A Github account was created, and git was downloaded.
% A repository named 20717465_EEE1006_CW2 was created.
% The local MATLAB folder was linked to the repository.
% All coursework files were included into the repository.
% Arduinio Uno was connected and setup completed.
% Arduino Communication was tested using a red LED.

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
disp('----------');
disp('TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE');
disp(' ');
% Step 1: Connect the Arduino to the PC and the Thermistor via the
% breadboard. AnalogPin 'A0' is used in this question.
a = arduino('COM3', 'Uno');
analogPin = 'A0';

% Data acquisition setup
duration = 600;             
sampling_interval = 60;      
num_samples = duration / sampling_interval;

voltages = zeros(1, num_samples);
temperatures = zeros(1, num_samples);

% The following are the sensor callibration values as given in the shared
% pdf for MCP9700A type thermistor.
V0 = 0.5;
TC = 0.01;

% Start collecting the data.
fprintf('Starting temperature logging...\n');
startTime = datetime('now');

for i = 1:num_samples
    volt = readVoltage(a, analogPin);
    temp = (volt - V0) / TC;
    voltages(i) = volt;
    temperatures(i) = temp;
    pause(sampling_interval);
end

max_temp = max(temperatures);
min_temp = min(temperatures);
avg_temp = mean(temperatures);

%Plotting the temperature over time
time = 0:sampling_interval:(duration - sampling_interval);
figure;
plot(time, temperatures, 'b', 'LineWidth', 1.5);
xlabel('Time (seconds)');
ylabel('Temperature (°C)');
title('Cabin Temperature over Time');
grid on;

% Print to screen as formatted like Table 1:
location = 'Nottingham';
date_now = datestr(startTime, 'dd/mm/yyyy');

fprintf('\n\t\tData logging initiated - %s\n', date_now);
fprintf('\t\tLocation - %s\n\n', location);

for i = 1:num_samples
    fprintf('Minute\t%d\n', i-1);
    fprintf('Temperature\t%.2f C\n\n', temperatures(i));
end

fprintf('Max temp\t%.2f C\n', max_temp);
fprintf('Min temp\t%.2f C\n', min_temp);
fprintf('Average temp\t%.2f C\n\n', avg_temp);
fprintf('\t\tData logging terminated\n');

% Step e as given in the assignment document:
fileID = fopen('cabin_temperature.txt', 'w');

fprintf(fileID, 'Data logging initiated - %s\n', date_now);
fprintf(fileID, 'Location - %s\n\n', location);

for i = 1:num_samples
    fprintf(fileID, 'Minute\t%d\n', i-1);
    fprintf(fileID, 'Temperature\t%.2f C\n\n', temperatures(i));
end

fprintf(fileID, 'Max temp\t%.2f C\n', max_temp);
fprintf(fileID, 'Min temp\t%.2f C\n', min_temp);
fprintf(fileID, 'Average temp\t%.2f C\n\n', avg_temp);
fprintf(fileID, 'Data logging terminated\n');

fclose(fileID);
disp('----------');
disp(' ');

clear
%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
disp('----------');
disp('TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION');
disp(' ');

% The code is a function given in the file titled 'temp_monitor.m'
a = arduino('COM3', 'Uno');
temp_monitor(a);
disp('----------');
disp(' ');

% temp_monitor is a real time monitoring function that reads temperature
% from a MCP9700A sensor connected to an Arduino Uno analog pin. It
% controls green, yellow and red LEDs to indicate if the cabin temperature
% is within, below or above a certain range. The function runs
% indefinitely, updating a live temperature graph and flashing the LEDs as
% needed.
clear
%% TASK 3 - ALGORITHMS - TEMPERATURE PREDICTION [25 MARKS]
disp('----------');
disp('TASK 3 - ALGORITHMS - TEMPERATURE PREDICTION');
disp(' ');

% The code is a function given in the file titled 'temp_prediction.m'
a = arduino('COM3', 'Uno');
temp_prediction(a)
disp('----------');
disp(' ');

% temp_prediction is a real time temperature prediction function for the
% MCP9000A sensor connected to an Arduino Uno analog pin. This function can
% calculate how quickly the temperature is changing in °C/min, and print
% out the current and predicted temperature after 5 minutes, while
% activating LEDs to reflect the rate of change of temperature. A green LED
% indicates stable condition, red indates rapid increase in temperature and
% yellow indicates rapid decrease in temperature.
clear
%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% During this coursework, one of the smaller difficulties I encountered was
% setting up the arduino and connecting it to MATLAB. The setup guide would
% not show the arduino even after I had connected it. This was magically
% fixed when i tried it after a few days. The main difficulty was time
% management as I started the coursework when only a few days were left for
% the submission date, which meant I had to work in a rushed manner.
% Writing up the function code for tasks 2 and 3 was also quite
% challenging, and took multiple attempts. One of my strengths, on the
% other hand, was working with the electronic equipment such as the LEDs
% and Thermistor on the breadboard. I found this quite simple as I had
% worked with such parts before. Assembling the circuit barely took any
% time whatsoever. This helped me focus more on the coding side of the
% coursework. A key succes was getting real time feedback through LED
% responses and temerature graphing, which made the system more interactive
% and easy to test. Although the timing in MATLAB is not always accurate,
% the LED behaviour was generally observed to be precise. Overall, this
% coursework was a great learning experience.

%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.

clear