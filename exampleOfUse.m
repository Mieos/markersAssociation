%% Markers association example test

clear all;
close all;

%% Master path
masterPath = "/home/mieos/data/v1_2/";

%% Path GT
pointsPath_inside_GT=masterPath+"ref/markers/markers_inside.mat";
pointsPath_inside_GT=char(pointsPath_inside_GT);
pointsPath_outside_GT=masterPath+"ref/markers/markers_outside.mat";
pointsPath_outside_GT=char(pointsPath_outside_GT);

%% Path tested 
pointsPath_inside_Tested=masterPath+"deformed_configs/01/markers_inside.mat";
pointsPath_inside_Tested=char(pointsPath_inside_Tested);
pointsPath_outside_Tested=masterPath+"deformed_configs/01/markers_outside.mat";
pointsPath_outside_Tested=char(pointsPath_outside_Tested);

%% Results path
resultPath = masterPath+"results/associations.mat";
resultPath=char(resultPath);
resultPLYPath = masterPath+"results/associations_U.ply";
resultPLYPath=char(resultPLYPath);
resultPLYPathGT = masterPath+"results/associations_GT.ply";
resultPLYPathGT=char(resultPLYPathGT);

%% Associate the markers
associateMarkers(pointsPath_inside_GT, pointsPath_outside_GT, pointsPath_inside_Tested, pointsPath_outside_Tested, resultPath, resultPLYPath , resultPLYPathGT);