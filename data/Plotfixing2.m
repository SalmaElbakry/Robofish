% Define flow speeds and file naming
flowSpeeds = [0, 40, 80];
filePrefix = 'flow_%d_angle_10_fre_1_dist_7.mat';

% Preallocate cell arrays for all flows
TorFor_F_all = cell(1, length(flowSpeeds));
TorFor_L_all = cell(1, length(flowSpeeds));

% Load all horizontal data for each flow speed
for f = 1:length(flowSpeeds)
    fileName = sprintf(filePrefix, flowSpeeds(f));
    data = load(fileName, 'TorFor_F', 'TorFor_L');
    TorFor_F_all{f} = data.TorFor_F;
    TorFor_L_all{f} = data.TorFor_L;
end

j = 1; % Flow speed index (not used now ? you loop over flows)
numFlows = length(flowSpeeds);

figure
for i = 1:6 % For each axis (Fx, Fy, Fz, Tx, Ty, Tz)
    
    % Preallocate
    thrust_F = zeros(9, numFlows);
    thrust_L = zeros(9, numFlows);

    for f = 1:numFlows
        for k = 1:9
            thrust_F(k, f) = max(TorFor_F_all{f}{k, j}(:, i));
            thrust_L(k, f) = max(TorFor_L_all{f}{k, j}(:, i));
        end
    end

    % Plot
    subplot(2, 3, i)

%     % Follower
%     plot(1:9, thrust_F(:, 1), '-ob', 'DisplayName', 'Flow 0 Follower'); hold on
%     plot(1:9, thrust_F(:, 2), '-og', 'DisplayName', 'Flow 40 Follower');
%     plot(1:9, thrust_F(:, 3), '-or', 'DisplayName', 'Flow 80 Follower');

    % Leader
    plot(1:9, thrust_L(:, 1), '--ob', 'DisplayName', 'Flow 0 Leader'); hold on
    plot(1:9, thrust_L(:, 2), '--og', 'DisplayName', 'Flow 40 Leader');
    plot(1:9, thrust_L(:, 3), '--or', 'DisplayName', 'Flow 80 Leader');

    xlabel('Phase Difference Index')
    ylabel('Max Force/Torque')
    title(sprintf('Axis %d', i))
    legend show
    grid on
end
