function h = clickA3DPoint(pointCloud,usedID)

% Clear vars
global pointCloudIndex_GT pointCloudIndex_Used;
pointCloudIndex_GT = -1;
pointCloudIndex_Used =-1;

global numberBalls totalMarkers;

global r; %Color
global X;

% Check if it is CT or Used points
if usedID == 1
    % Init fig: GT PC
    figure('Name','Figure GT');
else
    % Init fig: main PC
    figUsedSelect = figure('Name','Figure Used');
    uicontrol(figUsedSelect,'String','Add Association','Position', [20 20 120 20],'Callback', {@addAssociation});
    uicontrol(figUsedSelect,'String','Validate Associations','Position', [150 20 150 20],'Callback', {@validateAssociationsAndCompute});
    uicontrol(figUsedSelect,'String','Reset All Associations','Position', [310 20 150 20],'Callback', {@resetAllAssociations});

end

% Show PC
pcshow(pointCloud,'MarkerSize',150);
pointCloudPoint = pointCloud.Location;
pointCloudPoint = pointCloudPoint';

cameratoolbar('Show'); % show the camera toolbar
hold on; % so we can highlight clicked points without clearing the figure

% Update the markers view of the points
for i=(numberBalls+1):totalMarkers
    if usedID == 1
        selectedPoint = pointCloudPoint(:, i);
    else
        selectedPoint = pointCloudPoint(:, X(i));
    end
    h = plot3(selectedPoint(1,:), selectedPoint(2,:), selectedPoint(3,:), ...
        'Color', [r(i,1), r(i,2), r(i,3)] , 'MarkerSize', 5, 'Marker', '*'); 

end

rotate3d off;

% Add callBack on the points
set(gcf, 'WindowButtonDownFcn', {@callbackClickA3DPoint, pointCloud, usedID});
