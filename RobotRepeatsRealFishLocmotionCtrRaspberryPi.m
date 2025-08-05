% python3 ServoMotor.py -p '/dev/tty.usbmodem1421' -f 'DataForVideoMaker.csv' -l 'leader'

clc
clear
close all

addpath('sshfrommatlab_12_withPublicKeyAuth')
javaaddpath('sshfrommatlab_12_withPublicKeyAuth/ganymed-ssh2-build250.jar/ganymed-ssh2-build250.jar');



%%

% %%%% Position control %%%%%
% channel  =  sshfrommatlab('pi','192.168.101.150','raspberry','');
% 
% [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM1" -r "10 1 0 10 255"')
% 
% % [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM1" -f "~/Desktop/test.csv"')


%% control position

file = 'xyz.txt';

dx = 0.05; % positive forward
dy = 0.03; % positive right
dz = -0.1; % positive up
steps = 10;
% id = 'follower'; %'leader' or 'follower'
id = 'leader'; %'leader' or 'follower'
StepCtr.dxyzCtr(dx,dy,dz,id,steps);
StepCtr.update_xyz(file,dx,dy,dz,id);


dx = 0.1; % positive forward
dy = -0.05; % positive right
dz = -0.08; % positive up
steps = 10;
id = 'follower'; %'leader' or 'follower'
% id = 'leader'; %'leader' or 'follower'
StepCtr.dxyzCtr(dx,dy,dz,id,steps);
StepCtr.update_xyz(file,dx,dy,dz,id);


%% robot

%%% ssh initial
channel  =  sshfrommatlab('pi','192.168.101.102','raspberry','');
% channel  =  sshfrommatlab('pi','10.126.18.82','raspberry','');
% 
[a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/ServoMotor.py -p "/dev/ttyACM0" -f "~/Desktop/DataForVideoMaker.csv" -q "/dev/ttyACM1"')

%%

Com = 'com4';
% Com = '/dev/cu.usbmodem141211';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end

Obj=serial(Com,'baudrate',9600);
fopen(Obj);
pause(2);
% pause(60)  % 60 seconds

fwrite(Obj,int16(1));

pause(10);

fwrite(Obj,int16(0));
fclose(Obj);

%% final back to ori



steps = 10;
StepCtr.back2ori(file,steps)
