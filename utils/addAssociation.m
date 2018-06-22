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
        
        clearvars correspondanceGT correspondanceU findGT findU;
        
        [~,sizeC]=size(correspondances);
        
        if (sizeC == 0)
            sizeGT=0;
            sizeU=0;
        else 
            
            findGT=find(correspondances(1,:)==pointCloudIndex_GT);
            findU=find(correspondances(2,:)==X(pointCloudIndex_Used));
            [~,sizeGT]=size(findGT);
            [~,sizeU]=size(findU);
            
        end
        
        if(sizeGT==0 && sizeU==0)
            new_c = [pointCloudIndex_GT;X(pointCloudIndex_Used)];
            correspondances=horzcat(correspondances,new_c);
        else
           fprintf('Uncoherent association... TODO:replace instead of ignore\n');

        end     
    
    else
        fprintf('Associating markers belonging to different classes is not allowed\n');

    end
       
else
    
    fprintf('No correspondance set in a least one view\n');
    
end

end

