%% Initializations

% number of fish
numOfFish = 8; 
bodyLength = 1;

% orientation
mvmnt.orient = 360 * rand(1, numOfFish);

% position (x and y coordinate)
mvmnt.posX = 100/2 + 8 * rand(1,numOfFish);
mvmnt.posY = 100/2 + 8 * rand(1,numOfFish);

% speed
mvmnt.velTot = gamrnd(4, 1/3.3, 1, numOfFish);
mvmnt.velX = mvmnt.velTot .* cosd(mvmnt.orient);
mvmnt.velY = mvmnt.velTot .* sind(mvmnt.orient);

% number of neighbors that influence an individual
numNeighbors = 4;

% time step
timeStep = 0.5;

% radial distances and angles for each type of behavior
radiusRepulsion = 0.5 * bodyLength;
radiusParallel = 10 * bodyLength;
radiusAttraction = 20 * bodyLength;
omega = 30;      % dead angle

% number of rounds and slices 
slice = 0;

