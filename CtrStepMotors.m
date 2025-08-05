% python3 ServoMotor.py -p '/dev/tty.usbmodem1421' -f 'DataForVideoMaker.csv' -l 'leader'

%%% To do, set the max distance each command 1.5 = 0.5 x 3

clc
clear
close all

addpath('sshfrommatlab_12_withPublicKeyAuth')
javaaddpath('sshfrommatlab_12_withPublicKeyAuth/ganymed-ssh2-build250.jar/ganymed-ssh2-build250.jar');


%% Run demo
if 1
StepCtr.rundemo;



[Obj_leader,Obj_follower] = StepCtr.controlrobot;
StepCtr.fire;

pause(20)

Com_follower = 'com5';
Com_leader   = 'com6';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end

Obj_leader=serial(Com_leader,'baudrate',9600);
fopen(Obj_leader);
pause(1);

Obj_follower=serial(Com_follower,'baudrate',9600);
fopen(Obj_follower);
pause(1);

stop = [10,0,0,0,255];
fwrite(Obj_follower,int16(stop));
fwrite(Obj_leader,int16(stop));

end

if 0
%% Current Position

file = 'xyz.txt';
% StepCtr.back2ori(file,steps)

%% control position

dx = 5; % positive forward
dy = 5; % positive right
% dz = 40; % positive up  (center meter)
% steps = 80;   % a bug when it is 100
dz = -5; % positive up  (this is speed)
steps = 20;   % a this is time, 100 ten seconds around

for ii =1:5
    ii

id = 'leader'; %'leader' or 'follower'

id = 'leader'; %'leader' or 'follower'
StepCtr.dxyzCtr(dx,dy,dz,id,steps);

id = 'follower'; %'leader' or 'follower'
StepCtr.dxyzCtr(dx,dy,dz,id,steps);

StepCtr.fire;
pause(10);

dx = -dx;
dy = -dy;
dz = -dz;

end

%% update position
StepCtr.update_xyz(file,dx,dy,dz,id);


end





%% follower 
% x = 1.5, y = -0.3, z= -0.9
%% leader
% x = 0, y = 0, z = -0.9