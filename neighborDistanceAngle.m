%% Find distance and orientation difference

% initialize matrices to store distance and angle between fish
distanceX = zeros(numOfFish);
distanceY = zeros(numOfFish);
distanceDirect = zeros(numOfFish);
distanceAngle = zeros(numOfFish);

% find distance and angle between fish
for fish1 = 1:numOfFish
    for fish2 = 1:numOfFish
        distanceX(fish1, fish2) = mvmnt.posX(fish1) - mvmnt.posX(fish2);
        distanceY(fish1, fish2) = mvmnt.posY(fish1) - mvmnt.posY(fish2);
        distanceDirect(fish1, fish2) = sqrt(distanceX(fish1, fish2)^2 + distanceY(fish1, fish2)^2);
        distanceAngle(fish1, fish2) = wrapTo180(rad2deg(atan2(distanceY(fish1, fish2), distanceX(fish1, fish2))));
    end
end