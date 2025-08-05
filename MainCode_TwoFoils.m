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
leader = true;
follower = true;
flag_return = false;
distance = ' 5 0 0 -50';%distance = ' 8 -80 0 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
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
Flow_Speed = 50;
Body_length = 80; % bodylength in mm
frequency = 1.5;
Nor_Amp = 0.2;
amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
Phase_lag = 0;

data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);

disp('**********Parameters setting completed.***********')
%% Calibration sensors when they locate at air
cycle_num = 1;
DX = 0.0;
DY = 0.0;

LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX/Body_length, DY/Body_length, cycle_num);
%%
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
%%
DX = 0.0;
DY = 0.0;
for cycle_num = 1:1:1
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX/Body_length, DY/Body_length, cycle_num);
    pause(2);
end
disp('**********Calibration completed.***********')

%% Define the movements metrix, assume the initial DY distance as 60 mm
movements = [
    -20;
    -10;
    0;
    10;
    20;
    30;
    40;
     50;
     60;
%     70;
%     80;
%      90;
%      100;
%     110;
%     120;
];
disp('**********Movements setting completed.************')

Flow_Speed = 50;
Body_length = 80; % bodylength in mm
frequency = 2;
Nor_Amp = 0.20;
Phase_lag = 0;

amplitude = round(rad2deg(asin((Body_length .* Nor_Amp) / (Body_length - 5))), 1);
%%  Manually make two foils with a distance shown in movements metrix
for k = 1:length(movements)
    
DX = movements(k, 1);
DYStep = 0;
DY_inital = 55; 

% %%
%    if k == 1
%      disp('**********K = 1***********')
%    else
%       mode = ' distance';
%       leader = false;
%       follower = true;
%       flag_return = false;
%       distance = ' 1 -10 0 0';
%       filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
%       
%       StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
%       pause(3);
%       StepCtr.fire;
%       pause(3);
%    end
%% Collect data at a spefic DX


% To zero position

frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(3);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:1
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX/Body_length, DY/Body_length, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

% --------- DX = movements(i, 1); DY = DY_inital + 10;------- %
DYStep = DYStep + 10;

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;
pause(3);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(3);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:1
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX/Body_length, DY/Body_length, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

% --------- DX = movements(i, 1); DY = DY_inital + 20;------- %
DYStep = DYStep + 10;

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;
pause(3);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(3);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:1
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX/Body_length, DY/Body_length, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


% --------- DX = movements(i, 1); DY = DY_inital + 50;------- %
DYStep = DYStep + 10;

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;
pause(3);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(3);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:1
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX/Body_length, DY/Body_length, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);


% --------- DX = movements(i, 1); DY = DY_inital + 60;------- %
DYStep = DYStep + 10;

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;
pause(3);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(3);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:1
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX/Body_length, DY/Body_length, cycle_num);
    pause(2);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

disp('**********Finish one case, Return two foils at DX***********')

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 2 0 20 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;
pause(3);

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 2 0 -20 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';


StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;
pause(3);

disp('**********Two foils back to their initial DY***********')

disp('**********Move distanc in X direction***********')

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 -10 0 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;
pause(3);

disp('**********Two foils back to their initial DY***********')



DX
end

disp('**********FINISH ALL TEST, CHANGE FRE AND AMP***********')
%% Return to initial locations
% 
% mode = ' distance';
% leader = true;
% follower = true;
% flag_return = false;
% distance = ' 8 0 0 -80';
% filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
% 
% StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
% pause(3);
% StepCtr.fire;
% pause(3);
% 
mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 9 90 0 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(3);
StepCtr.fire;

