function callbackClickA3DPoint(src, eventData, pointCloud,usedID)

point = get(gca, 'CurrentPoint'); % mouse click position
camPos = get(gca, 'CameraPosition'); % camera position
camTgt = get(gca, 'CameraTarget'); % where the camera is pointing to

camDir = camPos - camTgt; % camera direction
camUpVect = get(gca, 'CameraUpVector'); % camera 'up' vector

% build an orthonormal frame based on the viewing direction and the 
% up vector (the "view frame")
zAxis = camDir/norm(camDir);    
upAxis = camUpVect/norm(camUpVect); 
xAxis = cross(upAxis, zAxis);
yAxis = cross(zAxis, xAxis);

rot = [xAxis; yAxis; zAxis]; % view rotation 

% Point Cloud
pointCloudPoint = pointCloud.Location;
pointCloudPoint = pointCloudPoint';

% the point cloud represented in the view frame
rotatedPointCloud = rot * pointCloudPoint; 

% the clicked point represented in the view frame
rotatedPointFront = rot * point' ;

% find the nearest neighbour to the clicked point 
pointCloudIndex = dsearchn(rotatedPointCloud(1:2,:)', ... 
    rotatedPointFront(1:2));

h = findobj(gca,'Tag','pt'); % try to find the old point
selectedPoint = pointCloudPoint(:, pointCloudIndex); 

hold on;

if isempty(h) % if it's the first click (i.e. no previous point to delete)
    
    % highlight the selected point
    h = plot3(selectedPoint(1,:), selectedPoint(2,:), ...
        selectedPoint(3,:), 'r.', 'MarkerSize', 20);
    
    set(h,'Tag','pt'); % set its Tag property for later use   
        

else % if it is not the first click

    delete(h); % delete the previously selected point
    
    % highlight the newly selected point
    h = plot3(selectedPoint(1,:), selectedPoint(2,:), ...
        selectedPoint(3,:), 'r.', 'MarkerSize', 20);  
    set(h,'Tag','pt');  % set its Tag property for later use

end


if usedID == 1
    global pointCloudIndex_GT;
    pointCloudIndex_GT = pointCloudIndex;
else
    global pointCloudIndex_Used;
    pointCloudIndex_Used = pointCloudIndex;
end


