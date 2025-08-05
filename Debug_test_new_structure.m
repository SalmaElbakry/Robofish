%%
clear all

Com_follower = 'com5';
Com_leader   = 'com6';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader Obj_follower


Obj_follower = serialport(Com_follower,9600);


% 
% 
% sp                   = daq.createSession('ni');
% addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader power
% %addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');  %% follower power
% addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');   %% leader force
% %addAnalogInputChannel(sp,'Dev1', 'ai0', 'Voltage');  %% follower force
% 
% 
% sp.Rate              = 5000;
% sp.DurationInSeconds = 10; % 1 second


%%
i= 5;

clear tdata;
pause(20);

tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Sin\fish_steady_air_before_test_', num2str(i),'.mat'), 'tdata');

telapsed = toc(tstart)
    
clear tdata;

frequency = 2 ; % frequency
amplitude = 25 ; % amplitude
phase = 0; % phase = 0.2*pi
leader_data = [10, int16(frequency*10), amplitude, phase, 255];

follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Sin\fish_swimming_air_before_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    

    
stop = [10,0,0,0,255];

write(Obj_follower,stop,"uint8");
%%

i= 5;

clear tdata;

pause(20);

tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Sin\fish_steady_water_test_', num2str(i),'.mat'), 'tdata');

telapsed = toc(tstart)
    
clear tdata;

frequency = 2 ; % frequency
amplitude = 25 ; % amplitude
phase = 0; % phase = 0.2*pi
leader_data = [10, int16(frequency*10), amplitude, phase, 255];

follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Sin\fish_swimming_water_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    

    
stop = [10,0,0,0,255];

write(Obj_follower,stop,"uint8");

%%
i= 5;

clear tdata;

pause(20);

tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Sin\fish_steady_air_after_test_', num2str(i),'.mat'), 'tdata');

clear tdata;

frequency = 2 ; % frequency
amplitude = 25 ; % amplitude
phase = 0; % phase = 0.2*pi
leader_data = [10, int16(frequency*10), amplitude, phase, 255];

follower_data = [10, int16(frequency*10), amplitude, 10, 255];

write(Obj_follower,follower_data,"uint8");
    
pause(5);
    
tstart = tic;
tdata = sp.startForeground;

save(strcat('D:\Sin\fish_swimming_air_after_test_', num2str(i),'.mat'), 'tdata');


telapsed = toc(tstart)
    

    
stop = [10,0,0,0,255];

write(Obj_follower,stop,"uint8");