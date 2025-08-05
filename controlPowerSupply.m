
% Define IP address and port
ipAddress = '10.126.17.79';
port = 10001;
voltage = 7.4; % Voltage in volts

% Open TCP/IP connection
t = tcpip(ipAddress, port, 'NetworkRole', 'client');
t.Timeout = 10; % Set a timeout of 10 seconds
fopen(t);

% List of commands to send
commands = {
    'UPMODE:NORMAL';  % Set to normal mode
    'LOOP:V';         % Set to constant voltage
    'MON';            % Turn output On
    sprintf('MWV:%0.2f', voltage);  % Set voltage
    'SETFLOAT:F'      % Set float
};

% Send each command and receive a response
try
    for i = 1:length(commands)
        fprintf(t, '%s\r\n', commands{i});  % Send command
        pause(0.1);  % Wait a little for the command to process
        response = fscanf(t);  % Read response
        fprintf('Command: %s, Response: %s\n', commands{i}, response);
    end
catch e
    fprintf('Error sending commands: %s\n', e.message);
end



pause(10);
fprintf(t, '%s\r\n','MOFF');  % Send command


% Close connection
fclose(t);
delete(t);
clear t;
