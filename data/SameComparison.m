function SameComparison()
    % Load all three trials inside the function
    trial1 = load('results_flow-40_amp-20_freq-1_trial-1.mat', 'TorFor_F', 'TorFor_L');
    trial2 = load('results_flow-40_amp-20_freq-1_trial-2.mat', 'TorFor_F', 'TorFor_L');
    trial3 = load('results_flow-40_amp-20_freq-1_trial-3.mat', 'TorFor_F', 'TorFor_L');

    % Create save directory for plots
    save_dir = fullfile(pwd, 'comparison_plots');
    if ~exist(save_dir, 'dir')
        mkdir(save_dir);
    end

    % Group trials in a cell array to pass together
    TorFor_F_trials = {trial1.TorFor_F, trial2.TorFor_F, trial3.TorFor_F};
    TorFor_L_trials = {trial1.TorFor_L, trial2.TorFor_L, trial3.TorFor_L};

    % Analyze and plot Follower data
    analyze_and_plot(TorFor_F_trials, 'Follower', save_dir);

    % Analyze and plot Leader data
    analyze_and_plot(TorFor_L_trials, 'Leader', save_dir);
end

function analyze_and_plot(TorFor_trials, title_prefix, save_dir)
    % TorFor_trials: 1x3 cell array, each with 9x1 cell arrays of 6000x6 matrices

    % Preallocate metric matrices: trials x phases
    num_trials = length(TorFor_trials);
    num_phases = 9;
    M1 = zeros(num_trials, num_phases); % Fx
    M2 = zeros(num_trials, num_phases); % Fy
    M3 = zeros(num_trials, num_phases); % Fz
    M4 = zeros(num_trials, num_phases); % Tx
    M5 = zeros(num_trials, num_phases); % Ty
    M6 = zeros(num_trials, num_phases); % Tz

    metric_type = 'mean';  % 'mean', 'rms', or 'max'

    for trial = 1:num_trials
        TorFor = TorFor_trials{trial};
        for phase_idx = 1:num_phases
            mat = TorFor{phase_idx}; % 6000x6 matrix

            % Compute metric on the full data matrix for that phase and trial
            switch metric_type
                case 'mean'
                    m = mean(mat, 1);
                case 'rms'
                    m = sqrt(mean(mat.^2, 1));
                case 'max'
                    m = max(abs(mat), [], 1);
                otherwise
                    error('Unsupported metric type');
            end

            M1(trial, phase_idx) = m(1);
            M2(trial, phase_idx) = m(2);
            M3(trial, phase_idx) = m(3);
            M4(trial, phase_idx) = m(4);
            M5(trial, phase_idx) = m(5);
            M6(trial, phase_idx) = m(6);
        end
    end

    axis_labels = {'Fx', 'Fy', 'Fz', 'Tx', 'Ty', 'Tz'};
    metric_matrices = {M1, M2, M3, M4, M5, M6};

    for i = 1:length(axis_labels)
        M = metric_matrices{i};
        means = mean(M, 1);

        figure;
        bar(means, 'FaceColor', [0.4 0.7 0.9]);
        hold on;

        % Plot individual trial values as black dots with jitter
        x_vals = repmat(1:num_phases, num_trials, 1);
        jitterAmount = 0.1;
        scatter(x_vals(:) + (rand(size(x_vals(:))) - 0.5) * jitterAmount, M(:), 40, 'k', 'filled');

        % Mark significant variation with star if std dev > 5% of mean
        for j = 1:num_phases
            if std(M(:, j)) > 0.05 * abs(means(j))
                text(j, means(j)*1.05, '*', 'HorizontalAlignment', 'center', 'FontSize', 16, 'Color', 'r');
            end
        end

        title(sprintf('%s - %s', title_prefix, axis_labels{i}), 'Interpreter', 'none');
        xlabel('Phase Index');
        ylabel('Value');
        grid on;
        xlim([0.5, num_phases + 0.5]);

        % Save figure as PNG
        filename = sprintf('%s_%s.png', title_prefix, axis_labels{i});
        filepath = fullfile(save_dir, filename);
        saveas(gcf, filepath);
        close(gcf); % close figure to prevent too many open windows
    end
end
