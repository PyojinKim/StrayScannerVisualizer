function [confidence_frame_count] = rename_confidence_frames(in_folder, out_folder)

% re-name confidence image files
confidence_path_info = dir(in_folder);
confidence_path_info(1:2) = [];
confidence_frame_count = size(confidence_path_info,1);
fprintf('===== The number of confidence image frames: %06d ===== \n', confidence_frame_count);
for k = progress(1:confidence_frame_count)
    movefile([in_folder sprintf('/%06d.png', k-1)], [out_folder sprintf('/%06d.png', k)]);
end


end

% k = 1;
% figure;
% imshow(depth_frame_npy,[]);