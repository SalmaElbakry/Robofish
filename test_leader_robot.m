% Com = '/dev/tty.usbmodem1414201';

Com_leader   = 'com6';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader 

Obj_leader = serialport(Com_leader,9600);


 
frequency = 3 ; % frequency 
amplitude = 20 ; % amplitude
phase = 0; % phase = 0.2*pi
leader_data = [10, int16(frequency*10), amplitude, phase, 255];
% fwrite(Obj,int16(sendData));


%%%% setting for data acqusition 
sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');
addAnalogInputChannel(sp,'Dev2', 'ai1', 'Voltage');
addAnalogInputChannel(sp,'Dev2', 'ai0', 'Voltage');
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second 

data = [];

for phase = 0

    
    follower_data = [10, int16(frequency*10), amplitude, phase, 255];
    leader_data
    follower_data
    
%     fwrite(Obj_leader,int16(leader_data));
% %     pause(0.5*phase*0.1)
%     fwrite(Obj_follower,int16(sendData));
% %     fwrite(Obj_leader,int16(leader_data));
% %     fwrite(Obj_leader,int16(sendData));
% %     pause(2);

    write(Obj_leader,leader_data,"uint8");

    StepCtr.fire;
    
    ldata=[];
    fdata=[];
    for ii = 1:3
    data_read = readline(Obj_leader);
    ldata = [ldata,str2num(data_read)];
    end
    disp('leader data');ldata
%     pause(s.DurationInSeconds+0.5);
    pause(2);
    
    tstart = tic;
    tdata = sp.startForeground;
    telapsed = toc(tstart)   
    data = [data, tdata];

    
    
    stop = [10,0,0,0,255];
%     fwrite(Obj_follower,int16(stop));
%     fwrite(Obj_leader,int16(stop));
    write(Obj_leader,stop,"uint8");
    StepCtr.fire;
    
    ldata=[];
    fdata=[];
    for ii = 1:3
    data_read = readline(Obj_leader);
    ldata = [ldata,str2num(data_read)];
    end

    disp('leader data');ldata



    
    pause(10);
    
  

    
end
ans = mean(data);
save('C:\Users\liang\Desktop\two_fishs_phase_effect\050922\test00', 'data');


