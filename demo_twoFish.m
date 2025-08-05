%%
clear all
clc
%%
% cd('D:\Liang Li\RobotRepeatRealFish\matlab\');
StepCtr.initEnv();
%%
Com_follower = 'com5';
Com_leader   = 'com6';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader Obj_follower


Obj_follower = serialport(Com_follower,9600);
%%
mode = ' distance';
leader = true;
follower = true;
flag_return = false;
distance = ' 6 0 0 -60';%distance = ' 8 -80 0 0';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';

StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;

%%
frequency = 1 ; % frequency
amplitude = 20 ; % amplitude

%% leader_data = [10, int16(frequency*10), amplitude, 0, 255];
%  
%  follower_data = [10, int16(frequency*10), amplitude, 0, 255];
% 
%  
%  write(Obj_follower,leader_data,"uint8");


% phase = 0; % phase = 0.2*pi
for phase = 0:2:20 
   
leader_data = [10, int16(frequency*10), amplitude, phase, 255];

follower_data = [10, int16(frequency*10), amplitude, 0, 255];

write(Obj_follower,leader_data,"uint8");
   
pause(8);

   if phase == 20
    stop = [10,0,0,0,255];

    write(Obj_follower,stop,"uint8");
   end
end
%     
%%
stop = [10,0,0,0,255];

write(Obj_follower,stop,"uint8");
