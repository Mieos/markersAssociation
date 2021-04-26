function saveAndStop( src, eventData)

% Close all windows
close all;

% Get global vars
global resultPath resultPLYPath resultPLYPathGT; % Paths
global X pUsed pGT r; % Associations, points and color

% Load PC from corresponding matrix
pcU = pointCloud(pUsed(:,X(:))','Color', r);
pcGT = pointCloud(pGT','Color',r);

% Write results
% Association file
save(resultPath,'X');
% Point clouds for visualisation
pcwrite(pcU,resultPLYPath);
pcwrite(pcGT,resultPLYPathGT);

% End
fprintf('Results Saved... Ending...\n');

end

