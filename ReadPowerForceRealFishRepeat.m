%% 
clear all
sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');
addAnalogInputChannel(sp,'Dev2', 'ai1', 'Voltage');
addAnalogInputChannel(sp,'Dev2', 'ai0', 'Voltage');
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second 
StepCtr.fire;
data = sp.startForeground;
save('C:\Users\liang\Desktop\Repeatfish\2308\StepMotorCtr_test_20171220_145703_12744_13033\follower_only\air\test5','data');


%%
clear all
sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');
addAnalogInputChannel(sp,'Dev2', 'ai1', 'Voltage');
addAnalogInputChannel(sp,'Dev2', 'ai0', 'Voltage');
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second 
data = sp.startForeground;
save('C:\Users\liang\Desktop\Repeatfish\2308\StepMotorCtr_test_20171220_145703_12744_13033\follower_only\air\not_moved','data');

%%
pause(10);
StepCtr.fire;