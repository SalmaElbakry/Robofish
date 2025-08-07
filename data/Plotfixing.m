horizData = load('flow_40_angle_10_fre_1_dist_7.mat', 'TorFor_F', 'TorFor_L');
vertData = load('flow_40_angle_10_fre_1_VERTdist_6.mat', 'TorFor_F', 'TorFor_L');

TorFor_F_horiz = horizData.TorFor_F;
TorFor_L_horiz = horizData.TorFor_L;

TorFor_F_vert = vertData.TorFor_F;
TorFor_L_vert = vertData.TorFor_L;

j = 1; % Flow speed index
numTrials = size(TorFor_F_horiz{1, j}, 1); 


for i = 1:6 % For each axis (Fx, Fy, Fz, Tx, Ty, Tz)
    
    % Initialize vectors (1 value per phase diff index)
    thrust_F_horiz = zeros(9, 1);
    thrust_L_horiz = zeros(9, 1);
    thrust_F_vert = zeros(9, 1);
    thrust_L_vert = zeros(9, 1);

    for k = 1:9
        % Max over time (row-wise), not trials
        thrust_F_horiz(k) = max(TorFor_F_horiz{k, j}(:, i));
        thrust_L_horiz(k) = max(TorFor_L_horiz{k, j}(:, i));
        
        thrust_F_vert(k) = max(TorFor_F_vert{k, j}(:, i));
        thrust_L_vert(k) = max(TorFor_L_vert{k, j}(:, i));
    end

    % No std ? only one run per condition
    subplot(2, 3, i)
    plot(1:9, thrust_F_horiz, '-ob', 'DisplayName', 'horiz Follower');
    hold on
    plot(1:9, thrust_L_horiz, '-og', 'DisplayName', 'horiz Leader');
    plot(1:9, thrust_F_vert, '-or', 'DisplayName', 'vert Follower');
    plot(1:9, thrust_L_vert, '-ok', 'DisplayName', 'vert Leader');

    xlabel('Phase Difference Index')
    ylabel('Max Force/Torque')
    title(sprintf('Axis %d', i))
    legend show
    grid on
end


% 
% figure
% for i = 1:6 % For each axis (Fx, Fy, Fz, Tx, Ty, Tz)
%     
%     % Initialize matrices
%     thrust_F_horiz = zeros(9, numTrials);
%     thrust_L_horiz = zeros(9, numTrials);
%     thrust_F_vert = zeros(9, numTrials);
%     thrust_L_vert = zeros(9, numTrials);
% 
%     for trial = 1:numTrials
%         for k = 1:9
%             thrust_F_horiz(k, trial) = max(TorFor_F_horiz{k, j}(trial, i));
%             thrust_L_horiz(k, trial) = max(TorFor_L_horiz{k, j}(trial, i));
%            
%             thrust_F_vert(k, trial) = max(TorFor_F_vert{k, j}(trial, i));
%             thrust_L_vert(k, trial) = max(TorFor_L_vert{k, j}(trial, i));
%         end
%     end
% 
%     % Compute mean and std across trials
%     mean_F_horiz = mean(thrust_F_horiz, 2);
%     std_F_horiz = std(thrust_F_horiz, [], 2);
%     
%     mean_L_horiz = mean(thrust_L_horiz, 2);
%     std_L_horiz = std(thrust_L_horiz, [], 2);
%     
%     mean_F_vert = mean(thrust_F_vert, 2);
%     std_F_vert = std(thrust_F_vert, [], 2);
%     
%     mean_L_vert = mean(thrust_L_vert, 2);
%     std_L_vert = std(thrust_L_vert, [], 2);
% 
%     % Plot
%     subplot(2, 3, i)
%     errorbar(1:9, mean_F_horiz, std_F_horiz, '-ob', 'DisplayName', 'horiz Follower');
%     hold on
% %     errorbar(1:9, mean_L_horiz, ustd_L_horiz, '-og', 'DisplayName', 'horiz Leader');
%     errorbar(1:9, mean_F_vert, std_F_vert, '-or', 'DisplayName', 'vert Follower');
% %     errorbar(1:9, mean_L_vert, std_L_vert, '-ok', 'DisplayName', 'vert Leader');
%     
%     xlabel('Phase Difference Index')
%     ylabel('Max Force/Torque')
%     title(sprintf('Axis %d', i))
%     legend show
%     grid on
% end
% 

