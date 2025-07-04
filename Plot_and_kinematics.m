close all; % Close all existing figures
clc;       % Clear the command window
clear; % Clear all variables from the workspace

% Add necessary paths to access functions and data
addpath('./AMC/');
addpath('./Functions_rev/'); % Use the revised functions
addpath('./Gait Data/');

%load processed_data
load ('Gait Data/processed_gait_data_fields_angular.mat');
processed_data = mat_data.processed_data;
file_info = mat_data.file_info;

%% Plots

% Create and save trajectory plots for the unfiltered (original) data.
create_trajectory_plots(processed_data, file_info, true);

% Create and save trajectory plots for the filtered data.
create_filtered_trajectory_plots(processed_data, file_info, true);

% Create and save phase plots for the processed data.
create_phase_plots(processed_data, file_info, true);

% Create a 'Data' structure, where each cell represents a single gait cycle.
Data_filteredv2 = create_demos_structure_per_cycleV2(processed_data);

% Plot the angular kinematics positions.
plot_angular_kinematics_positions(Data_filteredv2, true);

reshaped_filtered_data = reshape_leg_data(Data_filteredv2);

% Calculate linear kinematics from the filtered 'Data' structure.
linear_kinematics = calculate_linear_kinematics(reshaped_filtered_data, -90);

% Save the calculated linear kinematics of the gait cycles.
save_linear_kinematics(linear_kinematics, 50);

% Create a 'Data' like structure for the linear kinematics.
Data_linear = create_linear_kinematics_structure(linear_kinematics);

% Plot the linear kinematics positions.
plot_linear_kinematics_positions(linear_kinematics, processed_data, true);

% Save the structured linear kinematics data.
structData = struct_kinematrics(linear_kinematics, size(linear_kinematics, 2));
save_linear_kinematics_structured(structData, 10);

fprintf('\n===  Plot and Save Kinematics ===\n');

