clear all;

Com_leader   = 'com5';

%%
newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end


Obj_leader=serial(Com_leader,'baudrate',921600);
fopen(Obj_leader);
%pause(60);
%StepCtr.fire


frequency = 2; % frequency 
amplitude = 20; % amplitude
phase = 10; % phase = 0.2*pi
   
f_ratio = 4;
A_ratio = 0;
     

leader_data = [10, int16(frequency*10), amplitude, phase, 255];
fwrite(Obj_leader,int16(leader_data));

% leader_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
% fwrite(Obj_leader,int16(leader_data));

%   StepCtr.fire;

   
   %StepCtr.fire;
%%
% stop = [10,0,0,0,0,0,255];
% fwrite(Obj_leader,int16(stop));

stop = [10,0,0,0,255];
fwrite(Obj_leader,int16(stop));  
% StepCtr.fire;

%%


Com_follower   = 'com6';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end


Obj_follower=serial(Com_leader,'baudrate',9600);
fopen(Obj_follower);
pause(1);



frequency = 2; % frequency 
amplitude = 20; % amplitude
phase = 0; % phase = 0.2*pi
   
f_ratio = 4;
A_ratio = 0;
     

follower_data = [10, int16(frequency*10), amplitude, phase, f_ratio, A_ratio, 255];
fwrite(Obj_follower,int16(follower_data));

 %  StepCtr.fire;

   
   %StepCtr.fire;
%%
stop = [10,0,0,0,0,0,255];
fwrite(Obj_follower,int16(stop));  