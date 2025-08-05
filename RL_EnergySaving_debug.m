% Com = '/dev/tty.usbmodem1414201';
clear all



Com_leader = 'com5';
Com_follower   = 'com6';

%% 
newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
 
clear Obj_leader Obj_follower 

%% 
% Obj_leader=serial(Com_leader,'baudrate',9600);
% fopen(Obj_leader);
% pause(1);
% 
% Obj_follower=serial(Com_follower,'baudrate',9600);
% fopen(Obj_follower);
% pause(1);
% pause(60)  % 60 seconds


Obj_leader = serialport(Com_leader,9600);
Obj_follower = serialport(Com_follower,9600);

% configureTerminator(Obj_leader,"CR/LF");
% flush(Obj_leader);
% Obj_leader.UserData = struct("Data",[],"Count",1);
% configureCallback(Obj_leader,"terminator",@readSineWaveData);


% configureTerminator(Obj_follower,"CR/LF");
% flush(Obj_follower);
% Obj_follower.UserData = struct("Data",[],"Count",1);
% configureCallback(Obj_follower,"terminator",@readSineWaveData);

sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); % leader current
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current'); % follower current
addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage'); % leader thrust
addAnalogInputChannel(sp,'Dev1', 'ai0', 'Voltage'); % follower thrust
addAnalogInputChannel(sp,'Dev1', 'ai3', 'Voltage'); % leader voltage
addAnalogInputChannel(sp,'Dev1', 'ai2', 'Voltage'); %follower voltage
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second 

%% 
frequency = 1 ; % frequency 
amplitude = 20 ; % amplitude
phase = 10; % phase = 0.2*pi
leader_data = [10, int16(frequency*10), amplitude, phase, 255];
% fwrite(Obj,int16(sendData));


% follower_data = [10, int16(frequency*10), amplitude, 0, 255];
    
leader_data


% fwrite(Obj_leader,int16(leader_data));
% fwrite(Obj_follower,int16(follower_data));
% StepCtr.fire

write(Obj_leader,leader_data,"uint8");
% write(Obj_follower,follower_data,"uint8");

StepCtr.fire;

data = sp.startForeground;

stop = [10,0,0,0,255];
% fwrite(Obj_follower,int16(stop));
% fwrite(Obj_leader,int16(stop));

write(Obj_leader,stop,"uint8");

StepCtr.fire;
% ldata=[];



% for ii = 1:3
% data = readline(Obj_leader);
% ldata = [ldata,str2num(data)];
% data = readline(Obj_follower);
% fdata = [fdata,str2num(data)];
% end
% disp('leader data');ldata
% disp('follower data');fdata

%% 




%%
stop = [10,0,0,0,255];
% fwrite(Obj_follower,int16(stop));
% fwrite(Obj_leader,int16(stop));

write(Obj_leader,stop,"uint8");
write(Obj_follower,stop,"uint8");
StepCtr.fire;
% 
% ldata=[];
% fdata=[];
% for ii = 1:3
% data = readline(Obj_leader);
% ldata = [ldata,str2num(data)];
% data = readline(Obj_follower);
% fdata = [fdata,str2num(data)];
% end
% disp('leader data');ldata
% disp('follower data');fdata

%% 


%% function

function readSineWaveData(src, ~)

% Read the ASCII data from the serialport object.
data = readline(src);

% Convert the string data to numeric type and save it in the UserData
% property of the serialport object.
src.UserData.Data(end+1) = str2double(data);

% Update the Count value of the serialport object.
src.UserData.Count = src.UserData.Count + 1;

% If 1001 data points have been collected from the Arduino, switch off the
% callbacks and plot the data.
if src.UserData.Count > 1001
    configureCallback(src, "off");
    plot(src.UserData.Data(2:end));
end
end


