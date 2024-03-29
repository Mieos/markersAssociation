function associateMarkers(pointsPath_inside_GT, pointsPath_outside_GT, pointsPath_inside_Tested, pointsPath_outside_Tested, resultPathIN, resultPLYPathIN , resultPLYPathGTIN)

%Utils
addpath('utils');
% Graph Matching
addpath('graphMatchingSMAC');
% Init others paths
init;

% Define results paths as global
global resultPath resultPLYPath resultPLYPathGT;
resultPath = resultPathIN;
resultPLYPath = resultPLYPathIN;
resultPLYPathGT = resultPLYPathGTIN;

% Vars
global epsilon sigma;
epsilon = 0.01;
sigma = 5.0;
neighbors = 5;

% Read matrix
ballsGT_c = load(pointsPath_inside_GT);
ballsGT = ballsGT_c.M;
ballsUsed_c = load(pointsPath_inside_Tested);
ballsUsed = ballsUsed_c.M;
clipsGT_c = load(pointsPath_outside_GT);
clipsGT = clipsGT_c.M;
clipsUsed_c = load(pointsPath_outside_Tested);
clipsUsed = clipsUsed_c.M;

% Concatenate points
global pGT pUsed;
pGT = horzcat(ballsGT,clipsGT);
pUsed = horzcat(ballsUsed,clipsUsed);

% Get number of points
[~,size_y_gt] = size(pGT);
[~,size_y_used] = size(pUsed);
global nP1 nP2;
nP1=size_y_gt;
nP2=size_y_used;
[~,inter1y]=size(ballsUsed);
[~,inter2y]=size(clipsUsed);
global numberBalls numberClips totalMarkers;
numberBalls=inter1y;
numberClips=inter2y;
totalMarkers = numberBalls+numberClips;

% Get random color points
global r;
r = randi([0 255],nP1,3,'uint8');

% Correspondaces
global correspondances;
correspondances = [];

% Init
global X;
X = 1:nP1;

% Compute everything that can be compute first

% KNN
global KnnGT;
global KnnUsed;
KnnGT = knnsearch(pGT',pGT','K', neighbors);
KnnUsed = knnsearch(pUsed',pUsed','K', neighbors);

% Def P1 and P2
P1 = pGT';
P2 = pUsed';

% Euclidian distances
E1 = ones(nP1); E2 = ones(nP2);
[L1all(:,1) L1all(:,2)] = find(E1);
[L2all(:,1) L2all(:,2)] = find(E2);
global euc1;
global euc2;
euc1 = P1(L1all(:,1),:,:)-P1(L1all(:,2),:,:);
euc2 = P2(L2all(:,1),:,:)-P2(L2all(:,2),:,:);
euc1 = sqrt(euc1(:,1).^2+euc1(:,2).^2+euc1(:,3).^2);
euc2 = sqrt(euc2(:,1).^2+euc2(:,2).^2+euc2(:,3).^2);
euc1 = reshape(euc1, [nP1 nP1]);
euc2 = reshape(euc2, [nP2 nP2]);

% Global IDs
global pointCloudIndex_GT pointCloudIndex_Used;
pointCloudIndex_GT =-1;
pointCloudIndex_Used =-1;

% Init PC
pcUinit = pointCloud(pUsed(:,X(:))','Color', r);
pcGTinit = pointCloud(pGT','Color',r);

% Start
clickA3DPoint(pcGTinit,1);
clickA3DPoint(pcUinit,2);

end

