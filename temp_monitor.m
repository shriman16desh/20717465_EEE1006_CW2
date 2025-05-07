function temp_monitor(a)
% TEMP_MONITOR Monitors temperature from MCP9000A sensor and controls LEDs.
%   Continuously reads temperature from analog pin A0 and:
%   - Blinks YELLOW LED on D3 if < 18°C
%   - Keeps GREEN LED on D2 if between 18–24°C
%   - Blinks RED LED on D4 if > 24°C
%   Also plots live temperature vs. time graph.


% Pin configuration
analogPin = 'A0';
greenLED = 'D2';
yellowLED = 'D3';
redLED = 'D4';

% MCP9000A sensor calibration
V0 = 0.5;
TC = 0.01;

% Initialize LED pins
configurePin(a, greenLED, 'DigitalOutput');
configurePin(a, yellowLED, 'DigitalOutput');
configurePin(a, redLED, 'DigitalOutput');

% Initialize data for plotting
temps = [];
times = [];
start_time = datetime('now');

figure;
hold on;
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Live Temperature Monitoring');
grid on;

% Infinite loop
while true
    
    voltage = readVoltage(a, analogPin);
    temp = (voltage - V0) / TC;

    t = seconds(datetime('now') - start_time);
    
    % Append to data
    temps(end+1) = temp;
    times(end+1) = t;
    
    % Update plot
    plot(times, temps, 'b', 'LineWidth', 1.5);
    xlim([max(0, t-60) t+5]); 
    ylim([min(temps)-2, max(temps)+2]);
    drawnow;

    % Turn off all LEDs first
    writeDigitalPin(a, greenLED, 0);
    writeDigitalPin(a, yellowLED, 0);
    writeDigitalPin(a, redLED, 0);

    % Control LEDs based on temperature
    if temp < 18
        writeDigitalPin(a, yellowLED, 1);
        pause(0.5);
        writeDigitalPin(a, yellowLED, 0);
        pause(0.5);
    elseif temp > 24
        writeDigitalPin(a, redLED, 1);
        pause(0.25);
        writeDigitalPin(a, redLED, 0);
        pause(0.25);
    else
        writeDigitalPin(a, greenLED, 1);
        pause(1); 
    end
end
end
