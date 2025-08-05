%%
clear all

Com_follower   = 'com5';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_follower


Obj_follower = serialport(Com_follower,9600);

cd('D:\Liang Li\RobotRepeatRealFish\matlab\');

StepCtr.initEnv();

sp                   = daq.createSession('ni');
sp.Rate              = 5000;
%addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader power
addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');  %% follower force
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');  %% follower input  current
addAnalogInputChannel(sp,'Dev1', 'ai2', 'Voltage');  %% follower input voltage

sp.DurationInSeconds = 10; % 1 second

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 2; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_002_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_002 is finished');
display('*****************************************************************************');


%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 4; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_004_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_004 is finished');
display('*****************************************************************************');


%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 5; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_005_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_005 is finished');
display('*****************************************************************************');

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 6; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_006_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_006 is finished');
display('*****************************************************************************');

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 8; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_008_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_008 is finished');
display('*****************************************************************************');

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 10; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_010_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_010 is finished');
display('*****************************************************************************');

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 15; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_015_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_015 is finished');
display('*****************************************************************************');

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 20; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_020_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_020 is finished');
display('*****************************************************************************');

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 25; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_025_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_025 is finished');
display('*****************************************************************************');

%%
frequency = 1; % frequency
amplitude = 15; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4;
A_ratio = 30; 


%% Test in air:before
for i =1:1:5

pause(5);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');

%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\water_without_flow3.mat'), 'tdata');

%telapsed = toc(tstart)

%pause(5);    

    
%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
display('*****************************************************************************');
display(['Air before is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from air to water
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from air to water: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%%   Test in water 
pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_002_steady_water_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_A_030_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

clear  tdata;
display('*****************************************************************************');
display(['Test in water is finished in loop: ', num2str(i)]);
display('*****************************************************************************'); 

%% Move from water to air
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 12 0 0 -120';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(20);
    
    clear mode leader follower flag_return distance filename;
    display('*****************************************************************************');
    display(['Foil move from water to air: ', num2str(i)]);
    display('*****************************************************************************'); 
    
%% Test in air:after
%pause(20);

%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

%telapsed = toc(tstart)
    
%clear tdata;

%leader_data = [10, int16(frequency*10), amplitude, phase, 255];
%follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%follower_data = [10, int16(frequency*10), amplitude, 10, 255];

%write(Obj_follower,follower_data,"uint8");
    
%pause(5);
    
%tstart = tic;
%tdata = sp.startForeground;

%save(strcat('D:\Perturbation\f_4_A_005_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


%telapsed = toc(tstart)
    
%pause(5); 

%stop = [10,0,0,0,0,0,255];

%write(Obj_follower,stop,"uint8");

%clear  tdata;
%display('*****************************************************************************');
%display(['Air after is finished in loop: ', num2str(i)]);
%display('*****************************************************************************'); 

%%
display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

%%
display('*****************************************************************************');
display('f_4_A_030 is finished');
display('*****************************************************************************');


%%
display('*****************************************************************************');
display('FINISHED!!!!!!!!!!');
display('*****************************************************************************');