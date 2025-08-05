
%%
clear all

Com_follower   = 'com5';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_follower


Obj_follower = serialport(Com_follower,9600);

cd('D:\Liang Li\RobotRepeatRealFish\matlab\');

StepCtr.initEnv();

sp                   = daq.createSession('ni');
sp.Rate              = 5000;
%addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader power
addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');  %% follower force
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');  %% follower input  current
addAnalogInputChannel(sp,'Dev1', 'ai3', 'Voltage');  %% follower input voltage

sp.DurationInSeconds = 10; % 1 second

%%
frequency = 3; % frequency
amplitude = 30; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 0;
A_ratio = 0;

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\calibration\fish\3hz_30degree_150Rpm_5.mat'), 'tdata');%3hz_30degree_150Rpm_5

stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

max(tdata)
mean(tdata)
min(tdata)

