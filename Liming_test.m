clear all
clc
%%
% cd('D:\Liang Li\RobotRepeatRealFish\matlab\');
StepCtr.initEnv();

%%
Com_leader = 'com5';

% close the com if it is open
newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader Obj_follower

% open com
Obj_leader = serialport(Com_leader,9600);

%% Save the force/torque data for calibration
SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 0.0;
DY = 0.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
end
disp('**********Calibration completed.***********')
%% Move fish from air to water
mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 10 0 0 100';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move***********')



%% Pitching the foil: Initial distance between two fish is 8.0cm
frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 0.0;
DY = 8.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('**********Experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");


%% 

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 0.0 DY = 9.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 0.0;
DY = 9.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 0.0 DY = 9.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");


%% 
mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DY = 10.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 0.0;
DY = 10.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 0.0 DY = 10.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DY = 11.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 0.0;
DY = 11.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 0.0 DY = 11.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DY = 12.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 0.0;
DY = 12.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 0.0 DY = 12.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 4 -40 0 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 4.0 DY = 12.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 4.0;
DY = 12.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 4.0 DY = 12.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");
%%

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 4.0 DY = 11.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 4.0;
DY = 11.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 4.0 DY = 11.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");
%%

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 4.0 DY = 10.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 4.0;
DY = 10.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 4.0 DY = 10.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 4.0 DY = 9.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 4.0;
DY = 9.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 4.0 DY = 9.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 4.0 DY = 8.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 4.0;
DY = 8.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 4.0 DY = 8.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");


%%

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 4 -40 0 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 8.0 DY = 8.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 8.0;
DY = 8.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 8.0 DY = 8.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 8.0 DY = 9.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 8.0;
DY = 9.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 8.0 DY = 9.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%


mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 1 0 10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 8.0 DY = 10.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 8.0;
DY = 10.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 8.0 DY = 10.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 8.0 DY = 11.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 8.0;
DY = 11.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 8.0 DY = 11.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 -10 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 8.0 DY = 12.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 8.0;
DY = 12.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 8.0 DY = 12.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");

%%
mode = ' distance';
leader = false;
follower = true;
flag_return = false;
distance = ' 4 -40 0 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to DX = 12.0 DY = 12.0cm ***********')

frequency = 2;
amplitude = 20;
phase_lag = 0;

leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];

write(Obj_leader,leader_data,"uint8");

pause(20);

SAMPLE_FREQUENCY = 1000; % Hz
COLLECT_TIME = 10;       % seconds
DX = 12.0;
DY = 12.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
    pause(10);
end 
disp('********** DX = 12.0 DY = 12.0cm experiment completed.***********')

% Stop the pitching
stop = [10,0,0,0,255];
write(Obj_leader,stop,"uint8");
