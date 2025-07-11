%% Process Plot and Save All AMC Files
% This script performs an enhanced gait analysis on AMC files. It processes
% multiple AMC files, extracts gait cycles, filters the data

close all; % Close all existing figures
clc;       % Clear the command window
clear; % Clear all variables from the workspace

% Add necessary paths to access functions and data
addpath('./AMC/');
addpath('./Functions_rev/'); % Use the revised functions
addpath('./Gait Data/');

%% Create Output Directories
% This function creates the necessary output directories for saving plots and data.
create_output_directorie();

%% Main Execution
fprintf('=== Gait Analysis v5 Started ===\n');

% Get all AMC files from the specified directory.
amc_files = get_amc_files();

% Process all AMC files to extract and collect gait cycle data.
[all_cycles_data, file_info] = process_all_amc_files(amc_files, false, false);

% Apply filtering to the collected gait data and calculate derivatives.
processed_data = apply_filtering_and_derivatives(all_cycles_data);

% Save the processed data in multiple formats for further analysis.
save_processed_data(processed_data, file_info, 50);

% % Reshape the processed data for further analysis and plotting.
% reshaped_data = reshapeProcessedData(processed_data);
% 
% % Plot the joint cycles from the reshaped data.
% plot_joint_cycles(reshaped_data);


%% plots

% Create and save trajectory plots for the unfiltered (original) data.
create_trajectory_plots(processed_data, file_info, false);

% Create and save trajectory plots for the filtered data.
create_filtered_trajectory_plots(processed_data, file_info, false);

% Create and save phase plots for the processed data.
create_phase_plots(processed_data, file_info, false);

% Create a 'Data' structure, where each cell represents a single gait cycle.
Data_filteredv2 = create_demos_structure_per_cycleV2(processed_data);

% Plot the angular kinematics positions.
plot_angular_kinematics_positions(Data_filteredv2, false);

reshaped_filtered_data = reshape_leg_data(Data_filteredv2);

% Calculate linear kinematics from the filtered 'Data' structure.
linear_kinematics = calculate_linear_kinematics(reshaped_filtered_data, -90);

% Save the calculated linear kinematics of the gait cycles.
save_linear_kinematics(linear_kinematics, 50);

% Create a 'Data' like structure for the linear kinematics.
Data_linear = create_linear_kinematics_structure(linear_kinematics);

% Plot the linear kinematics positions.
plot_linear_kinematics_positions(linear_kinematics, processed_data, false);

% Save the structured linear kinematics data.
structData = struct_kinematrics(linear_kinematics, size(linear_kinematics, 2));
save_linear_kinematics_structured(structData, 10);

fprintf('\n===  Process Plot and Save All AMC Files ===\n');

