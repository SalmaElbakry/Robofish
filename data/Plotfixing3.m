finTypes = {'soft', 'rigid'};
flowSpeed = 80;  % Only flow 80

TorFor_F_all = cell(2, 1); % soft, rigid
TorFor_L_all = cell(2, 1); % soft, rigid

% Load only flow 80 data
for fi = 1:2
    flowStr = sprintf('flow_%d_angle_20_fre_1_dist_7.mat', flowSpeed);
    if strcmp(finTypes{fi}, 'rigid')
        fileName = ['RIGID_' flowStr];
    else
        fileName = flowStr;
    end
    data = load(fileName, 'TorFor_F', 'TorFor_L');
    TorFor_F_all{fi} = data.TorFor_F;
    TorFor_L_all{fi} = data.TorFor_L;
end

colors = {'b', 'r'};                % soft = blue, rigid = red
lineStylesFollower = {'-', '--'};  % soft, rigid
lineStylesLeader   = {':', '-.'};  % soft, rigid
axisLabels = {'Fx', 'Fy', 'Fz', 'Tx', 'Ty', 'Tz'};

j = 1;  % Fixed second index

figure

for i = 1:6
    subplot(2, 3, i)
    hold on

    hLines = gobjects(4,1); % 2 fin types ? (follower + leader)
    legendLabels = cell(4,1);
    idx = 0;

    for fi = 1:2
        % Max per phase index (1 to 9)
        thrust_F = zeros(9,1);
        thrust_L = zeros(9,1);
        for k = 1:9
            thrust_F(k) = max(TorFor_F_all{fi}{k, j}(:, i));
            thrust_L(k) = max(TorFor_L_all{fi}{k, j}(:, i));
        end

        % Plot follower
        idx = idx + 1;
        hLines(idx) = plot(1:9, thrust_F, ...
            'Color', colors{fi}, ...
            'LineStyle', lineStylesFollower{fi});
        legendLabels{idx} = sprintf('%s Flow %d Follower', finTypes{fi}, flowSpeed);

        % Plot leader
        idx = idx + 1;
        hLines(idx) = plot(1:9, thrust_L, ...
            'Color', colors{fi}, ...
            'LineStyle', lineStylesLeader{fi});
        legendLabels{idx} = sprintf('%s Flow %d Leader', finTypes{fi}, flowSpeed);
    end

    xlabel('Phase Difference Index');
    ylabel('Max Force/Torque');
    title(axisLabels{i});
    legend(hLines, legendLabels, 'Location', 'best');
    grid on
end
