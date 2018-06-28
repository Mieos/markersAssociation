%% Markers association example test

clear all;
close all;

numTest = "05";
masterPath = "/media/rmodrzejewski/Maxtor/data/metalPigsXP/";

mexOCVpath = '/home/rmodrzejewski/Install/mexopencv';

pointsPath_GT=masterPath+"model/segmentations/ballsAndClips/markers.yml";
pointsPath_GT=char(pointsPath_GT);

pointsPath_Used=masterPath+"targets/"+numTest+"/markers.yml";
pointsPath_Used=char(pointsPath_Used);

resultPath = masterPath+"targets/"+numTest+"/resultsAssociations/v1/associations.yml";
resultPath=char(resultPath);

resultPLYPath = masterPath+"targets/"+numTest+"/resultsAssociations/v1/associations_U.ply";
resultPLYPath=char(resultPLYPath);

resultPLYPathGT = masterPath+"targets/"+numTest+"/resultsAssociations/v1/associations_GT.ply";
resultPLYPathGT=char(resultPLYPathGT);

associateMarkers(mexOCVpath, pointsPath_GT, pointsPath_Used, resultPath, resultPLYPath , resultPLYPathGT);