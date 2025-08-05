%%
clear all
%%  Ini
Com_follower = 'com5';
Com_leader   = 'com6';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader Obj_follower


Obj_follower = serialport(Com_follower,9600);


%% control frequency and amplitude 
frequency = 2; % frequency
amplitude = 20 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

 % phase = 0.2*pi % 0 - 20 = 0 - 2pi


%%

sp                   = daq.createSession('ni');
sp.Rate              = 5000;
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader power
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');  %% follower power
addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');   %% leader force
addAnalogInputChannel(sp,'Dev1', 'ai0', 'Voltage');  %% follower force

sp.DurationInSeconds = 10; % 1 second


%%

%% move robot up FROM air to water
cd('D:\Liang Li\RobotRepeatRealFish\matlab\');

StepCtr.initEnv();
mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);

  
    
    
    display('*****************************************************************************');
    display(['Two fish: move robot from water to air']);
    display('*****************************************************************************'); 
    
    display('*****************************************************************************');
    display(['Two fish: NOW, TEST 0 piao']);
    display('*****************************************************************************'); 

%% Calibration water steady
 for i = 1:1:5
    tstart = tic;
    tdata = sp.startForeground;
    telapsed = toc(tstart)
    
    save(['D:\Summer_school\result\0_piao_init_',num2str(i)], 'tdata');
   pause(20);
 end
 
 %%
 %%for phase = 0:2:10
 phase = 0
 for i = 1:1:5
     follower_data = [10, int16(frequency*10), amplitude, phase, 255];
     write(Obj_follower,follower_data,"uint8");
     tstart = tic;
     tdata = sp.startForeground;
     telapsed = toc(tstart)
     %          save(['D:\Summer_school\result\phase', num2str(phase),'_gap120mm','_flow70_',num2str(i)], 'tdata');
     save(['D:\Summer_school\result\?nit_flow150_',num2str(i)], 'tdata');
     pause(5);
     
     stop = [10,0,0,0,255];
     
     write(Obj_follower,stop,"uint8");
     
     pause(20);
 end
 %%end
 
 
   
    display('*****************************************************************************');
    display(['Two fish: finished phase test, NOW CHANGE FLOW SPEED']);
    display('*****************************************************************************'); 
 
%% move robot up FROM water to air
cd('D:\Liang Li\RobotRepeatRealFish\matlab\');

StepCtr.initEnv();
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
  
    display('*****************************************************************************');
    display(['Two fish: move robot from water to air']);
    display('*****************************************************************************'); 
    

    display('*****************************************************************************');
    display(['Two fish: finished phase and flow speded test, NOW CHANGE GAP']);
    display('*****************************************************************************'); 
    %%