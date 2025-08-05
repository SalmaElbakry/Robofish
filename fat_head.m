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

%%

sp                   = daq.createSession('ni');
sp.Rate              = 5000;

addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');   %% leader force
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader input current
addAnalogInputChannel(sp,'Dev1', 'ai3', 'Voltage');  %% leader input voltage

sp.DurationInSeconds = 10; % 1 second

%% Calibration water steady
 for i = 1:1:5 
    tstart = tic;
    tdata = sp.startForeground;
    telapsed = toc(tstart)
    
   save(['D:\fat_hat\Calibration_',num2str(i)], 'tdata');
   pause(20);
 end
 
 %% control frequency and amplitude
frequency = 0.5; % frequency
amplitude = 10 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end     

frequency = 0.5; % frequency
amplitude = 15 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end     


frequency = 0.5; % frequency
amplitude = 20 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end     


frequency = 0.5; % frequency
amplitude = 25 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end     


frequency = 1; % frequency
amplitude = 10 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end   


frequency = 1; % frequency
amplitude = 15 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 1; % frequency
amplitude = 20 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 1; % frequency
amplitude = 25 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 1.5; % frequency
amplitude = 10 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 1.5; % frequency
amplitude = 15 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 1.5; % frequency
amplitude = 20 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 1.5; % frequency
amplitude = 25 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  



frequency = 2; % frequency
amplitude = 10 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  



frequency = 2; % frequency
amplitude = 15 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 2; % frequency
amplitude = 20 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end  


frequency = 2; % frequency
amplitude = 25 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end


frequency = 2.5; % frequency
amplitude = 10 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end


frequency = 2.5; % frequency
amplitude = 15 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end


frequency = 2.5; % frequency
amplitude = 20 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end


frequency = 2.5; % frequency
amplitude = 25 ; % amplitude
leader_data = [10, int16(frequency*10), amplitude, 0, 255];

for i = 1:1:3
follower_data = [10, int16(frequency*10), amplitude, 0, 255];
write(Obj_follower,follower_data,"uint8");

pause(2);

tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)
     
save(['D:\fat_hat\frequency_', num2str(frequency*10),'_amplitude_', num2str(amplitude), '_flowspeed_100_',num2str(i)], 'tdata');     
pause(1);
     
stop = [10,0,0,0,255];
     
write(Obj_follower,stop,"uint8");

pause(20);
end