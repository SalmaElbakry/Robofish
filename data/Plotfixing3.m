finTypes = {'soft', 'rigid'};
flowSpeeds = 80;  % Only flow 80
role = {'Follower', 'Leader'};      % Correctly define role names

% Preallocate
TorFor_F_all = cell(length(flowSpeeds), length(finTypes));
TorFor_L_all = cell(length(flowSpeeds), length(finTypes));

% Load only flow 80 data
for fi = 1:2
    flowStr = sprintf('flow_%d_angle_20_fre_1_dist_7.mat', flowSpeeds);
    if strcmp(finTypes{fi}, 'rigid')
        fileName = ['RIGID_' flowStr];
    else
        fileName = flowStr;
    end
    data = load(fileName, 'TorFor_F', 'TorFor_L');
    TorFor_F_all{fi} = data.TorFor_F;
    TorFor_L_all{fi} = data.TorFor_L;
end

% Set styles
colors = {'b', 'r'};                % Blue for Follower, Red for Leader
markers = {'o', 's'};               % Distance 7 = o, Distance 4 = s
axisLabels = {'Fx', 'Fy', 'Fz', 'Tx', 'Ty', 'Tz'};

figure;
for i = 1:6
    subplot(2,3,i)
    hold on
    legendEntries = {};
    
    for a = 1:length(finTypes)
        % Extract and plot follower
        thrust_F = zeros(9,1);
        for k = 1:9
            thrust_F(k) = max(TorFor_F_all{1, a}{k, 1}(:, i));
        end
        plot(1:9, thrust_F, ...
            'Color', colors{1}, ...
            'LineStyle', '-', ...
            'Marker', markers{a}, ...
            'DisplayName', sprintf('Flow %d Fin Type %s Follower', flowSpeeds, finTypes{a}));

        % Extract and plot leader
        thrust_L = zeros(9,1);
        for k = 1:9
            thrust_L(k) = max(TorFor_L_all{1, a}{k, 1}(:, i));
        end
        plot(1:9, thrust_L, ...
            'Color', colors{2}, ...
            'LineStyle', '-', ...
            'Marker', markers{a}, ...
            'DisplayName', sprintf('Flow %d Fin Type %s Leader', flowSpeeds, finTypes {a}));
    end
    
    title(axisLabels{i});
    xlabel('Phase Index');
    ylabel('Force/Torque');
    grid on;
    legend('Location', 'bestoutside');
end
