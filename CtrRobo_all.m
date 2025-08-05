%% init
clear all
clc
%%
cd('D:\Liang Li\RobotRepeatRealFish\matlab\');

StepCtr.initEnv();

% sp                   = daq.createSession('ni');
% addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); % leader
% addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current'); % follower
% addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');  % leader
% addAnalogInputChannel(sp,'Dev1', 'ai0', 'Voltage');  % follower
% sp.Rate              = 5000;
% sp.DurationInSeconds = 10; % 1 second

%%
% i = 6;
    %% Two fish: move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 1 0 0 10';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\two_fish_steady_water_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Two fish: finished moving from air into water in loop: ', num2str(i)]);
    display('*****************************************************************************'); 
    
    %% Two fish: RF+speed mode in water to repeat the locomotion

    mode = ' RF';%+speed
    leader = true;
    follower = true;
    flag_return = true;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
%tdata = sp.startForeground;
 %   save(strcat('D:\new_two_fish\2815\two_fish_swimming_water_test_', num2str(i),'.mat'), 'tdata');
%    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Two fish: finished repeating of the locomotion (water) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Two fish: RF+speed mode in water to go back to the orginal location
    
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = true;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished return to original location (water) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Two fish: move from water to air
 
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\two_fish_steady_air_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Two fish: finished move from water into air in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Two fish: RF+speed mode in air to repeat the locomotion
    % 
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\two_fish_swimming_air_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Two fish: finished repeating of the locomotion (air) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Two fish: RF+speed mode in water to go back to the orginal location

    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = true;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished return to original location (air) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %%
    display('*****************************************************************************');
    display('-----------Two fish test is finished-----------');
    display('*****************************************************************************');
 
  %% Leader fish motion: The follower must be moved to a "safe" place  
  
    mode = ' distance';
    leader = false;
    follower = true;
    flag_return = false;
    distance = ' 10 0 -100 0';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    clear mode leader follower flag_return distance filename tdata;
    
    display('*****************************************************************************');
    display(['Leader: finished moving the follower into a safe place in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Leader: move from air to water
    mode = ' distance';
    leader = true;
    follower = false;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\leader_steady_water_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Leader: finished moving from air into water in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Leader: RF+speed mode in water to repeat the locomotion

    mode = ' RF+speed';
    leader = true;
    follower = false;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\leader_swimming_water_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Leader: finished repeating of the locomotion (water) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Leader: RF+speed mode in water to go back to the orginal location
    
    mode = ' RF+speed';
    leader = true;
    follower = false;
    flag_return = true;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Leader: finished return to original location (water) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Leader: move from water to air
 
    mode = ' distance';
    leader = true;
    follower = false;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\leader_steady_air_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Leader: finished move from water into air in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Leader: RF+speed mode in air to repeat the locomotion
    % 
    mode = ' RF+speed';
    leader = true;
    follower = false;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\leader_swimming_air_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Leader: finished repeating of the locomotion (air) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Leader: RF+speed mode in water to go back to the orginal location

    mode = ' RF+speed';
    leader = true;
    follower = false;
    flag_return = true;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Leader: finished return to original location (air) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    
   %% Leader fish motion: Move back the follower from a "safe" place  
  
    mode = ' distance';
    leader = false;
    follower = true;
    flag_return = false;
    distance = ' 10 0 100 0';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    clear mode leader follower flag_return distance filename tdata;
    
    display('*****************************************************************************');
    display(['Leader: finished moving the follower from a safe place in loop: ', num2str(i)]);
    display('*****************************************************************************');
     
    
    %%
    display('*****************************************************************************');
    display('-----------Leader test is finished-----------');
    display('*****************************************************************************');
   
    
    %% Follower fish motion: The leader must be moved to a "safe" place  
  
    mode = ' distance';
    leader = true;
    follower = false;
    flag_return = false;
    distance = ' 10 0 100 0';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    clear mode leader follower flag_return distance filename tdata;
    
    display('*****************************************************************************');
    display(['Follower: finished moving the leader into a safe place in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
   %% Follower: move from air to water
    mode = ' distance';
    leader = false;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\follower_steady_water_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Follower: finished moving from air into water in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Follower: RF+speed mode in water to repeat the locomotion

    mode = ' RF+speed';
    leader = false;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\follower_swimming_water_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Follower: finished repeating of the locomotion (water) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Follower: RF+speed mode in water to go back to the orginal location
    
    mode = ' RF+speed';
    leader = false;
    follower = true;
    flag_return = true;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Follower: finished return to original location (water) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Follower: move from water to air
 
    mode = ' distance';
    leader = false;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\follower_steady_air_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Follower: finished move from water into air in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Follower: RF+speed mode in air to repeat the locomotion
    % 
    mode = ' RF+speed';
    leader = false;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    
    tdata = sp.startForeground;
    save(strcat('D:\new_two_fish\2815\follower_swimming_air_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Follower: finished repeating of the locomotion (air) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    %% Follower: RF+speed mode in water to go back to the orginal location

    mode = ' RF+speed';
    leader = false;
    follower = true;
    flag_return = true;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Follower: finished return to original location (air) in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    
     %% Follower fish motion: Move back the leader from a "safe" place  
  
    mode = ' distance';
    leader = true;
    follower = false;
    flag_return = false;
    distance = ' 10 0 -100 0';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    clear mode leader follower flag_return distance filename tdata;
    
    display('*****************************************************************************');
    display(['Follwer: finished moving the leader from a safe place in loop: ', num2str(i)]);
    display('*****************************************************************************');
     
    
    %%
    display('*****************************************************************************');
    display('-----------Follower test is finished-----------');
    display('*****************************************************************************');
    
    
        %%
    display('*****************************************************************************');
    display(['Finished loop: ', num2str(i)]);
    display('*****************************************************************************');
    
%end
