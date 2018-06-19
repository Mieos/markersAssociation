function addAssociation( src, eventData)

% Load global variables
global pointCloudIndex_GT pointCloudIndex_Used; % Index
global X correspondances; % associations

if pointCloudIndex_GT>0 && pointCloudIndex_Used>0
    
    % Add new correspondance
    fprintf('\nCorrespondance added : GT = %d , Used = %d\n\n',pointCloudIndex_GT,X(pointCloudIndex_Used));
    new_c = [pointCloudIndex_GT;X(pointCloudIndex_Used)];
    correspondances=horzcat(correspondances,new_c);
    
    
else
    
    fprintf('No correspondance set in a least one view\n');
    
end

end

