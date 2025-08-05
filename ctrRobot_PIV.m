% Com = '/dev/tty.usbmodem1414201';
%%%% edit by Li-Ming Chao  04.07.2022%%%
clear all
close all
clc

%%
% s                   = daq.createSession('ni');
% % addAnalogInputChannel(s,'cDAQ1Mod1', 1, 'Current');
% s.addAnalogInputChannel('Dev2', 'ai0', 'Voltage');
% s.Rate              = 5000;
% s.DurationInSeconds = 10; % 1 second
% 
% 
% sp                  = daq.createSession('ni');
% % addAnalogInputChannel(s,'cDAQ1Mod1', 1, 'Current');
% addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');
% sp.Rate              = 5000;
% sp.DurationInSeconds = 10; % 1 second

%% Initial
Com_robot = 'com5';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
obj_robot=serial(Com_robot,'baudrate',9600);
fopen(obj_robot);
pause(1);

%%%%%%%%%%%%%Get Voltage and Current data%%%%%%%%%
%%
frequency = 2.0 ; % frequency
amplitude = 25; % amplitude
phase = 0; %phase = 0.2*pi

f_ratio = 8;
A_ratio = 16;

sendData = [10, int16(frequency*10), amplitude, phase,f_ratio,A_ratio, 255];
fwrite(obj_robot,int16(sendData));
 
% currents = sp.startForeground;
% voltages = s.startForeground;
% pause(20);
%%
% stop = [10,0,0,0,0,0,255];
% fwrite(obj_robot,int16(stop));
%%
% voltage = mean(voltages(30000:50000))
% current = mean(currents(30000:50000))


                
                