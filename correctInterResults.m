%% Correct associations
clear all;
close all;

numTest = "09";
masterPath = "/media/rmodrzejewski/Maxtor/data/metalPigsXP/";

%% Include mex
mexOCVpath = '/home/rmodrzejewski/Install/mexopencv';
contribPath = mexOCVpath + "/opencv_contrib";
contribPath = char(contribPath);
% OpenCV
addpath(mexOCVpath)
addpath(contribPath);

%% Association Init
associationsOf05=masterPath+"targets/05/resultsAssociations/v1/associations.yml";
associationsOf05=char(associationsOf05);
associationsFound=masterPath+"targets/"+numTest+"/results/associations_with05.yml";
associationsFound=char(associationsFound);

%% PC
pointsPath_GT=masterPath+"model/segmentations/ballsAndClips/markers.yml";
pointsPath_GT=char(pointsPath_GT);
pointsPath_Used=masterPath+"targets/"+numTest+"/markers.yml";
pointsPath_Used=char(pointsPath_Used);

%% Path for saving
resultPath = masterPath+"targets/"+numTest+"/resultsAssociations/v1/associations.yml";
resultPath=char(resultPath);

resultPLYPath = masterPath+"targets/"+numTest+"/resultsAssociations/v1/associations_U.ply";
resultPLYPath=char(resultPLYPath);

resultPLYPathGT = masterPath+"targets/"+numTest+"/resultsAssociations/v1/associations_GT.ply";
resultPLYPathGT=char(resultPLYPathGT);

%% Get asso files
asso5 = cv.FileStorage(associationsOf05);
assoF = cv.FileStorage(associationsFound);
asso5Data=asso5.Association;
assoFData=assoF.Association;

%% New asso
%newAsso = asso5Data(assoFData(:));
newAsso = assoFData(asso5Data(:));

%% Points
% Read matrix
p_GT = cv.FileStorage(pointsPath_GT);
p_Used = cv.FileStorage(pointsPath_Used);
ballsGT = p_GT.centroidsBalls;
ballsUsed = p_Used.centroidsBalls;
clipsGT = p_GT.centroidsClips;
clipsUsed = p_Used.centroidsClips;
pGT = horzcat(ballsGT,clipsGT);
pUsed = horzcat(ballsUsed,clipsUsed);

%% Color
r = randi([0 255],60,3,'uint8');

pcU = pointCloud(pUsed(:,newAsso(:))','Color', r);
pcGT = pointCloud(pGT','Color',r);

S = struct('Association',newAsso);
cv.FileStorage(resultPath,S);
% Point clouds for visualisation
pcwrite(pcU,resultPLYPath);
pcwrite(pcGT,resultPLYPathGT);