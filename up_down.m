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
    %save(strcat('D:\new_two_fish\2815\two_fish_swimming_water_test_', num2str(i),'.mat'), 'tdata');
    pause(20);
    
    clear mode leader follower flag_return distance filename tdata;
    display('*****************************************************************************');
    display(['Two fish: finished repeating of the locomotion (water) in loop: ', num2str(i)]);
    display('*****************************************************************************');