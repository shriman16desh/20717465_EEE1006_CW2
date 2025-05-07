function temp_prediction(a)
% This code monitors temperature rate and predicts future temp
%   Continuously reads the sensor's data and:
%   - Displays current temp and predicted temp in 5 minutes
%   - Turns RED LED on if rate > +4 °C/min
%   - Turns YELLOW LED on if rate < -4 °C/min
%   - Turns GREEN LED on if temp is stable within 18–24°C and rate is mild


% Configuration, similar to task 2
analogPin = 'A0';
greenLED = 'D2';
yellowLED = 'D3';
redLED = 'D4';

V0 = 0.5;
TC = 0.01;

% Configure LED pins
configurePin(a, greenLED, 'DigitalOutput');
configurePin(a, yellowLED, 'DigitalOutput');
configurePin(a, redLED, 'DigitalOutput');

% Initialize variables
temps = [];
times = [];

start_time = datetime('now');

disp('Starting temperature prediction...');

while true
    % Current time and temp
    t_now = seconds(datetime('now') - start_time);
    voltage = readVoltage(a, analogPin);
    temp = (voltage - V0) / TC;

    % Store data
    temps(end+1) = temp;
    times(end+1) = t_now;

    % Only calculate rate if we have enough data
    if length(temps) >= 6
        % Take the last 6 values (approx 5 seconds if 1s interval)
        T_window = temps(end-5:end);
        time_window = times(end-5:end);

        % Linear fit: slope = dT/dt
        p = polyfit(time_window, T_window, 1);
        dT_dt = p(1);  % °C per second
        dT_per_min = dT_dt * 60;

        % Predict future temp
        temp_5min = temp + dT_dt * 300;

        % Print values
        fprintf('Time: %.1f s | Temp: %.2f °C | dT/dt: %.2f °C/min | Predicted in 5min: %.2f °C\n', ...
                t_now, temp, dT_per_min, temp_5min);

        % LED control
        writeDigitalPin(a, greenLED, 0);
        writeDigitalPin(a, yellowLED, 0);
        writeDigitalPin(a, redLED, 0);

        if dT_per_min > 4
            writeDigitalPin(a, redLED, 1);
        elseif dT_per_min < -4
            writeDigitalPin(a, yellowLED, 1);
        elseif temp >= 18 && temp <= 24
            writeDigitalPin(a, greenLED, 1);
        end
    end

    pause(1);
end
end
