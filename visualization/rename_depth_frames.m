function [depth_frame_count] = rename_depth_frames(in_folder, out_folder)

% re-name depth image files
depth_path_info = dir(in_folder);
depth_path_info(1:2) = [];
depth_frame_count = size(depth_path_info,1);
fprintf('===== The number of depth image frames: %06d ===== \n', depth_frame_count);
for k = progress(1:depth_frame_count)
    movefile([in_folder sprintf('/%06d.png', k-1)], [out_folder sprintf('/%06d.png', k)]);
end


end

% k = 1;
% figure;
% imshow(depth_frame_npy,[]);