function loopAssociation( src, eventData)

close all;

global pGT;
global pUsed;
global X;
global r;

pcUinit = pointCloud(pUsed(:,X(:))','Color', r);
pcGTinit = pointCloud(pGT','Color',r);

%% Click Points
clickA3DPoint(pcGTinit,1);
clickA3DPoint(pcUinit,2);
 
end

