clear all;

addpath('sshfrommatlab_12_withPublicKeyAuth')
javaaddpath('sshfrommatlab_12_withPublicKeyAuth/ganymed-ssh2-build250.jar/ganymed-ssh2-build250.jar');

Com_leader   = 'com5';

%%
newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end

%%
Obj_leader=serial(Com_leader,'baudrate',9600);
fopen(Obj_leader);
pause(1);

%%%%%%%%%%%%%Get Voltage and Current data%%%%%%%%%

%%

sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'Dev2', 'ai1', 'Voltage');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second
    
channel  =  sshfrommatlab('pi','192.168.101.150','raspberry','');

%%
data = [];
data_water_static = [];
data_air = [];
% %%%% setting for power cost


frequency = 1; % frequency 
amplitude = 20; % amplitude
phase = 0; % phase = 0.2*pi
   
f_ratio = 4;
A_ratio = 0;
     
%% 
for i = 1:1:5
    
   f_ratio
   A_ratio
   i
   
   data_static_before_move = sp.startForeground;
    
   leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
   fwrite(Obj_leader,int16(leader_data));

 %  StepCtr.fire;

   data_water_move = sp.startForeground;
   data = [data data_water_move];
   
   stop = [10,0,0,0,0,0,255];
   fwrite(Obj_leader,int16(stop));
   
   %StepCtr.fire;
   
   pause(10);
   
   data_static_after_move = sp.startForeground;
   data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
   
   [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
   
   pause(40);
   
   leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
   fwrite(Obj_leader,int16(leader_data));
   
  % StepCtr.fire;
   
   data_air_move = sp.startForeground;
   data_air = [data_air data_air_move];
   
   stop = [10,0,0,0,0,0,255];
   fwrite(Obj_leader,int16(stop));
   
 %  StepCtr.fire;
% 
   [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
   
   pause(40);

end
%%
save('D:\Li-Ming\25092022\f_4_A_000_data.mat','data');
save('D:\Li-Ming\25092022\f_4_A_000_data_water_static.mat','data_water_static');
save('D:\Li-Ming\25092022\f_4_A_000_data_air.mat','data_air');
