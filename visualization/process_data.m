function process_data(data_path)

% extract color image files
disp('Extract color images from video...');
video_path = [data_path '/rgb.mp4'];
image_path = [data_path '/rgb'];
if (~exist(image_path, 'dir'))
    mkdir(image_path);
end
extract_color_frames(video_path, image_path);


% convert depth image files
disp('Convert depth images as png format...');
depth_path = [data_path '/depth'];
convert_depth_frames(depth_path);


% rename confidence image files
disp('Rename confidence images...');
conf_old_path = [data_path '/confidence'];
conf_new_path = [data_path '/conf'];
if (~exist(conf_new_path, 'dir'))
    mkdir(conf_new_path);
end
rename_confidence_frames(conf_old_path, conf_new_path);


% save camera intrinsics
intrinsics_path = [data_path '/camera_matrix.csv'];
color_K = readmatrix(intrinsics_path);
depth_K = eye(3);
depth_K(1,:) = color_K(1,:) / (1920/256);
depth_K(2,:) = color_K(2,:) / (1440/192);
save([data_path '/camera_matrix.mat'],'color_K','depth_K');


% save camera poses
poses_path = [data_path '/odometry.csv'];
save_camera_poses(poses_path);


end
