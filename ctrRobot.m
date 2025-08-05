% Com = '/dev/tty.usbmodem1414201';
Com_follower = 'com5';
Com_leader   = 'com6';

% %%%% setting for power cost
spp                   = daq.createSession('ni');
% addAnalogInputChannel(s,'cDAQ1Mod1', 1, 'Current');
addAnalogInputChannel(spp,'cDAQ1Mod1', 0, 'Current');
spp.Rate              = 2000;
spp.DurationInSeconds = 10; % 1 second 
% % data                = s.startForeground;


%%%% setting for data acqusition 
s                   = daq.createSession('ni');
% addAnalogInputChannel(s,'cDAQ1Mod1', 1, 'Current');
s.addAnalogInputChannel('Dev2', 'ai0', 'Voltage');
s.Rate              = 2000;
s.DurationInSeconds = 10; % 1 second 
% data                = s.startForeground;

data_pre = s.startForeground;
data_p_pre = spp.startForeground;

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
 
Obj_leader=serial(Com_leader,'baudrate',9600);
fopen(Obj_leader);
pause(1);

Obj_follower=serial(Com_follower,'baudrate',9600);
fopen(Obj_follower);
pause(1);
% pause(60)  % 60 seconds
 
frequency = 2.0 ; % frequency 
amplitude = 10 ; % amplitude
phase = 0; % phase = 0.2*pi
sendData = [10, int16(frequency*10), amplitude, phase, 255];


leader_data = sendData;

fwrite(Obj_leader,int16(leader_data));
fwrite(Obj_follower,int16(sendData));
data = s.startForeground;
data_p = spp.startForeground;

pause(10)
% 
stop = [10,0,0,0,255];
fwrite(Obj_follower,int16(stop));
fwrite(Obj_leader,int16(stop));

fclose(Obj_follower);
fclose(Obj_leader);

%plot(data-data_pre);

%figure
%plot(data_p-data_p_pre);

Voltage_data = data-data_pre ;
Current_data = data_p-data_p_pre;

save('D:\Li-Ming\test\noise\water\VOLTAGE_base_1.mat','Voltage_data');
save('D:\Li-Ming\test\noise\water\CURRENT_base_1.mat','Current_data');
