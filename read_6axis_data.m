function read_6axis_data(SAMPLE_FREQUENCY, COLLECT_TIME, DX, DY, i)
    % Constants
    DLL_PATH = 'D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.DLL';
    HEADER_PATH = 'D:\Liang Li\RobotRepeatRealFish\matlab\ME\MEGSV86x64.h';
    NUM_MAPPED_OBJECTS = 8; % Total number of channels
    COM_PORTS = [17, 16];   % Ports for COM46 and COM48
    SAVE_DIR = 'D:\6-axis-text';

    % Calibration Matrices
    CALIBRATION_MATRICES = {
        [ % Calibration matrix for COM_PORT_46 (17)
            0.4525326, 0.5137473, 0.07654386, -0.3078597, -0.08554186, -0.09565293;
            0.2773063, 0.7483752, 0.1233457, -0.7209178, -1.204898, 0.8898338;
            4.772116, -0.2412358, 1.422663, -0.822579, -4.541403, -0.7100273;
            -0.005488863, 0.04222495, 0.001360718, 0.02178899, 0.05172858, 0.0234003;
            0.01978357, -0.05626201, 0.01356423, -0.02562629, -0.09929114, -0.02041247;
            -0.3161978, -0.08556213, -0.03002926, 0.1027815, 0.265269, 0.01128204
        ],
        [ % Calibration matrix for COM_PORT_48 (16)
            0.09678097, 0.008990455, -0.07904781, 0.2991395, 0.1744586, 0.01933129;
            0.1247758, 0.821294, 0.04712149, -0.8001997, -1.178357, 1.039231;
            5.765519, -0.4593048, 1.597284, -1.223317, -5.95459, -0.8186712;
            -0.05588313, 0.006519643, 0.02016748, -0.06428035, -0.02628075, -0.003389345;
            -0.1551748, 0.1339836, 0.04221497, -0.2477154, 0.0405585, -0.04452768;
            -0.4049419, 0.1249276, -0.006993765, -0.1373354, 0.3780616, 0.003068113
        ]
    };

    % Load MEGSV Dynamic Link Library
    if ~libisloaded('MEGSV86x64')
        loadlibrary(DLL_PATH, HEADER_PATH);
        disp('DLL loaded successfully.');
    end

    try
        % Stop and release both COM ports before starting
        for com = COM_PORTS
            try
                calllib('MEGSV86x64', 'GSV86clearDeviceBuf', com);
                calllib('MEGSV86x64', 'GSV86clearDLLbuffer', com);
                calllib('MEGSV86x64', 'GSV86release', com);
                disp(['COM', num2str(com), ' stopped and released.']);
            catch
                disp(['COM', num2str(com), ' was not active or could not be released.']);
            end
        end

        % Loop through each COM port
        for idx = 1:length(COM_PORTS)
            com = COM_PORTS(idx);
            calibration_matrix = CALIBRATION_MATRICES{idx};
            port_name = ['COM', num2str(com)];

            % Activate channel
            extendet = calllib('MEGSV86x64', 'GSV86actExt', com);
            if extendet ~= 0
                error(['Activation error: ', num2str(extendet), ' for ', port_name]);
            else
                disp([port_name, ' activated successfully.']);
            end

            % Set the sampling rate to 1000 fps
            freqSetResult = calllib('MEGSV86x64', 'GSV86setFrequency', com, SAMPLE_FREQUENCY);
            if freqSetResult ~= 0
                error(['Frequency set error: ', num2str(freqSetResult), ' for ', port_name]);
            else
                disp(['Frequency set to ', num2str(SAMPLE_FREQUENCY), ' Hz successfully for ', port_name]);
            end

            % Clear buffers
            calllib('MEGSV86x64', 'GSV86clearDeviceBuf', com);
            calllib('MEGSV86x64', 'GSV86clearDLLbuffer', com);

            % Wait for data collection
            pause(COLLECT_TIME);

            % Define parameters for GSV86readMultiple
            count = SAMPLE_FREQUENCY * COLLECT_TIME * NUM_MAPPED_OBJECTS;
            valsread = libpointer('int32Ptr', 0); % Pointer to the number of values read
            ErrFlags = libpointer('int32Ptr', 0); % Pointer to error flags
            out = libpointer('doublePtr', zeros(1, count)); % Allocate memory for the output array

            % Read data from the device
            [err_code, ~] = calllib('MEGSV86x64', 'GSV86readMultiple', com, 0, out, count, valsread, ErrFlags);

            % Retrieve the actual number of values read
            num_vals_read = get(valsread, 'Value');
            data = get(out, 'Value');
            data = data(1:num_vals_read); % Resize the data array to the number of values actually read

            % Check for errors
%             if err_code ~= 1
%                 error(['GSV86readMultiple error: ', num2str(err_code), ' for ', port_name]);
%             end

            % Display number of values read
            disp(['Number of values read for ', port_name, ': ', num2str(num_vals_read)]);

            % Process data
            if mod(num_vals_read, NUM_MAPPED_OBJECTS) == 0
                channel_data = reshape(data, NUM_MAPPED_OBJECTS, [])'; % Reshape data into channels
                voltage_signals = channel_data(:, 1:6); % Extract first 6 channels
                forces_torques = voltage_signals * calibration_matrix'; % Apply calibration matrix

                % Generate file name
                file_name = sprintf('forces_torques_%s_Dx=%.2f_Dy=%.2f_i=%d.csv', port_name, DX, DY, i);
                file_path = fullfile(SAVE_DIR, file_name);

                % Save data
                writematrix(forces_torques, file_path);
                disp(['Force/Torque data saved for ', port_name, ' to ', file_path]);
            else
                disp(['Data length is not a multiple of NUM_MAPPED_OBJECTS for ', port_name]);
            end
        end
    catch ME
        disp(['Error: ', ME.message]);
    end

    % Unload DLL
    if libisloaded('MEGSV86x64')
        unloadlibrary('MEGSV86x64');
        disp('DLL unloaded successfully.');
    end
end
