function [x3DptsCam, x3DptsColor] = generateColored3DPoints(colorImage, depthImage, boundarySize, K, intervalFrame)

% recover 3D point cloud and RGB information
imageHeight = size(depthImage,1);
imageWidth = size(depthImage,2);
x3DptsCam = zeros(4,imageHeight*imageWidth);
x3DptsColor = zeros(3,imageHeight*imageWidth);
ptsCount = 0;
for v = (1+boundarySize):(imageHeight-boundarySize)
    for u = (1+boundarySize):(imageWidth-boundarySize)
        
        if (depthImage(v,u) >= 0.5 && depthImage(v,u) <= 12)
            ptsCount = ptsCount + 1;
            
            depth = depthImage(v,u);
            
            x3DptsCam(1,ptsCount) = ((u - K(1,3)) / K(1,1)) * depth;
            x3DptsCam(2,ptsCount) = ((v - K(2,3)) / K(2,2)) * depth;
            x3DptsCam(3,ptsCount) = depth;
            x3DptsCam(4,ptsCount) = 1;
            
            x3DptsColor(1,ptsCount) = double(colorImage(v,u,1)) / 255;
            x3DptsColor(2,ptsCount) = double(colorImage(v,u,2)) / 255;
            x3DptsColor(3,ptsCount) = double(colorImage(v,u,3)) / 255;
        end
    end
end
x3DptsCam(:,(ptsCount+1):end) = [];
x3DptsColor(:,(ptsCount+1):end) = [];
x3DptsCam = x3DptsCam(:,1:intervalFrame:end);
x3DptsColor = x3DptsColor(:,1:intervalFrame:end);


end

