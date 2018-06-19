function h = clickA3DPoint(pointCloud,usedID)

% Clear vars
global pointCloudIndex_GT pointCloudIndex_Used;
pointCloudIndex_GT = -1;
pointCloudIndex_Used =-1;

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

cameratoolbar('Show'); % show the camera toolbar
hold on; % so we can highlight clicked points without clearing the figure

rotate3d off;

% Add callBack on the points
set(gcf, 'WindowButtonDownFcn', {@callbackClickA3DPoint, pointCloud, usedID});
