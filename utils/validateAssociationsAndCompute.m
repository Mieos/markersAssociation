function validateAssociationsAndCompute( src, eventData)

fprintf('Computing associations...\n');

global nP1 nP2 numberBalls totalMarkers; % Number of points
global pUsed pGT; % Points
global KnnGT KnnUsed; % KNN results
global euc1 euc2; % Euclidians distances
global sigma; % Threshold for W
global X correspondances; % Correspondances
global r; %Color

% Close clicking objects
close all;

correspondances

% Build allowed associations matrix
E12 = ones(nP1,nP2);
% Manual associations
[~,size_c_y]=size(correspondances);
for i=1:size_c_y
    i_cor = correspondances(1,i);
    j_cor = correspondances(2,i);
    for j=1:nP1
        E12(i_cor,j)=0;
        E12(j,j_cor)=0;
    end
    E12(i_cor,j_cor)=1;
end
% Do not associate balls and clips together
for i=1:numberBalls
    for j=(numberBalls+1):totalMarkers
        E12(i,j)=0;
        E12(j,i)=0;
    end
end

% Compute W
[I12(:,1),I12(:,2)]=find(E12);
[sx, ~] = size(I12);

W = eye(sx,sx);

%% Compute W
for i=1:sx
    for j=1:sx
        i1 = I12(i,1);
        i2 = I12(i,2);
        j1 = I12(j,1);
        j2 = I12(j,2);
        if((i1~=j1) && (i2~=j2) ) %not already taken
            
            [~,knFindGTy] = size(find(KnnGT(i1,:)==j1));
            [~,knFindUy] = size(find(KnnUsed(i2,:)==j2));
            
            if(knFindGTy>0 && knFindUy>0)
                %W(i,j) = exp(-(sigma*abs(euc1(i1,j1) - euc2(i2,j2)))/(max(euc1(i1,j1),euc2(i2,j2))+epsilon));
                W(i,j) = exp(-(sigma*abs(euc1(i1,j1) - euc2(i2,j2))));
            end
            
        end
        
    end
end

options.constraintMode='both'; %'both' for 1-1 graph matching
options.isAffine=1;% affine constraint
options.isOrth=1;%orthonormalization before discretization
options.normalization='iterative';%bistochastic kronecker normalization
% options.normalization='none'; %we can also see results without normalization
options.discretisation=@discretisationGradAssignment; %function for discretization
options.is_discretisation_on_original_W=0;

% Compute association
[X12,~,~]=compute_graph_matching_SMAC(W,E12,options);

% Update X
X=zeros(nP1,1,'uint32');
for i=1:nP1
    for j=1:nP2
        if(X12(i,j)==1)
            X(i)=j;
            break;
        end
    end
end

pcU = pointCloud(pUsed(:,X(:))','Color', r);
pcGT = pointCloud(pGT','Color',r);

% Show intermediate results
figResults = figure('Name','Results');
uicontrol(figResults,'String','Continue','Position', [20 20 120 20],'Callback', {@loopAssociation});
uicontrol(figResults,'String','Save and Quit','Position', [150 20 150 20],'Callback', {@saveAndStop});
pcshow(pcU,'MarkerSize',150);
hold on; 
pointCloudPoint = pcU.Location;
pointCloudPoint = pointCloudPoint';
% r(1,58) = 1;
% r(2,58) = 0;
% r(3,58) = 0;
for i=(numberBalls+1):totalMarkers
    selectedPoint = pointCloudPoint(:, i);
    plot3(selectedPoint(1,:), selectedPoint(2,:), selectedPoint(3,:), ...
        'Color', [r(i,1), r(i,2), r(i,3)] , 'MarkerSize', 20, 'Marker', '*'); 
%     plot3(selectedPoint(1,:), selectedPoint(2,:), selectedPoint(3,:), ...
%         'Color', [1, 0, 0] , 'MarkerSize', 20, 'Marker', '*'); 

end
figure('Name','GT');
pcshow(pcGT,'MarkerSize',150);
hold on; 
pointCloudPoint = pcGT.Location;
pointCloudPoint = pointCloudPoint';
for i=(numberBalls+1):totalMarkers
    selectedPoint = pointCloudPoint(:,i);
    plot3(selectedPoint(1,:), selectedPoint(2,:), selectedPoint(3,:), ...
        'Color', [r(i,1), r(i,2), r(i,3)] , 'MarkerSize', 20, 'Marker', '*'); 
end

end

