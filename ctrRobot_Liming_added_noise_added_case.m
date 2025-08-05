clear all;

% addpath('sshfrommatlab_12_withPublicKeyAuth')
% javaaddpath('sshfrommatlab_12_withPublicKeyAuth/ganymed-ssh2-build250.jar/ganymed-ssh2-build250.jar');

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

% sp                   = daq.createSession('ni');
% addAnalogInputChannel(sp,'Dev2', 'ai1', 'Voltage');
% addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');
% sp.Rate              = 5000;
% sp.DurationInSeconds = 10; % 1 second
%     
% channel  =  sshfrommatlab('pi','192.168.101.150','raspberry','');

%%
% data = [];
% data_water_static = [];
% data_air = [];
% % %%%% setting for power cost
% 
% 
% frequency = 2; % frequency 
% amplitude = 20; % amplitude
% phase = 0; % phase = 0.2*pi
%    
% f_ratio = 4;
% A_ratio = 32;
%      
% %% 
% for i = 1:1:5
% 
%    data_static_before_move = sp.startForeground;
%     
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
% 
%  %  StepCtr.fire;
% 
%    data_water_move = sp.startForeground;
%    data = [data data_water_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%    %StepCtr.fire;
%    
%    pause(10);
%    
%    data_static_after_move = sp.startForeground;
%    data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
%    
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
%    
%    pause(40);
%    
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
%    
%   % StepCtr.fire;
%    
%    data_air_move = sp.startForeground;
%    data_air = [data_air data_air_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%  %  StepCtr.fire;
% % 
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
%    
%    pause(40);
%    i
% end
% %%
% save('D:\Li-Ming\23092022\added_noise\data_base_f_4_A032.mat','data');
% save('D:\Li-Ming\23092022\added_noise\data_water_static_data_base_f_4_A032.mat','data_water_static');
% save('D:\Li-Ming\23092022\added_noise\data_air_data_base_f_4_A032.mat','data_air');
% 
% mean_water_move_f_4_A032 = [mean(data(:,1)) mean(data(:,2)); mean(data(:,3)) mean(data(:,4)); mean(data(:,5)) mean(data(:,6)); mean(data(:,7)) mean(data(:,8)); mean(data(:,9)) mean(data(:,10))];
% mean_water_static_f_4_A032 = [mean(data_water_static(:,1)) mean(data_water_static(:,2)); mean(data_water_static(:,3)) mean(data_water_static(:,4)); mean(data_water_static(:,5)) mean(data_water_static(:,6)); mean(data_water_static(:,7)) mean(data_water_static(:,8)); mean(data_water_static(:,9)) mean(data_water_static(:,10))];
% mean_air_f_4_A032 = [mean(data_air(:,1)) mean(data_air(:,2)); mean(data_air(:,3)) mean(data_air(:,4)); mean(data_air(:,5)) mean(data_air(:,6)); mean(data_air(:,7)) mean(data_air(:,8)); mean(data_air(:,9)) mean(data_air(:,10))];
% 
% 
% %%
% data = [];
% data_water_static = [];
% data_air = [];
% % %%%% setting for power cost
% 
% 
% frequency = 2; % frequency 
% amplitude = 20; % amplitude
% phase = 0; % phase = 0.2*pi
%    
% f_ratio = 5;
% A_ratio = 8;
%      
% %% 
% for i = 1:1:5
% 
%    data_static_before_move = sp.startForeground;
%     
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
% 
%  %  StepCtr.fire;
% 
%    data_water_move = sp.startForeground;
%    data = [data data_water_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%    %StepCtr.fire;
%    
%    pause(10);
%    
%    data_static_after_move = sp.startForeground;
%    data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
%    
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
%    
%    pause(40);
%    
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
%    
%   % StepCtr.fire;
%    
%    data_air_move = sp.startForeground;
%    data_air = [data_air data_air_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%  %  StepCtr.fire;
% % 
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
%    
%    pause(40);
%    i
% end
% %%
% save('D:\Li-Ming\23092022\added_noise\data_base_f_5_A008.mat','data');
% save('D:\Li-Ming\23092022\added_noise\data_water_static_data_base_f_5_A008.mat','data_water_static');
% save('D:\Li-Ming\23092022\added_noise\data_air_data_base_f_5_A008.mat','data_air');
% 
% mean_water_move_f_5_A008 = [mean(data(:,1)) mean(data(:,2)); mean(data(:,3)) mean(data(:,4)); mean(data(:,5)) mean(data(:,6)); mean(data(:,7)) mean(data(:,8)); mean(data(:,9)) mean(data(:,10))];
% mean_water_static_f_5_A008 = [mean(data_water_static(:,1)) mean(data_water_static(:,2)); mean(data_water_static(:,3)) mean(data_water_static(:,4)); mean(data_water_static(:,5)) mean(data_water_static(:,6)); mean(data_water_static(:,7)) mean(data_water_static(:,8)); mean(data_water_static(:,9)) mean(data_water_static(:,10))];
% mean_air_f_5_A008 = [mean(data_air(:,1)) mean(data_air(:,2)); mean(data_air(:,3)) mean(data_air(:,4)); mean(data_air(:,5)) mean(data_air(:,6)); mean(data_air(:,7)) mean(data_air(:,8)); mean(data_air(:,9)) mean(data_air(:,10))];
% 
% %%
% data = [];
% data_water_static = [];
% data_air = [];
% % %%%% setting for power cost
% 
% 
% frequency = 2; % frequency 
% amplitude = 20; % amplitude
% phase = 0; % phase = 0.2*pi
%    
% f_ratio = 5;
% A_ratio = 16;
%      
% %% 
% for i = 1:1:5
% 
%    data_static_before_move = sp.startForeground;
%     
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
% 
%  %  StepCtr.fire;
% 
%    data_water_move = sp.startForeground;
%    data = [data data_water_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%    %StepCtr.fire;
%    
%    pause(10);
%    
%    data_static_after_move = sp.startForeground;
%    data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
%    
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
%    
%    pause(40);
%    
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
%    
%   % StepCtr.fire;
%    
%    data_air_move = sp.startForeground;
%    data_air = [data_air data_air_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%  %  StepCtr.fire;
% % 
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
%    
%    pause(40);
%    i
% end
% %%
% save('D:\Li-Ming\23092022\added_noise\data_base_f_5_A016.mat','data');
% save('D:\Li-Ming\23092022\added_noise\data_water_static_data_base_f_5_A016.mat','data_water_static');
% save('D:\Li-Ming\23092022\added_noise\data_air_data_base_f_5_A016.mat','data_air');
% 
% mean_water_move_f_5_A016 = [mean(data(:,1)) mean(data(:,2)); mean(data(:,3)) mean(data(:,4)); mean(data(:,5)) mean(data(:,6)); mean(data(:,7)) mean(data(:,8)); mean(data(:,9)) mean(data(:,10))];
% mean_water_static_f_5_A016 = [mean(data_water_static(:,1)) mean(data_water_static(:,2)); mean(data_water_static(:,3)) mean(data_water_static(:,4)); mean(data_water_static(:,5)) mean(data_water_static(:,6)); mean(data_water_static(:,7)) mean(data_water_static(:,8)); mean(data_water_static(:,9)) mean(data_water_static(:,10))];
% mean_air_f_5_A016 = [mean(data_air(:,1)) mean(data_air(:,2)); mean(data_air(:,3)) mean(data_air(:,4)); mean(data_air(:,5)) mean(data_air(:,6)); mean(data_air(:,7)) mean(data_air(:,8)); mean(data_air(:,9)) mean(data_air(:,10))];

%%                        
% data = [];
% data_water_static = [];
% data_air = [];
% % %%%% setting for power cost
% 
% 
% frequency = 2; % frequency 
% amplitude = 20; % amplitude
% phase = 0; % phase = 0.2*pi
%    
% f_ratio = 5;
% A_ratio = 24;
%      
% %% 
% for i = 1:1:5
% 
%    data_static_before_move = sp.startForeground;
%     
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
% 
%  %  StepCtr.fire;
% 
%    data_water_move = sp.startForeground;
%    data = [data data_water_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%    %StepCtr.fire;
%    
%    pause(10);
%    
%    data_static_after_move = sp.startForeground;
%    data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
%    
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
%    
%    pause(40);
%    
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
%    
%   % StepCtr.fire;
%    
%    data_air_move = sp.startForeground;
%    data_air = [data_air data_air_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%  %  StepCtr.fire;
% % 
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
%    
%    pause(40);
%    i
% end
% %%
% save('D:\Li-Ming\23092022\added_noise\data_base_f_5_A024.mat','data');
% save('D:\Li-Ming\23092022\added_noise\data_water_static_data_base_f_5_A024.mat','data_water_static');
% save('D:\Li-Ming\23092022\added_noise\data_air_data_base_f_5_A024.mat','data_air');
% 
% mean_water_move_f_5_A024 = [mean(data(:,1)) mean(data(:,2)); mean(data(:,3)) mean(data(:,4)); mean(data(:,5)) mean(data(:,6)); mean(data(:,7)) mean(data(:,8)); mean(data(:,9)) mean(data(:,10))];
% mean_water_static_f_5_A024 = [mean(data_water_static(:,1)) mean(data_water_static(:,2)); mean(data_water_static(:,3)) mean(data_water_static(:,4)); mean(data_water_static(:,5)) mean(data_water_static(:,6)); mean(data_water_static(:,7)) mean(data_water_static(:,8)); mean(data_water_static(:,9)) mean(data_water_static(:,10))];
% mean_air_f_5_A024 = [mean(data_air(:,1)) mean(data_air(:,2)); mean(data_air(:,3)) mean(data_air(:,4)); mean(data_air(:,5)) mean(data_air(:,6)); mean(data_air(:,7)) mean(data_air(:,8)); mean(data_air(:,9)) mean(data_air(:,10))];

                                 
%%                        
% data = [];
% data_water_static = [];
% data_air = [];
% % %%%% setting for power cost
% 
% 
% frequency = 2; % frequency 
% amplitude = 20; % amplitude
% phase = 0; % phase = 0.2*pi
%    
% f_ratio = 5;
% A_ratio = 32;
%      
% %% 
% for i = 1:1:5
% 
%    data_static_before_move = sp.startForeground;
%     
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
% 
%  %  StepCtr.fire;
% 
%    data_water_move = sp.startForeground;
%    data = [data data_water_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%    %StepCtr.fire;
%    
%    pause(10);
%    
%    data_static_after_move = sp.startForeground;
%    data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
%    
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
%    
%    pause(40);
%    
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
%    
%   % StepCtr.fire;
%    
%    data_air_move = sp.startForeground;
%    data_air = [data_air data_air_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%  %  StepCtr.fire;
% % 
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
%    
%    pause(40);
%    i
% end
% %%
% save('D:\Li-Ming\23092022\added_noise\data_base_f_5_A032.mat','data');
% save('D:\Li-Ming\23092022\added_noise\data_water_static_data_base_f_5_A032.mat','data_water_static');
% save('D:\Li-Ming\23092022\added_noise\data_air_data_base_f_5_A032.mat','data_air');
% 
% mean_water_move_f_5_A032 = [mean(data(:,1)) mean(data(:,2)); mean(data(:,3)) mean(data(:,4)); mean(data(:,5)) mean(data(:,6)); mean(data(:,7)) mean(data(:,8)); mean(data(:,9)) mean(data(:,10))];
% mean_water_static_f_5_A032 = [mean(data_water_static(:,1)) mean(data_water_static(:,2)); mean(data_water_static(:,3)) mean(data_water_static(:,4)); mean(data_water_static(:,5)) mean(data_water_static(:,6)); mean(data_water_static(:,7)) mean(data_water_static(:,8)); mean(data_water_static(:,9)) mean(data_water_static(:,10))];
% mean_air_f_5_A032 = [mean(data_air(:,1)) mean(data_air(:,2)); mean(data_air(:,3)) mean(data_air(:,4)); mean(data_air(:,5)) mean(data_air(:,6)); mean(data_air(:,7)) mean(data_air(:,8)); mean(data_air(:,9)) mean(data_air(:,10))];

%%                        
% data = [];
% data_water_static = [];
% data_air = [];
% % %%%% setting for power cost
% 
% 
% frequency = 2; % frequency 
% amplitude = 20; % amplitude
% phase = 0; % phase = 0.2*pi
%    
% f_ratio = 6;
% A_ratio = 32;
%      
% %% 
% for i = 1:1:5
% 
%    data_static_before_move = sp.startForeground;
%     
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
% 
%  %  StepCtr.fire;
% 
%    data_water_move = sp.startForeground;
%    data = [data data_water_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%    %StepCtr.fire;
%    
%    pause(10);
%    
%    data_static_after_move = sp.startForeground;
%    data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
%    
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
%    
%    pause(40);
%    
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
%    
%   % StepCtr.fire;
%    
%    data_air_move = sp.startForeground;
%    data_air = [data_air data_air_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%  %  StepCtr.fire;
% % 
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
%    
%    pause(40);
%    i
% end
% %%
% save('D:\Li-Ming\23092022\added_noise\data_base_f_6_A032.mat','data');
% save('D:\Li-Ming\23092022\added_noise\data_water_static_data_base_f_6_A032.mat','data_water_static');
% save('D:\Li-Ming\23092022\added_noise\data_air_data_base_f_6_A032.mat','data_air');
% 
% mean_water_move_f_6_A032 = [mean(data(:,1)) mean(data(:,2)); mean(data(:,3)) mean(data(:,4)); mean(data(:,5)) mean(data(:,6)); mean(data(:,7)) mean(data(:,8)); mean(data(:,9)) mean(data(:,10))];
% mean_water_static_f_6_A032 = [mean(data_water_static(:,1)) mean(data_water_static(:,2)); mean(data_water_static(:,3)) mean(data_water_static(:,4)); mean(data_water_static(:,5)) mean(data_water_static(:,6)); mean(data_water_static(:,7)) mean(data_water_static(:,8)); mean(data_water_static(:,9)) mean(data_water_static(:,10))];
% mean_air_f_6_A032 = [mean(data_air(:,1)) mean(data_air(:,2)); mean(data_air(:,3)) mean(data_air(:,4)); mean(data_air(:,5)) mean(data_air(:,6)); mean(data_air(:,7)) mean(data_air(:,8)); mean(data_air(:,9)) mean(data_air(:,10))];
%    
% %%                        
data = [];
data_water_static = [];
data_air = [];
% % % % %%%% setting for power cost
% % % 
% % % 
frequency = 2; % frequency 
amplitude = 20; % amplitude
phase = 0; % phase = 0.2*pi
% % %    
f_ratio = 0;
A_ratio = 0;
% % %      
%6/24-0/0-4/32
%% 
% for i = 1:1:5

%    data_static_before_move = sp.startForeground;
    
   leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
   fwrite(Obj_leader,int16(leader_data));

 %  StepCtr.fire;
   
 %  data_water_move = sp.startForeground;
 %  data = [data data_water_move];
   
 %  stop = [10,0,0,0,0,0,255];
  %  fwrite(Obj_leader,int16(stop));
%    
%    %StepCtr.fire;
%    
%    pause(10);
%    
%    data_static_after_move = sp.startForeground;
%    data_water_static = [data_water_static (data_static_before_move + data_static_after_move)./2];
%    
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "120" -l "leader" -t "20"');
%    
%    pause(40);
%    
%    leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
%    fwrite(Obj_leader,int16(leader_data));
%    
%   % StepCtr.fire;
%    
%    data_air_move = sp.startForeground;
%    data_air = [data_air data_air_move];
%    
%    stop = [10,0,0,0,0,0,255];
%    fwrite(Obj_leader,int16(stop));
%    
%  %  StepCtr.fire;
% % 
%    [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/new_step_ctr.py -m "distance" -z "-120" -l "leader" -t "20"');
%    
%    pause(40);
%    i
% end
%%
% save('D:\Li-Ming\23092022\added_noise\data_base_f_8_A032.mat','data');
% save('D:\Li-Ming\23092022\added_noise\data_water_static_data_base_f_8_A032.mat','data_water_static');
% save('D:\Li-Ming\23092022\added_noise\data_air_data_base_f_8_A032.mat','data_air');
% 
% mean_water_move_f_8_A032 = [mean(data(:,1)) mean(data(:,2)); mean(data(:,3)) mean(data(:,4)); mean(data(:,5)) mean(data(:,6)); mean(data(:,7)) mean(data(:,8)); mean(data(:,9)) mean(data(:,10))];
% mean_water_static_f_8_A032 = [mean(data_water_static(:,1)) mean(data_water_static(:,2)); mean(data_water_static(:,3)) mean(data_water_static(:,4)); mean(data_water_static(:,5)) mean(data_water_static(:,6)); mean(data_water_static(:,7)) mean(data_water_static(:,8)); mean(data_water_static(:,9)) mean(data_water_static(:,10))];
% mean_air_f_8_A032 = [mean(data_air(:,1)) mean(data_air(:,2)); mean(data_air(:,3)) mean(data_air(:,4)); mean(data_air(:,5)) mean(data_air(:,6)); mean(data_air(:,7)) mean(data_air(:,8)); mean(data_air(:,9)) mean(data_air(:,10))];
% 
