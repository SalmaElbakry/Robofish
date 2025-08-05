% Com = '/dev/tty.usbmodem1414201';
clear all


sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); % leader
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current'); % follower
addAnalogInputChannel(sp,'Dev2', 'ai1', 'Voltage');  % leader
addAnalogInputChannel(sp,'Dev2', 'ai0', 'Voltage');  % follower
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second

%StepCtr.fire;

tdata = sp.startForeground;
mean(tdata);
%save('D:\Repeatfish\2501\11218\ZeroOffset', 'tdata');

