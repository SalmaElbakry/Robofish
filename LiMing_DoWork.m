function LiMing_DoWork(Flow_Speed, SAMPLE_FREQUENCY, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY_inital, DYStep)



% To zero position
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(COLLECT_TIME);
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
pause(5);
StepCtr.fire;
pause(5);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(COLLECT_TIME);
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
pause(5);
StepCtr.fire;
pause(5);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY,  frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(COLLECT_TIME);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

% --------- DX = movements(i, 1); DY = DY_inital + 30;------- %
% DYStep = DYStep + 10;
% 
% mode = ' distance';
% leader = false;
% follower = true;
% flag_return = false;
% distance = ' 1 0 10 0';
% filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
% 
% StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
% pause(5);
% StepCtr.fire;
% pause(5);
% 
% % To zero position
% frequency_stop = 0;
% data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
% writeline(Obj_leader, data_packet);
% pause(2);
% 
% % Pitching
% data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
% writeline(Obj_leader, data_packet);
% pause(5);
% 
% % collective data
% DY = DY_inital + DYStep;
% for cycle_num = 1:1:3
%     LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
%     pause(COLLECT_TIME);
% end
% 
% % Stop pitching
% frequency_stop = 0;
% data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
% writeline(Obj_leader, data_packet);
% pause(2);

% --------- DX = movements(i, 1); DY = DY_inital + 40;------- %
DYStep = DYStep + 10;

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


% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(COLLECT_TIME);
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
pause(5);
StepCtr.fire;
pause(5);

% Pitching
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(5);

% collective data
DY = DY_inital + DYStep;
for cycle_num = 1:1:3
    LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, frequency, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
    pause(COLLECT_TIME);
end

% Stop pitching
frequency_stop = 0;
data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
writeline(Obj_leader, data_packet);
pause(2);

% --------- DX = movements(i, 1); DY = DY_inital + 60;------- %
% DYStep = DYStep + 10;
% 
% mode = ' distance';
% leader = true;
% follower = false;
% flag_return = false;
% distance = ' 1 0 -10 0';
% filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
% 
% StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
% pause(5);
% StepCtr.fire;
% pause(5);
% 
% % Pitching
% data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, Phase_lag);
% writeline(Obj_leader, data_packet);
% pause(5);
% 
% % collective data
% DY = DY_inital + DYStep;
% for cycle_num = 1:1:3
%     LiMing_read_6axis_data(Flow_Speed, SAMPLE_FREQUENCY, Nor_Amp, Phase_lag, COLLECT_TIME, DX, DY, cycle_num);
%     pause(COLLECT_TIME);
% end
% 
% % Stop pitching
% frequency_stop = 0;
% data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency_stop, amplitude, Phase_lag);
% writeline(Obj_leader, data_packet);
% pause(2);


disp('**********Finish one case, Return two foils at DX***********')

mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 2 0 20 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);

mode = ' distance';
leader = false;
follower = false;
flag_return = true;
distance = ' 2 0 -20 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);

disp('**********Two foils back to their initial DY***********')
end