
% Setup Environment
% Clear workspace, close figures, and add necessary paths.

close all;
clc;
clear;

% Add necessary paths to access functions and data
addpath('./AMC/');
addpath('./Functions_rev/'); % Use the revised functions
addpath('./Gait Data/');

%% Create Output Directories
% This function creates the necessary output directories for saving plots and data

create_output_directorie();

%%Main Execution - Data Processing
% Start the gait analysis process.

fprintf('\n=== Process Plot and Save All AMC Files Completed V2 ===\n');

% Get all AMC files from the specified directory.
amc_files = get_amc_files();
% Process all AMC files to extract and collect gait cycle data.
[all_cycles_data, file_info] = process_all_amc_files_v2(amc_files, false, false);

% Apply filtering to the collected gait data and calculate derivatives.
processed_data = apply_filtering_and_derivatives_v2(all_cycles_data);

% Ploting right leg angular kinematics
plot_gait_kinematics_v2(processed_data, 'right');

% Ploting left leg angular kinematics
plot_gait_kinematics_v2(processed_data, 'left');

% Save the processed data in multiple formats for further analysis.
save_processed_data_4D(processed_data);

%% Kinematics Calculation and Plotting
% Calculate and visualize linear kinematics.

% Calculate linear kinematics using the new function
% You might need to adjust the 'phi' angle based on your coordinate system
linear_kinematics = calculate_linear_kinematics_v2(processed_data, -90); 

save_linear_kinematics_structured(linear_kinematics, processed_data.time_standard);

plot_linear_kinematics_accelerations(linear_kinematics, processed_data.time_standard);
plot_linear_kinematics_velocities(linear_kinematics, processed_data.time_standard);
plot_linear_kinematics_positions(linear_kinematics, processed_data.time_standard);

% Plot linear kinematics (X vs Y)
plot_linear_kinematics_positions_xy(linear_kinematics);
plot_linear_kinematics_velocities_xy(linear_kinematics);
plot_linear_kinematics_accelerations_xy(linear_kinematics);