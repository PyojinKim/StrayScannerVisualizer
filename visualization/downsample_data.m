function downsample_data(data_path, targetFPS)

% compute frame interval (default is 60 Hz)
frameInterval = 60/targetFPS;


% downsample color image files
rgb_input_path = [data_path '/rgb'];
rgb_output_path = [data_path '/rgb_downsampled'];
if (~exist(rgb_output_path, 'dir'))
    mkdir(rgb_output_path);
end
rgb_path_info = dir(rgb_input_path);
rgb_path_info(1:2) = [];
rgb_frame_count = size(rgb_path_info,1);
frameCount = 0;
for k = progress(1:frameInterval:rgb_frame_count)
    frameCount = frameCount + 1;
    copyfile([rgb_input_path sprintf('/%06d.png', k)], [rgb_output_path sprintf('/%06d.png', frameCount)]);
end


% downsample depth image files
depth_input_path = [data_path '/depth'];
depth_output_path = [data_path '/depth_downsampled'];
if (~exist(depth_output_path, 'dir'))
    mkdir(depth_output_path);
end
depth_path_info = dir(depth_input_path);
depth_path_info(1:2) = [];
depth_frame_count = size(depth_path_info,1);
frameCount = 0;
for k = progress(1:frameInterval:depth_frame_count)
    frameCount = frameCount + 1;
    copyfile([depth_input_path sprintf('/%06d.png', k)], [depth_output_path sprintf('/%06d.png', frameCount)]);
end


% downsample confidence image files
conf_input_path = [data_path '/conf'];
conf_output_path = [data_path '/conf_downsampled'];
if (~exist(conf_output_path, 'dir'))
    mkdir(conf_output_path);
end
conf_path_info = dir(conf_input_path);
conf_path_info(1:2) = [];
conf_frame_count = size(conf_path_info,1);
frameCount = 0;
for k = progress(1:frameInterval:conf_frame_count)
    frameCount = frameCount + 1;
    copyfile([conf_input_path sprintf('/%06d.png', k)], [conf_output_path sprintf('/%06d.png', frameCount)]);
end


% downsample camera poses
load([data_path '/odometry.mat']);
camera_pose_count = length(T_gc_ARKit);
R_gc_ARKit = R_gc_ARKit(:,:,1:frameInterval:camera_pose_count);
p_gc_ARKit = p_gc_ARKit(:,1:frameInterval:camera_pose_count);
T_gc_ARKit = T_gc_ARKit(1:frameInterval:camera_pose_count);
save([data_path '/odometry_downsampled.mat'],'R_gc_ARKit','p_gc_ARKit','T_gc_ARKit');


end

