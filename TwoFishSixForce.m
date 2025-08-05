
clear all
clc
%%
% cd('D:\Liang Li\RobotRepeatRealFish\matlab\');
StepCtr.initEnv();

%%
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

%% Save the force/torque data for calibration

frequency =0;
amplitude = 20;
phase_difference = 180;

data_packet = sprintf("10 %.2f %.2f %.2f 255\n", frequency, amplitude, phase_difference);
writeline(Obj_leader, data_packet);

%%
mode = ' distance';
leader = true;
follower = false;
flag_return = false;
distance = ' 1 0 0 5';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to water***********')

%%
DX = 0.0;
DY = 0.0;
for cycle_num = 1:1:5
    read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
end
disp('**********Calibration completed.***********')
%% Move fish from air to water
mode = ' distance';
leader = true;
follower = true;
flag_return = false;
distance = ' 10 0 0 -100';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(5);
disp('**********Move to water***********')



%%
movements = [
    25 0;
    25 2;
    25 4;
    25 6;
    25 8;
    25 10;
    25 12;
    % Add more movements as required
];

 for i = 1:size(movements, 1)
     DX = movements(i, 1);
     DY = movements(i, 2);
%      
     if abs(DY) == 0
         disp('**** DY is 8 ******')
     elseif (abs(DY)) < 8.5 && (abs(DY) > 0.5)
         mode = ' distance';
         leader = false;
         follower = true;
         flag_return = false;
         distance = ' 2 0 20 0';
         filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
         
         StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
         pause(5);
         StepCtr.fire;
         pause(5);
      else
         mode = ' distance';
         leader = true;
         follower = false;
         flag_return = false;
         distance = ' 2 0 -20 0';
         filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
         
         StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
         pause(5);
         StepCtr.fire;
         pause(5);
         
     end
         
         leader_data = [10, int16(frequency*10), amplitude, phase_lag, 255];
         write(Obj_leader,leader_data,"uint8");
         
         pause(10);

         for cycle_num = 1:1:5
             read_6axis_data(SAMPLE_FREQUENCY,COLLECT_TIME,DX,DY,cycle_num);
             pause(COLLECT_TIME);
         end
         
         stop = [10,0,0,0,255];
         write(Obj_leader,stop,"uint8");
         
         disp('**********Finish one case, Move to new position***********')
         
 

 end      
       

     mode = ' distance';
     leader = false;
     follower = true;
     flag_return = false;
     distance = ' 8 0 -80 0';
     filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
     
     StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
     pause(5);
     StepCtr.fire;
     pause(5);
     
     mode = ' distance';
     leader = true;
     follower = false;
     flag_return = false;
     distance = ' 4 0 40 0';
     filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
     
     StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
     pause(5);
     StepCtr.fire;
     pause(5);
     disp(['********** Move back to 8 ***********'])
     
%      mode = ' distance';
%      leader = false;
%      follower = true;
%      flag_return = false;
%      distance = ' 5 -50 0 0';
%      filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
%      
%      StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
%      pause(5);
%      StepCtr.fire;
%      pause(5);
     
     disp(['****** follower move to new DX ****'])
     disp(['****** Change the Matrix ****'])


