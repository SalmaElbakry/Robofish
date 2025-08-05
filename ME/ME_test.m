%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Revised Matlab example for streaming and saving data from channels 1 and 2 %
% for 10 seconds at 1000 fps.                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Define the COM Port
clear all
clc
com = 15;

% Load MEGSV Dynamic Link Library
if ~libisloaded('MEGSV86x64')
   loadlibrary('D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.DLL','D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.h')
end

% Activate channel
[extendet] = calllib('MEGSV86x64','GSV86actExt',com);  
calllib('MEGSV86x64','GSV86startTX',com);

% Set the sampling rate to 1000 fps
calllib('MEGSV86x64','GSV86setFrequency',com, 18000); 

%% Definition of Variables and Setup
x=zeros(1,1); % Vector filled with zeros
z=int32(0); % Integer32 variable

% Initialize libpointers for channels 1 and 2
adx1 = libpointer('doublePtr',x);
adx2 = libpointer('doublePtr',x);

% Data collection arrays
data1_collected = [];
data2_collected = [];


%% Data Acquisition Loop

% Timing setup
stopTime = datetime('now') + seconds(10);
startTime = datetime('now');

calllib('MEGSV86x64','GSV86clearDeviceBuf',com);
calllib('MEGSV86x64','GSV86clearDLLbuffer',com);

while datetime('now') <= stopTime
    
    pause(0.01); % Adjust pause for data acquisition frequency
    
    [error,data1]=calllib('MEGSV86x64','GSV86read',com,1,adx1);
    [error2,data2]=calllib('MEGSV86x64','GSV86read',com,2,adx2);
    
    % Append data to collection arrays

     data1_collected = [data1_collected, data1];
     data2_collected = [data2_collected, data2];

end

%% Post-Processing
% Here you can process or save the collected data. As an example, save to MAT file.
save('sensor_data.mat', 'data1_collected', 'data2_collected');

calllib('MEGSV86x64','GSV86release',com);     % Release Channel
unloadlibrary('MEGSV86x64');                  % Unload library
