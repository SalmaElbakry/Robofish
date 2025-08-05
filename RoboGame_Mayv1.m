
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


%% Define frequency and amplitude
frequency = 2 ; % frequency
amplitude = 23 ; % amplitude
phase = 10; % phase = 0.2*pi
leader_data = [10, int16(frequency*10), amplitude, phase, 255];


%%
sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader power
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');  %% follower power
addAnalogInputChannel(sp,'Dev2', 'ai1', 'Voltage');   %% leader force
addAnalogInputChannel(sp,'Dev2', 'ai0', 'Voltage');  %% follower force
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second

save_data_in_air=[];
save_data_in_water=[];

%%
T=100;
offset = 0;

strs = [0,5,10,15] + offset;

Mean_colum_2_4 = 5.2463;
Mean_colum_1_3 = 4.6134;

delta =0.010;
noi = 0.00;

str1=randi(4);
str2=randi(4);
str_act2 = str2 - str1;
if str_act2 < 0
    str_act2 = str_act2 + 4;
end

%% Get data when robot in air
follower_data = [10, int16(frequency*10), amplitude, strs(str_act2 + 1), 255];

write(Obj_follower,follower_data,"uint8");
    
pause(10);
    
tstart = tic;
ndata = sp.startForeground;
telapsed = toc(tstart)

data_air = mean(ndata);
%save_data_in_air = [save_data_in_air, ndata];

stop = [10,0,0,0,255];
write(Obj_follower,stop,"uint8"); 


%% Move robot from air to water
StepCtr.initEnv();
mode = ' distance';
leader = true;
follower = true;
flag_return = false;
distance = ' 13 0 0 130';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171220_145703_12744_13033.csv';
%     
StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(30);


%% Get data when robot in water
follower_data = [10, int16(frequency*10), amplitude, strs(str_act2 + 1), 255];
leader_data
follower_data

write(Obj_follower,follower_data,"uint8");

pause(10);
        
tstart = tic;
tdata = sp.startForeground;
telapsed = toc(tstart)

data_water = mean(tdata);
%save_data_in_water = [save_data_in_water, tdata];

stop = [10,0,0,0,255];
write(Obj_follower,stop,"uint8");

pi1 = (mean(data_water(:,4))-mean(data_air(:,4)))./(mean((data_water(:,2))-mean(data_air(:,2))))- Mean_colum_2_4;
pi2 = (mean(data_water(:,3))-mean(data_air(:,3)))./(mean((data_water(:,1))-mean(data_air(:,1))))- Mean_colum_1_3;


%% Move robot from water to air
StepCtr.initEnv();
mode = ' distance';
leader = true;
follower = true;
flag_return = false;
distance = ' 13 0 0 -130';
filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171220_145703_12744_13033.csv';
%     
StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
pause(5);
StepCtr.fire;
pause(30);


%% Main loop
for t=1:T    
    % if pi1<mean([pi1,pi2])-delta
    %    if pi1<(pi2-delta)
    if pi1<-delta
        
        a1=randi(4);
        while a1==str1
            a1=randi(4);
        end
        str1=a1;
    elseif rand(1)<noi
        a1=randi(4);
        while a1==str1
            a1=randi(4);
        end
        str1=a1;
    end
    
    %  if pi2<mean([pi1,pi2])-delta
    %     if pi2<(pi1-delta)
    if pi2<-delta
        
        a1=randi(4);
        while a1==str2
            a1=randi(4);
        end
        str2=a1;
    elseif rand(1)<noi
        
        a1=randi(4);
        while a1==str2
            a1=randi(4);
        end
        str2=a1;
        
    end
    
    
    str_act1 = str1 - str1;
    str_act2 = str2 - str1;
    if str_act2 < 0
        str_act2 = str_act2 + 4;
    end
    
%% Get data when robot in air
    follower_data = [10, int16(frequency*10), amplitude, strs(str_act2 + 1), 255];
    leader_data
    follower_data

    write(Obj_follower,follower_data,"uint8");
    
    pause(10);

    ndata = sp.startForeground;
    data_air = mean(ndata);
    save_data_in_air = [save_data_in_air, ndata];
    
    stop = [10,0,0,0,255];
    write(Obj_follower,stop,"uint8");
    
%% Move robot from air to water
    StepCtr.initEnv();
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 13 0 0 130';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171220_145703_12744_13033.csv';
%     
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);

%% Get data when robot in water
    follower_data = [10, int16(frequency*10), amplitude, strs(str_act2 + 1), 255];
    leader_data
    follower_data
    write(Obj_follower,follower_data,"uint8");
    
    pause(10);
        
    tstart = tic;
    tdata = sp.startForeground;
    telapsed = toc(tstart)

    data_water = mean(tdata);
    save_data_in_water = [save_data_in_water, tdata];
    
    stop = [10,0,0,0,255];
    write(Obj_follower,stop,"uint8");

    pi1 = (mean(data_water(:,4))-mean(data_air(:,4)))./(mean((data_water(:,2))-mean(data_air(:,2))))- Mean_colum_2_4;
    pi2 = (mean(data_water(:,3))-mean(data_air(:,3)))./(mean((data_water(:,1))-mean(data_air(:,1))))- Mean_colum_1_3;


    
    phase(t,1)=str1;
    phase(t,2)=str2;
    phase(t,3)=str_act2;
    
    t
    
%% Move robot from water to air
    StepCtr.initEnv();
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 13 0 0 -130';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171220_145703_12744_13033.csv';
%     
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    
    
end
figure(1)
%subplot(2,2,1)
plot((pi/2)*phase(:,3),'.','markersize',1)
ylim([-0.1 6.4])
xlabel('t')
ylabel('phase difference')
save('D:\Liang Li\RobotGame\15052023\save_data_in_air', 'save_data_in_air');
save('D:\Liang Li\RobotGame\15052023\save_data_in_water', 'save_data_in_water');
save('D:\Liang Li\RobotGame\15052023\phase', 'phase');