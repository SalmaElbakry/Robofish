softData = load('flow_0_angle_10_fre_1_dist_7.mat', 'TorFor_F', 'TorFor_L');
%rigidData = load('RIGID_flow_0_angle_20_fre_1_dist_7.mat', 'TorFor_F', 'TorFor_L');
rigidData = load('flow_0_angle_10_fre_1_VERTdist_6.mat', 'TorFor_F', 'TorFor_L');

TorFor_F_soft = softData.TorFor_F;
TorFor_L_soft = softData.TorFor_L;

TorFor_F_rigid = rigidData.TorFor_F;
TorFor_L_rigid = rigidData.TorFor_L;

j = 1; % Flow speed index
numTrials = size(TorFor_F_soft{1, j}, 1); 

figure
for i = 1:6 % For each axis (Fx, Fy, Fz, Tx, Ty, Tz)
    
    % Initialize matrices
    thrust_F_soft = zeros(9, numTrials);
    thrust_L_soft = zeros(9, numTrials);
    thrust_F_rigid = zeros(9, numTrials);
    thrust_L_rigid = zeros(9, numTrials);

    for trial = 1:numTrials
        for k = 1:9
            thrust_F_soft(k, trial) = max(TorFor_F_soft{k, j}(trial, i));
            thrust_L_soft(k, trial) = max(TorFor_L_soft{k, j}(trial, i));
            thrust_F_rigid(k, trial) = max(TorFor_F_rigid{k, j}(trial, i));
            thrust_L_rigid(k, trial) = max(TorFor_L_rigid{k, j}(trial, i));
        end
    end

    % Compute mean and std across trials
    mean_F_soft = mean(thrust_F_soft, 2);
    std_F_soft = std(thrust_F_soft, [], 2);
    
    mean_L_soft = mean(thrust_L_soft, 2);
    std_L_soft = std(thrust_L_soft, [], 2);
    
    mean_F_rigid = mean(thrust_F_rigid, 2);
    std_F_rigid = std(thrust_F_rigid, [], 2);
    
    mean_L_rigid = mean(thrust_L_rigid, 2);
    std_L_rigid = std(thrust_L_rigid, [], 2);

    % Plot
    subplot(2, 3, i)
    errorbar(1:9, mean_F_soft, std_F_soft, '-ob', 'DisplayName', 'Soft Follower');
    hold on
    errorbar(1:9, mean_L_soft, std_L_soft, '-og', 'DisplayName', 'Soft Leader');
    errorbar(1:9, mean_F_rigid, std_F_rigid, '-or', 'DisplayName', 'Rigid Follower');
    errorbar(1:9, mean_L_rigid, std_L_rigid, '-ok', 'DisplayName', 'Rigid Leader');
    
    xlabel('Phase Difference Index')
    ylabel('Max Force/Torque')
    title(sprintf('Axis %d', i))
    legend show
    grid on
end
