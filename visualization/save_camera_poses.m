function [camera_pose_count] = save_camera_poses(poses_path)

% convert T_gc SE(3) representation
camera_poses = readmatrix(poses_path);
camera_pose_count = size(camera_poses,1);
R_gc_ARKit = zeros(3,3,camera_pose_count);
p_gc_ARKit = zeros(3,camera_pose_count);
T_gc_ARKit = cell(1,camera_pose_count);
for k = progress(1:camera_pose_count)
    R_gc_ARKit(:,:,k) = q2r(camera_poses(k,[9 6 7 8]));
    p_gc_ARKit(:,k) = camera_poses(k,3:5);
    T_gc_ARKit{k} = [R_gc_ARKit(:,:,k), p_gc_ARKit(:,k);
        zeros(1,3), 1];
end


% save Apple ARKit (VIO) camera poses
data_path = poses_path(1:end-13);
save([data_path '/odometry.mat'],'R_gc_ARKit','p_gc_ARKit','T_gc_ARKit');


end

