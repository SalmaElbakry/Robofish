com = 17;

% Load MEGSV Dynamic Link Library
if ~libisloaded('MEGSV86x64')
   loadlibrary('D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.DLL', 'D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.h')
end

% Activate channel
extendet = calllib('MEGSV86x64', 'GSV86actExt', com);
if extendet ~= 0
    disp(['Activation error: ', num2str(extendet)]);
else
    disp('Channel activated successfully.');
end

% Set the sampling rate to 1000 fps
sample_fre = 1000; % Sampling frequency
freqSetResult = calllib('MEGSV86x64', 'GSV86setFrequency', com, sample_fre);
if freqSetResult ~= 0
    disp(['Frequency set error: ', num2str(freqSetResult)]);
else
    disp(['Frequency set to ', num2str(sample_fre), ' fps successfully.']);
end

calllib('MEGSV86x64', 'GSV86clearDeviceBuf', com);
calllib('MEGSV86x64', 'GSV86clearDLLbuffer', com);

collect_time = 10; % Data collection time in seconds
pause(collect_time);

% Define parameters for GSV86readMultiple
NumMappedObjects = 8; % Total number of channels
ChannelsToRead = 6; % Number of channels we want to read
count = sample_fre * collect_time * NumMappedObjects; % Number of samples to read, ensuring the count is appropriate for all channels
valsread = libpointer('int32Ptr', 0); % Pointer to the number of values read
ErrFlags = libpointer('int32Ptr', 0); % Pointer to error flags

% Allocate memory for the output array
out = libpointer('doublePtr', zeros(1, count));

% Read data from the device
[error, ~] = calllib('MEGSV86x64', 'GSV86readMultiple', com, 0, out, count, valsread, ErrFlags);

% Retrieve the actual number of values read
num_vals_read = get(valsread, 'Value');
data = get(out, 'Value');
data = data(1:num_vals_read); % Resize the data array to the number of values actually read

% Check for errors
if error ~= 0
    disp(['GSV86readMultiple error: ', num2str(error)]);
end

% Display number of values read
disp(['Number of values read: ', num2str(num_vals_read)]);

% Separate data for the first 2 channels
if mod(num_vals_read, NumMappedObjects) == 0
    channel_data = reshape(data, NumMappedObjects, [])'; % Reshape data into channels
    channel_1_data = channel_data(:, 1); % Data for channel 1
    channel_2_data = channel_data(:, 2); % Data for channel 2
    
    % Save the data for the first 2 channels
%     save('channel_1_data.mat', 'channel_1_data');
%     save('channel_2_data.mat', 'channel_2_data');
    
    disp('Data for Channel 1:');
    disp(channel_1_data);
    disp('Data for Channel 2:');
    disp(channel_2_data);
else
    disp('Data length is not a multiple of NumMappedObjects.');
end

% Test with GSV86read
adx1 = libpointer('doublePtr', zeros(1, 1));
[error_single, data1] = calllib('MEGSV86x64', 'GSV86read', com, 1, adx1);

% Display single read result
if error_single == 0
    single_value = get(adx1, 'Value');
    disp(['Single read value: ', num2str(single_value)]);
else
    disp(['Single read error: ', num2str(error_single)]);
end
