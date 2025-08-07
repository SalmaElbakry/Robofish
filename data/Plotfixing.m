trial1Data = load('results_flow-40_amp-20_freq-1_trial-1.mat', 'TorFor_F', 'TorFor_L');
trial2Data = load('results_flow-40_amp-20_freq-1_trial-2.mat', 'TorFor_F', 'TorFor_L');
trial3Data = load('results_flow-40_amp-20_freq-1_trial-3.mat', 'TorFor_F', 'TorFor_L');

TorFor_F_1 = trial1Data.TorFor_F;
TorFor_L_1 = trial1Data.TorFor_L;

TorFor_F_2 = trial2Data.TorFor_F;
TorFor_L_2 = trial2Data.TorFor_L;

TorFor_F_3 = trial3Data.TorFor_F;
TorFor_L_3 = trial3Data.TorFor_L;

j = 1; % Flow speed index
numTrials = size(TorFor_F_1{1, j}, 1); 

figure
for i = 1:6 % For each axis (Fx, Fy, Fz, Tx, Ty, Tz)
    
    % Initialize matrices
    thrust_F_1 = zeros(9, numTrials);
    thrust_L_1 = zeros(9, numTrials);
    thrust_F_2 = zeros(9, numTrials);
    thrust_L_2 = zeros(9, numTrials);
    thrust_F_3 = zeros(9, numTrials);
    thrust_L_3 = zeros(9, numTrials);
    for trial = 1:numTrials
        for k = 1:9
            thrust_F_1(k, trial) = max(TorFor_F_1{k, j}(trial, i));
            thrust_L_1(k, trial) = max(TorFor_L_1{k, j}(trial, i));
            thrust_F_2(k, trial) = max(TorFor_F_2{k, j}(trial, i));
            thrust_L_2(k, trial) = max(TorFor_L_2{k, j}(trial, i));
            thrust_F_3(k, trial) = max(TorFor_F_3{k, j}(trial, i));
            thrust_L_3(k, trial) = max(TorFor_L_3{k, j}(trial, i));
        end
    end

    % Compute mean and std across trials
    mean_F_1 = mean(thrust_F_1, 2);
    std_F_1 = std(thrust_F_1, [], 2);
    
    mean_L_1 = mean(thrust_L_1, 2);
    std_L_1 = std(thrust_L_1, [], 2);
    
    mean_F_2 = mean(thrust_F_2, 2);
    std_F_2 = std(thrust_F_2, [], 2);
    
    mean_L_2 = mean(thrust_L_2, 2);
    std_L_2 = std(thrust_L_2, [], 2);
   
    mean_F_3 = mean(thrust_F_3, 2);
    std_F_3 = std(thrust_F_3, [], 2);
    
    mean_L_3 = mean(thrust_L_3, 2);
    std_L_3 = std(thrust_L_3, [], 2);
    % Plot
    subplot(2, 3, i)
    errorbar(1:9, mean_F_1, std_F_1, '-ob', 'DisplayName', '1 Follower');
    hold on
%     errorbar(1:9, mean_L_1, std_L_1, '-og', 'DisplayName', '1 Leader');
    
    errorbar(1:9, mean_F_2, std_F_2, '-or', 'DisplayName', '2 Follower');
%     errorbar(1:9, mean_L_2, std_L_2, '-ok', 'DisplayName', '2 Leader');
    
    errorbar(1:9, mean_F_3, std_F_3, '-ok', 'DisplayName', '3 Follower');
%     errorbar(1:9, mean_L_3, std_L_3, '-om', 'DisplayName', '3 Leader');
    
    xlabel('Phase Difference Index')
    ylabel('Max Force/Torque')
    title(sprintf('Axis %d', i))
    legend show
    grid on
end
