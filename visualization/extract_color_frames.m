function [color_frame_count] = extract_color_frames(video_path, out_folder)

% extract image frames from the video file
cap = VideoReader(video_path);
color_frame_count = cap.NumFrames;
fprintf('===== The number of color image frames: %06d ===== \n', color_frame_count);
for k = progress(1:color_frame_count)
    frame = read(cap, k);
    imwrite(frame, [out_folder sprintf('/%06d.png', k)]);
end


end

% k = 1;
% figure;
% imshow(frame);
