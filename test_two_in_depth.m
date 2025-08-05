clear all
clc
%%
cd('D:\Liang Li\RobotRepeatRealFish\matlab\');

StepCtr.initEnv();

sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); % leader
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current'); % follower
addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');  % leader
addAnalogInputChannel(sp,'Dev1', 'ai0', 'Voltage');  % follower
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second

%%
%for i = 1:1:5
%% Two fish: RF+speed mode in water to repeat the locomotion

    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Summer_school/StepMotorCtr_test_not_move_phi_0.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('D:\Summer_school\result\two_fish_not_move_phi_0_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Two fish: finished not_move_phi_0 in loop: ', num2str(i)]);
    display('*****************************************************************************');
    
    
    %% Two fish: RF+speed mode in water to repeat the locomotion

    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Summer_school/StepMotorCtr_test_move_phi_0.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('D:\Summer_school\result\two_fish_move_phi_0_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Two fish: finished move_phi_0 in loop: ', num2str(i)]);
    display('*****************************************************************************');

%end
