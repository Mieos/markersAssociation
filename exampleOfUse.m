%% Markers association example test

clear all;
close all;

numTest = "10";
masterPath = "/media/rmodrzejewski/656B654224A0D697/Pig_Balls_Exp/";

mexOCVpath = '/home/rmodrzejewski/Install/mexopencv';

pointsPath_GT=masterPath+"05/markers.yml";
pointsPath_GT=char(pointsPath_GT);

pointsPath_Used=masterPath+numTest+"/markers.yml";
pointsPath_Used=char(pointsPath_Used);

resultPath = masterPath+numTest+"/results/associations_with05.yml";
resultPath=char(resultPath);

resultPLYPath = masterPath+numTest+"/results/associations_with05_U.ply";
resultPLYPath=char(resultPLYPath);

resultPLYPathGT = masterPath+numTest+"/results/associations_with05_GT.ply";
resultPLYPathGT=char(resultPLYPathGT);

associateMarkers(mexOCVpath, pointsPath_GT, pointsPath_Used, resultPath, resultPLYPath , resultPLYPathGT);