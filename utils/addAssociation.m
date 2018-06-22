function addAssociation( src, eventData)

% Load global variables
global pointCloudIndex_GT pointCloudIndex_Used; % Index
global X correspondances; % associations

global nP1 nP2;


if pointCloudIndex_GT>0 && pointCloudIndex_Used>0
    
    % Add new correspondance
    fprintf('\nCorrespondance added : GT = %d , Used = %d\n\n',pointCloudIndex_GT,X(pointCloudIndex_Used));
    idGT = pointCloudIndex_GT;
    idPc = X(pointCloudIndex_Used);
    if (idGT<=nP1 && idPc<=nP1) || (idGT>nP1 && idPc>nP1)
        new_c = [pointCloudIndex_GT;X(pointCloudIndex_Used)];
        correspondances=horzcat(correspondances,new_c);
    else
        fprintf('Associating markers belonging to different classes is not allowed\n');

    end
       
else
    
    fprintf('No correspondance set in a least one view\n');
    
end

end

