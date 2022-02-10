clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;

addpath('npy-matlab');
addpath('lsd_1.6');
addpath('MatlabProgressBar');
addpath(genpath(pwd));


%% main sciprt to parse rgb, depth, and confidence data

% define dataset directory from Stray Scanner app
datasetPath = '../rgbd_dataset_renaissance_03_corridor01';
process_data(datasetPath);




%%

data_path = datasetPath;



% save RGB image files
disp('Extract images from video...');
video_path = [data_path '/rgb.mp4'];
image_path = [data_path '/rgb'];
if (~exist(image_path, 'dir'))
    mkdir(image_path);
end
extract_frames(video_path, image_path);









%%








frameIndex =  831;





