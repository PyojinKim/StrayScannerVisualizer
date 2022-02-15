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


% downsample the data with target FPS (default is 60 Hz)
downsample_data(datasetPath, 20);


%% visualize rgb, depth, and confidence images

% image index
frameIndex = 504;


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
block_size = 50;
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


% 4) plot 6-DoF camera poses from Apple ARKit (VIO)
load([datasetPath '/odometry.mat']);

figure; hold on; grid on; axis equal;
L = 0.3; % coordinate axis length
A = [0 0 0 1; L 0 0 1; 0 0 0 1; 0 L 0 1; 0 0 0 1; 0 0 L 1]';
for k = 1:60:length(T_gc_ARKit)
    T = T_gc_ARKit{k};
    B = T * A;
    plot3(B(1,1:2),B(2,1:2),B(3,1:2),'-r','LineWidth',1);    % x: red
    plot3(B(1,3:4),B(2,3:4),B(3,3:4),'-g','LineWidth',1);   % y: green
    plot3(B(1,5:6),B(2,5:6),B(3,5:6),'-b','LineWidth',1);   % z: blue
end
plot3(p_gc_ARKit(1,:),p_gc_ARKit(2,:),p_gc_ARKit(3,:),'k','LineWidth',2);
plot_inertial_frame(0.5); xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');

% figure options
f = FigureRotator(gca());










