Com = '/dev/tty.usbmodem14101';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
 
Obj=serial(Com,'baudrate',9600);
fopen(Obj);
pause(2);
% pause(60)  % 60 seconds
 
frequency = 1 ; % frequency 
amplitude = 30 ; % amplitude
phase = 1; % phase = 0.2*pi
sendData = [10, int16(frequency*10), amplitude, phase, 255];
fwrite(Obj,int16(sendData));

%%%% setting for data acqusition 
s                   = daq.createSession('ni');
addAnalogInputChannel(s,'cDAQ1Mod1', 1, 'Current');
s.Rate              = 5000;
s.DurationInSeconds = 1; % 1 second 
% data                = s.startForeground;

data = [];
for phase = 0:10
    
    sendData = [10, int16(frequency*10), amplitude, phase, 255];
    fwrite(Obj,int16(sendData));
    pause(1);
    
    data = [data, s.startForeground];
    
end



