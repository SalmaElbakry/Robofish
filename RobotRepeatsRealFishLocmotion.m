clear
clc
close all


%Parameters
BodyLength = 0.15  ; % 15 cm
TailLength = 0.05  ; % 5 cm
% Com = 'com3';
% Com = '/dev/tty.usbmodem1421';
AngOffset = 110; % offset of the angle 

%end parameters


data = readtable('DataForVideoMaker.csv');

LeaderAmplitude = data.lA;
LeaderTheta     = asin(LeaderAmplitude*BodyLength/TailLength)*180/pi;

LeaderFrequency = data.lf;

FollowerAmplitude = data.fA;
FollowerTheta     = asin(FollowerAmplitude*BodyLength/TailLength)*180/pi;

FollowerFrequency = data.ff;


newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end

Obj=serial(Com,'baudrate',9600);
fopen(Obj);
pause(2);
% pause(60)  % 60 seconds

sendData = AngOffset+FollowerTheta;
fwrite(Obj,int16(sendData));



pause(1);
fclose(Obj);

