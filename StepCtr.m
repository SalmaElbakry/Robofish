classdef StepCtr
    
    methods(Static)
        %%
        
        function runStepCtr(cmd)
            addpath('sshfrommatlab_12_withPublicKeyAuth')
            javaaddpath('sshfrommatlab_12_withPublicKeyAuth/ganymed-ssh2-build250.jar/ganymed-ssh2-build250.jar');
            
            %%%% Position control %%%%%
            channel  =  sshfrommatlab('pi','192.168.101.150','raspberry','');
            cmd = convertStringsToChars(cmd)
            [a,b] = sshfrommatlabissue(channel, cmd);
            
            % [a,b] = sshfrommatlabissue(channel, 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM1" -f "~/Desktop/test.csv"')
            
            
        end
        
        function initEnv()
            pyExec = 'C:/Users/liang/anaconda3/envs/flowtank/python.exe';
            pyRoot = fileparts(pyExec);
            p = getenv('PATH');
            p = strsplit(p, ';');
            addToPath = {
                pyRoot
                fullfile(pyRoot, 'Library', 'mingw-w64', 'bin')
                fullfile(pyRoot, 'Library', 'usr', 'bin')
                fullfile(pyRoot, 'Library', 'bin')
                fullfile(pyRoot, 'Scripts')
                fullfile(pyRoot, 'bin')
                };
            p = [addToPath(:); p(:)];
            p = unique(p, 'stable');
            p = strjoin(p, ';');
            setenv('PATH', p);
            disp('**********StepMotor Init Fished***********')
        end
        
        function setStepCtr(filename, mode, leader, follower, flag_return, distance)
            %             mode = ' speed';
            %             leader = ' True';
            %             follower = ' True';
            %             flag_return = ' False';
            %             distance = ' 10 100 0 0';
            %             filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
            if leader
                leader = ' --leader';
            else
                leader = '';
            end
            
            if follower
                follower = ' --follower';
            else
                follower = '';
            end
            
            if flag_return
                flag_return = ' --flag_return';
            else
                flag_return = '';
            end
            
            system(strcat('C:/Users/liang/anaconda3/envs/flowtank/python.exe "d:/Liang Li/RobotRepeatRealFish/python/new_step_ctr.py" --filename "' ...
                , filename , '" --distance ' , distance , ' --mode "' , mode , '"' , leader , follower, flag_return))
            
        end
        
        function fire
            %%
            
            %             Com = 'com4';
            Com = 'com10';
            % Com = '/dev/cu.usbmodem141211';
            
            newobjs = instrfind;
            if ~isempty(newobjs)
                
                for iobj = 1:length(newobjs)
                    obj = newobjs(iobj);
                    if strcmp('Serial-COM10',obj.Name)
                        fclose(obj);
                        delete(obj);
                    end
                end
                
                %                 fclose(newobjs);
                %                 delete(newobjs);
            end
            
            Obj=serial(Com,'baudrate',9600);
            fopen(Obj);
            pause(2);
            % pause(60)  % 60 seconds
            
            fwrite(Obj,int16(1))
            
            %pause(0.5);
            
            %fwrite(Obj,int16(0));
            fclose(Obj);
        end
        
        
        
        
        function back2ori(file,steps)
            fid = fopen(file, 'r');
            str = fread(fid, '*char').';
            fclose(fid);
            info = jsondecode(str);
            
            lx = info.leader.x;
            ly = info.leader.y;
            lz = info.leader.z;
            
            fx = info.follower.x;
            fy = info.follower.y;
            fz = info.follower.z;
            
            
            %%%% leader
            dx = -info.leader.x +info.leader_ori.x;
            dy = -info.leader.y +info.leader_ori.y;
            dz = -info.leader.z +info.leader_ori.z;
            
            StepCtr.dxyzCtr(dx,dy,dz,'leader',steps);
            
            info.leader.x = lx+dx;
            info.leader.y = ly+dy;
            info.leader.z = lz+dz;
            
            
            %%%% Follower
            dx = -info.follower.x +info.follower_ori.x;
            dy = -info.follower.y +info.follower_ori.y;
            dz = -info.follower.z +info.follower_ori.z;
            
            StepCtr.dxyzCtr(dx,dy,dz,'follower',steps);
            
            
            info.follower.x = fx+dx;
            info.follower.y = fy+dy;
            info.follower.z = fz+dz;
            
            StepCtr.fire;
            
            
            %%%%% save data
            fid = fopen(file,'w');
            fwrite(fid,jsonencode(info));
            fclose(fid)
            
        end
        
        function [Obj_leader,Obj_follower]= controlrobot()
            
            % Com = '/dev/tty.usbmodem1414201';
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
            % pause(60)  % 60 seconds
            
            frequency = 1 ; % frequency
            amplitude = 15 ; % amplitude
            phase = 0; % phase = 0.2*pi
            sendData = [10, int16(frequency*10), amplitude, phase, 255];
            % fwrite(Obj,int16(sendData));
            
            leader_data = sendData;
            
            fwrite(Obj_leader,int16(leader_data));
            fwrite(Obj_follower,int16(sendData));
            
        end
        
        function rundemo()
            
            
            cmd = 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM1" -d True ';
            StepCtr.runStepCtr(cmd);
            
            cmd = 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM0" -d True ';
            StepCtr.runStepCtr(cmd);
            
        end
        
        
        function dxyzCtr(dx,dy,dz,id,steps)
            % Some time leader and follower are switched after repower
            %         if strcmp(id,'leader')
            %             cmd = 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM1" -x '+string(dx)+...
            %                 ' -y '+string(dy)+...
            %                 ' -z ' + string(dz)+...
            %                 ' -s ' + string(steps);
            %         elseif strcmp(id,'follower')
            %             cmd = 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM0" -x '+string(dx)+...
            %                 ' -y '+string(dy)+...
            %                 ' -z ' + string(dz)+...
            %                 ' -s ' + string(steps);
            %         end
            
            if strcmp(id,'follower')
                cmd = 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM1" -x '+string(dx)+...
                    ' -y '+string(dy)+...
                    ' -z ' + string(dz)+...
                    ' -s ' + string(steps);
            elseif strcmp(id,'leader')
                cmd = 'python3  ~/Desktop/AllStepMotorArduino.py -p "/dev/ttyACM0" -x '+string(dx)+...
                    ' -y '+string(dy)+...
                    ' -z ' + string(dz)+...
                    ' -s ' + string(steps);
            end
            
            
            StepCtr.runStepCtr(cmd);
        end
        
        
        function update_xyz(file,dx,dy,dz,id)
            
            fid = fopen(file, 'r');
            str = fread(fid, '*char').';
            fclose(fid);
            info = jsondecode(str);
            
            lx = info.leader.x;
            ly = info.leader.y;
            lz = info.leader.z;
            
            fx = info.follower.x;
            fy = info.follower.y;
            fz = info.follower.z;
            
            if strcmp(id,'leader')
                info.leader.x = lx+dx;
                info.leader.y = ly+dy;
                info.leader.z = lz+dz;
            end
            
            if strcmp(id,'follower')
                info.follower.x = fx+dx;
                info.follower.y = fy+dy;
                info.follower.z = fz+dz;
            end
            
            fid = fopen(file,'w');
            fwrite(fid,jsonencode(info));
            fclose(fid)
        end
        
        function start_power(ipAddress,voltage)
            
            % Define IP address and port
            %         ipAddress = '10.126.17.79';
            port = 10001;
            %         voltage = 7.4; % Voltage in volts
            
            % Open TCP/IP connection
            t = tcpip(ipAddress, port, 'NetworkRole', 'client');
            t.Timeout = 10; % Set a timeout of 10 seconds
            fopen(t);
            
            % List of commands to send
            commands = {
                'UPMODE:NORMAL';  % Set to normal mode
                'LOOP:V';         % Set to constant voltage
                'MON';            % Turn output On
                %             sprintf('MWV:%0.2f', voltage);  % Set voltage
                sprintf('MWVR:%0.2f', voltage);  % Set voltage
                'SETFLOAT:F'      % Set float
                };
            
            % Send each command and receive a response
            try
                for i = 1:length(commands)
                    fprintf(t, '%s\r\n', commands{i});  % Send command
                    pause(0.1);  % Wait a little for the command to process
                    response = fscanf(t);  % Read response
                    fprintf('Command: %s, Response: %s\n', commands{i}, response);
                end
            catch e
                fprintf('Error sending commands: %s\n', e.message);
            end
            
            %         pause(10);
            %         fprintf(t, '%s\r\n','MOFF');  % Send command
            
            % Close connection
            fclose(t);
            delete(t);
            clear t;
        end
        
        function stop_power(ipAddress)
            % Define IP address and port
            %         ipAddress = '10.126.17.79';
            port = 10001;
            %         voltage = 7.4; % Voltage in volts
            
            % Open TCP/IP connection
            t = tcpip(ipAddress, port, 'NetworkRole', 'client');
            t.Timeout = 10; % Set a timeout of 10 seconds
            fopen(t);
            fprintf(t, '%s\r\n','MOFF');  % Send command
            % Close connection
            fclose(t);
            delete(t);
            clear t;
        end
        
        function [data1_collected, data2_collected] = read_force(time_record)
            com = 15;
            
            % Load MEGSV Dynamic Link Library
            if ~libisloaded('MEGSV86x64')
                loadlibrary('D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.DLL','D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.h')
            end
            
            % Activate channel
            [extendet] = calllib('MEGSV86x64','GSV86actExt',com);
            calllib('MEGSV86x64','GSV86startTX',com);
            
            % Set the sampling rate to 1000 fps
            % calllib('MEGSV86x64','GSV86setFrequency',com, 18000);
            calllib('MEGSV86x64','GSV86setFrequency',1000);
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
            stopTime = datetime('now') + seconds(time_record);
            startTime = datetime('now');
            
            calllib('MEGSV86x64','GSV86clearDeviceBuf',com);
            calllib('MEGSV86x64','GSV86clearDLLbuffer',com);
            
            while datetime('now') <= stopTime
                
                pause(0.01); % Adjust pause for data acquisition frequency
                
                [error,data1]=calllib('MEGSV86x64','GSV86readMultiple',com,1,adx1);
                [error2,data2]=calllib('MEGSV86x64','GSV86readMultiple',com,2,adx2);
                % [error,data1]=calllib('MEGSV86x64','GSV86read',com,1,adx1);
                % [error2,data2]=calllib('MEGSV86x64','GSV86read',com,2,adx2);
                % Append data to collection arrays
                
                data1_collected = [data1_collected, data1];
                data2_collected = [data2_collected, data2];
                
            end
        end
        
        function setupMEGSVDevice(sample_fre, com)
            % Default values for the input arguments
            if nargin < 1
                sample_fre = 1000; % Default sample frequency
            end
            if nargin < 2
                com = 15; % Default COM port number
            end
            
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
            
            % Set the sampling rate
            freqSetResult = calllib('MEGSV86x64', 'GSV86setFrequency', com, sample_fre);
            if freqSetResult ~= 0
                disp(['Frequency set error: ', num2str(freqSetResult)]);
            else
                disp(['Frequency set to ', num2str(sample_fre), ' fps successfully.']);
            end
            
            % Clear the device and DLL buffers
            calllib('MEGSV86x64', 'GSV86clearDeviceBuf', com);
            calllib('MEGSV86x64', 'GSV86clearDLLbuffer', com);
        end
        
        function channel_data = readMEGSVData(collect_time, com, ChannelsToRead)
            % Default values for the input arguments
            if nargin < 1
                collect_time = 10; % Default collection time in seconds
            end
            if nargin < 2
                com = 15; % Default COM port number
            end
            if nargin < 3
                ChannelsToRead = 2; % Default number of channels to read
            end
            
            % Define parameters for GSV86readMultiple
            NumMappedObjects = 8; % Total number of channels
            sample_fre = 1000; % Sampling frequency used during setup
            count = sample_fre * collect_time * NumMappedObjects; % Number of samples to read, ensuring the count is appropriate for all channels
            valsread = libpointer('int32Ptr', 0); % Pointer to the number of values read
            ErrFlags = libpointer('int32Ptr', 0); % Pointer to error flags
            
            % Allocate memory for the output array
            out = libpointer('doublePtr', zeros(1, count));
            
            % Pause for the specified collection time to gather data
            %     pause(collect_time);
            
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
            
            % Separate data for the specified channels
            if mod(num_vals_read, NumMappedObjects) == 0
                all_channel_data = reshape(data, NumMappedObjects, [])'; % Reshape data into channels
                channel_data = all_channel_data(:, 1:ChannelsToRead); % Data for the specified channels
            else
                disp('Data length is not a multiple of NumMappedObjects.');
                channel_data = [];
            end
        end


        
        function channel_data = readMEGSVDataWithPause(sample_fre, collect_time, com, ChannelsToRead)
            % Default values for the input arguments
            if nargin < 1
                sample_fre = 1000; % Default sample frequency
            end
            if nargin < 2
                collect_time = 10; % Default collection time in seconds
            end
            if nargin < 3
                com = 15; % Default COM port number
            end
            if nargin < 4
                ChannelsToRead = 2; % Default number of channels to read
            end
            
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
            
            % Set the sampling rate
            freqSetResult = calllib('MEGSV86x64', 'GSV86setFrequency', com, sample_fre);
            if freqSetResult ~= 0
                disp(['Frequency set error: ', num2str(freqSetResult)]);
            else
                disp(['Frequency set to ', num2str(sample_fre), ' fps successfully.']);
            end
            
            calllib('MEGSV86x64', 'GSV86clearDeviceBuf', com);
            calllib('MEGSV86x64', 'GSV86clearDLLbuffer', com);
            
            pause(collect_time);
            
            % Define parameters for GSV86readMultiple
            NumMappedObjects = 8; % Total number of channels
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
            
            % Separate data for the specified channels
            if mod(num_vals_read, NumMappedObjects) == 0
                all_channel_data = reshape(data, NumMappedObjects, [])'; % Reshape data into channels
                channel_data = all_channel_data(:, 1:ChannelsToRead); % Data for the specified channels
            else
                disp('Data length is not a multiple of NumMappedObjects.');
                channel_data = [];
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
        end
        
        
        
        
    end
    
    
end