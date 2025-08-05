% clear

% set the com
Com_leader = 'com5';

% close the com if it is open
newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader Obj_follower

% open com
Obj_leader = serialport(Com_leader,9600);


%% set NI data acqustion
sp                   = daq.createSession('ni');
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current');  % leader current
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');  % follower current
sp.Rate              = 5000;
sp.DurationInSeconds = 10; % 1 second

%% initiate analysis parameters

flow_speed = 0; % saved for reference later
vertical_distance = 100; % mm from bottom of metal to water surface
horizontal_distance = 70; % mm


T = 1; % samples per phase difference

air_calib = zeros(sp.Rate*sp.DurationInSeconds, 2, 2, T); % for storing before and after calibration data IN AIR; samples x fish id x before/after x replicates
water_calib = zeros(sp.Rate*sp.DurationInSeconds, 2, 2, T); % for storing before and after calibration data IN WATER
phase_data = zeros(sp.Rate*sp.DurationInSeconds, 2, 4, T); % for storing phase difference data
forcedata = cell(10,2,T);

%% initiate step motor and experiment params

StepCtr.initEnv();

frequency = 1;
amplitude = 20;


%% Power on
StepCtr.start_power('10.126.17.79',7.4);

%% run experiment

disp('Calibration With zero flow speed')
% move_fish(true, true, 'down', [false, false]);

phase_idx = 1;
[phase_data,forcedata] = collect_phase(phase_data, forcedata, phase_idx, 1, Obj_leader, sp, 1, 0);

Calibration = forcedata;

clear forcedata;

%save('11062024_Calibration','Calibration');

disp('******************')
disp('Give flow speed')
disp('******************')
%%

% get fish into water
disp('Experiment beginning.')
% move_fish(true, true, 'down', [false, false]);
phase_data = zeros(sp.Rate*sp.DurationInSeconds, 2, 4, T);
forcedata = cell(11,2,T);
% tic; % set timer for motor drying
for t = 1:T
    for phase_idx = 1:11
        [phase_data,forcedata] = collect_phase(phase_data, forcedata, phase_idx, t, Obj_leader, sp, frequency, amplitude);
        pause(20);
    end
end

% get fish out of water
disp('******************')
disp('Experiment completed.')
disp('******************')
% move_fish(true, true, 'up', [true, true])

%% power off
StepCtr.stop_power('10.126.17.79');

%% plot
m_phase_data = squeeze(mean(phase_data,1));

for ii = 1:1
   plot(m_phase_data(1,:,ii)-mean(m_phase_data(1,:,ii)),'r');
   %hold on
  % plot(m_phase_data(2,:,ii)-mean(m_phase_data(2,:,ii)),'b');
end

m_force_data = zeros(10,2);
for ii = 1:10
   for jj = 1:1
       m_force_data(ii,jj) = mean(forcedata{ii,jj});
   end
end

figure

plot(m_force_data(:,1)-mean(m_force_data(:,1)),'r');
hold on
plot(m_force_data(:,2)-mean(m_force_data(:,2)),'b');

save('11062024_WithHump_test5','phase_data','forcedata');
%% function definitions

function in_water = move_fish(leader, follower, direction, in_water) % move fish up and down
    mode = 'distance';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171220_145703_12744_13033.csv';
    flag_return = false;
    
    if strcmp(direction, 'down')
        direction = ' 10 0 0 100';
    else
        direction = ' 10 0 0 -100';
    end

    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, direction);
    pause(5);
    StepCtr.fire;
    pause(15);
    
    in_water = xor(in_water, [leader, follower]); % if moving is true, switch location
end

function [air_calib, water_calib] = collect_calib(air_calib, water_calib, t, in_water, calib_idx, Obj_leader, sp, frequency, amplitude) % collect calibration data
    leader_data = [10, int16(frequency*10), amplitude, 0, 255];
    stop = [10,0,0,0,255];
    
    write(Obj_leader,leader_data,"uint8");
    pause(20) % added to make sure fish stabilize first

    % collect current
    ndata = sp.startForeground;
    air_calib(:,~in_water, calib_idx, t) = ndata(:,~in_water);
    water_calib(:,in_water, calib_idx, t) = ndata(:,in_water);

    write(Obj_leader,stop,"uint8");
    
    end

function [air_calib, water_calib] = calibrate(air_calib, water_calib, t, calib_idx, Obj_leader, sp, frequency, amplitude) % calibrate
    % starting with both fish underwater
    in_water = [true, true]; % boolean for fish location
   
    for fish_bool = [false, true]
        in_water = move_fish(fish_bool, ~fish_bool, 'up', in_water); % move follower (leader) up
        [air_calib, water_calib] = collect_calib(air_calib, water_calib, t, in_water, calib_idx, Obj_leader, sp, frequency, amplitude); % collect calibration data
        in_water = move_fish(fish_bool, ~fish_bool, 'down', in_water); % move follower (leader) down
    end 
    
end

function [phase_data,forcedata] = collect_phase(phase_data,forcedata, phase_idx, t, Obj_leader, sp, frequency, amplitude)
%     strs = [0,5,10,15];   
    strs = 0:2:20;
    leader_data = [10, int16(frequency*10), amplitude, strs(phase_idx), 255]
    stop = [10,0,0,0,255];
    
    write(Obj_leader,leader_data,"uint8");
   % pause(10); % added to make sure fish stabilize first
   
   % initial and clear buffer
   StepCtr.setupMEGSVDevice();
   
%     meas_time = 10;
%     [data1,data2] = StepCtr.read_force(meas_time);
%     forcedata{phase_idx,1,t} = 0%data1;
%     forcedata{phase_idx,2,t} = 0%data2;
    % collect current
    ndata = sp.startForeground;
    temp_data = StepCtr.readMEGSVData();
    forcedata{phase_idx,1,t} = temp_data(:,1);
    forcedata{phase_idx,2,t} = temp_data(:,2);
    phase_data(:, :, phase_idx, t) = ndata;

    write(Obj_leader,stop,"uint8");
end