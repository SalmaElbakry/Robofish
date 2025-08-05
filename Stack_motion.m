%% init
clear all
clc
%%
cd('D:\Liang Li\RobotRepeatRealFish\matlab\');

StepCtr.initEnv();

sp                   = daq.createSession('ni');
sp.Rate              = 5000;
%addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); % leader current
%addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');  % leader force

%addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current'); % follower current
%addAnalogInputChannel(sp,'Dev1', 'ai0', 'Voltage');  % follower force

addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');   %% leader force
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader input current
addAnalogInputChannel(sp,'Dev1', 'ai3', 'Voltage');  %% leader input voltage


sp.DurationInSeconds = 5; % 1 second

%% calebration_without_flow 
for i = 1:1:5
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\calebration_no_flow_', num2str(i),'.mat'), 'tdata');
	pause(20);
end

%% calebration_with_flow 
for i = 1:1:5
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\calebration_have_flow_', num2str(i),'.mat'), 'tdata');
	pause(20);
end

%% 0pi_4	

    i = 3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_0pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_0pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_0pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    


%% 1pi_4

    i = 3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_1pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_1pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_1pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    

	

%% 2pi_4

   for i = 1:1:3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_2pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_2pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_2pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    
    
   end

%%	3pi_4

    for i = 1:1:3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_3pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_3pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_3pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    
    
    end



%%	4pi_4

    for i = 1:1:3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_4pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_4pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_4pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    
    end
%%	5pi_4

   for i = 1:1:3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_5pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_5pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_5pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    
   end
%%	6pi_4

   for i = 1:1:3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_6pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_6pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_6pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    
   end
%%	7pi_4

   for i = 1:1:3
    tdata = [];
    pause(20);
    mode = ' RF+speed';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/stack motion/locomotion/without_leader/sin_wave/theta_2pi_4/StepMotorCtr_test_phi_7pi_4_theta_2pi_4.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    tdata = sp.startForeground;
    save(strcat('d:\stack motion\result\without_leader\theta_2pi_4\phi_7pi_4_theta_2pi_4_', num2str(i),'.mat'), 'tdata');
    
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Two fish: finished phi_7pi_4_theta_2pi_4: ', num2str(i)]);
    display('*****************************************************************************');
    
   end


	

 
   		