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
addAnalogInputChannel(sp,'Dev1', 'ai3', 'Voltage');  %% follower input voltage

sp.DurationInSeconds = 10; % 1 second


%% base
frequency = 1; % frequency
amplitude = 25; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 0;
A_ratio = 0; 

for i =1:1:5

pause(30);

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];


write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\base_for_f_4_5_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

mean(tdata)

clear  tdata;


display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

display('*****************************************************************************');
display('base is finished');
display('*****************************************************************************');


%% f_8_A_005
frequency = 1; % frequency
amplitude = 25; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4.5;
A_ratio = 5; 

for i =1:1:5

pause(30);

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];


write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_5_A_005_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

mean(tdata)

clear  tdata;


display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

display('*****************************************************************************');
display('f_4_5_A_005 is finished');
display('*****************************************************************************');


%% f_4_5_A_010
frequency = 1; % frequency
amplitude = 25; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4.5;
A_ratio = 10; 

for i =1:1:5

pause(30);

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];


write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_5_A_010_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

mean(tdata)

clear  tdata;


display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

display('*****************************************************************************');
display('f_4_5_A_010 is finished');
display('*****************************************************************************');

%% f_4_5_A_015
frequency = 1; % frequency
amplitude = 25; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4.5;
A_ratio = 15; 

for i =1:1:5

pause(30);

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];


write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_5_A_015_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

mean(tdata)

clear  tdata;


display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

display('*****************************************************************************');
display('f_4_5_A_015 is finished');
display('*****************************************************************************');

%% f_4_5_A_020
frequency = 1; % frequency
amplitude = 25; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4.5;
A_ratio = 20; 

for i =1:1:5

pause(30);

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];


write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_5_A_020_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

mean(tdata)

clear  tdata;


display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

display('*****************************************************************************');
display('f_4_5_A_020 is finished');
display('*****************************************************************************');


%% f_4_5_A_025
frequency = 1; % frequency
amplitude = 25; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4.5;
A_ratio = 25; 

for i =1:1:5

pause(30);

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];


write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_5_A_025_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

mean(tdata)

clear  tdata;


display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

display('*****************************************************************************');
display('f_4_5_A_025 is finished');
display('*****************************************************************************');

%% f_4_5_A_030
frequency = 1; % frequency
amplitude = 25; % amplitude
phase = 0; % phase = 0.2*pi

f_ratio = 4.5;
A_ratio = 30; 

for i =1:1:5

pause(30);

follower_data = [10, int16(frequency*10), amplitude, phase, int16(f_ratio*10), A_ratio, 255];


write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Perturbation\f_4_5_A_030_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    
pause(5); 
    
stop = [10,0,0,0,0,0,255];

write(Obj_follower,stop,"uint8");

mean(tdata)

clear  tdata;


display('*****************************************************************************');
display(['Finished loop: ', num2str(i)]);
display('*****************************************************************************');
end

display('*****************************************************************************');
display('f_4_5_A_030 is finished');
display('*****************************************************************************');


%%
display('*****************************************************************************');
display('FINISHED!!!!!!!!!!');
display('*****************************************************************************');