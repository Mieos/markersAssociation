%% Markers association example test

mexOCVpath = '/home/rmodrzejewski/Install/mexopencv';
pointsPath_GT='/media/rmodrzejewski/656B654224A0D697/Pig_Balls_Exp/05/markers.yml';
pointsPath_Used='/media/rmodrzejewski/656B654224A0D697/Pig_Balls_Exp/08/markers.yml';
resultPath = '/media/rmodrzejewski/656B654224A0D697/Pig_Balls_Exp/08/results/associations_with05.yml';
resultPLYPath = '/media/rmodrzejewski/656B654224A0D697/Pig_Balls_Exp/08/results/associations_with05_U.ply';
resultPLYPathGT = '/media/rmodrzejewski/656B654224A0D697/Pig_Balls_Exp/08/results/associations_with05_GT.ply';

associateMarkers(mexOCVpath, pointsPath_GT, pointsPath_Used, resultPath, resultPLYPath , resultPLYPathGT);