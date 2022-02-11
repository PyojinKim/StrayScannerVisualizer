function [depth_frame_count] = convert_depth_frames(depth_path)

% convert depth format from npy to png
depth_path_info = dir(depth_path);
depth_path_info(1:2) = [];
depth_frame_count = size(depth_path_info,1);
for k = progress(1:depth_frame_count)
    depth_frame_npy = readNPY([depth_path sprintf('/%06d.npy', k-1)]);
    imwrite(depth_frame_npy, [depth_path sprintf('/%06d.png', k)]);
end


end

% k = 1;
% figure;
% imshow(depth_frame_npy,[]);