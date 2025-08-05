close all; clear all; clc
%%
% cd('D:\Liang Li\RobotRepeatRealFish\matlab\');
StepCtr.initEnv();

%% Manually make two foils as side-by-side
%   foils should be in air
%   distance should be 100mm
%   Get the DY distance between two foils 
% 
mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 2 0 20 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;

%% Initial data collection
SAMPLE_FREQUENCY = 1000;
COLLECT_TIME = 10;

disp('**********Collection setting completed.***********')
%% Initial servomotor
Com_leader = 'com18';

% close the com if it is open
newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader Obj_follower

% open com
Obj_leader = serialport(Com_leader,9600);

disp('**********Servomotors setting completed.***********')
%% Test_parameter
Flow_Speed = 100;
Body_length = 80; % bodylength in mm
frequency = 2;
Nor_Amp = 0.30;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 180;

data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);

disp('**********Parameters setting completed.***********')
%% Calibration sensors when they locate at air

frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
%%
DX = 0.0;
DY = 0.0;
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end
disp('**********Calibration completed.***********')

%%
% To zero position
DX = 10.0;
DY = 10.0;

Body_length = 100;
Flow_Speed = 120;

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

%Pitching
frequency = 1.0;
Nor_Amp = 0.10;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

%Pitching
frequency = 1.0;
Nor_Amp = 0.15;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 1.0;
Nor_Amp = 0.20;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);
% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 1.0;
Nor_Amp = 0.25;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

%Pitching
frequency = 1.0;
Nor_Amp = 0.30;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 1.5;
Nor_Amp = 0.10;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 1.5;
Nor_Amp = 0.15;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 1.5;
Nor_Amp = 0.20;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 1.5;
Nor_Amp = 0.25;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 1.5;
Nor_Amp = 0.30;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

%Pitching
frequency = 2.0;
Nor_Amp = 0.10;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 2.0;
Nor_Amp = 0.15;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 2.0;
Nor_Amp = 0.20;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 2.0;
Nor_Amp = 0.25;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


%Pitching
frequency = 2.0;
Nor_Amp = 0.30;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data

for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

disp('**********Change Flow Speed***********')
