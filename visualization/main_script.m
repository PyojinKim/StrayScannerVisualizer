clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;

addpath('MatlabProgressBar');
addpath('npy-matlab');
addpath(genpath(pwd));


%% main sciprt to parse rgb, depth, and confidence data

% define dataset directory from Stray Scanner app
datasetPath = '../rgbd_dataset_renaissance_03_corridor01';
process_data(datasetPath);


%% visualize rgb, depth, and confidence images

% image index
frameIndex = 200;


% read color, depth, and confidence images
colorImage = imread([datasetPath sprintf('/rgb/%06d.png', frameIndex)]);
depthImage = imread([datasetPath sprintf('/depth/%06d.png', frameIndex)]);
confImage = imread([datasetPath sprintf('/conf/%06d.png', frameIndex)]);


% 1) plot color, depth, and confidence image
figure;
subplot(1,3,1);
imshow(colorImage,[]);
title('RGB Image');
subplot(1,3,2);
imshow(depthImage,[]);
title('Depth Image');
subplot(1,3,3);
imshow(confImage,[]);
title('Confidence Image');


% 2) plot overlaid color, depth images
colorImageResized = imresize(colorImage, [size(depthImage)]);

figure;
imshow(colorImageResized,[]); hold on;
h = imshow(depthImage,[]); hold off;

[M,N] = size(depthImage);
block_size = 60;
P = ceil(M/block_size);
Q = ceil(N/block_size);
alpha_data = checkerboard(block_size, P, Q) > 0;
alpha_data = alpha_data(1:M, 1:N);
set(h, 'AlphaData', alpha_data);


% 3) plot 3D point cloud with color, depth images
load([datasetPath '/camera_matrix.mat']);
depthImage(confImage == 0) = 0;
[x3DptsCam, x3DptsColor] = generateColored3DPoints(colorImageResized, double(depthImage)/1000, 0, depth_K, 1);

figure;
numPts = size(x3DptsCam,2);
scatter3(x3DptsCam(1,:).' , x3DptsCam(2,:).' , x3DptsCam(3,:).' , 100*ones(numPts,1) , x3DptsColor.','.'); axis equal;

% figure options
f = FigureRotator(gca());




