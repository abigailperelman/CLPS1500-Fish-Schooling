%% Find fish of influence based on angular distance to the front of the selected fish

% find neighbors of influence
neighborsTotal = zeros(numOfFish);  
    
% sort a matrix by closest fish side angle -- row = fish, column = ranking, values = indices
for fish = 1:numOfFish
    [~, neighborsTotal(fish, :)] = mink(abs(distanceAngle(fish, :)), numOfFish);
end

% remove first column, fish doesn't count itself
neighborsTotal(:, 1) = [];

    
% select fish of influence
for fish = 1:numOfFish
    neighborsOfInfluence = [];
    for neighbor = 1:numOfFish-1
        fishNum = neighborsTotal(fish, neighbor);
        
        % make sure all (max of numNeighbors) not in dead or searching zones
        if length(neighborsOfInfluence) < numNeighbors && distanceDirect(fish, fishNum) <= radiusAttraction ...
                && abs(distanceAngle(fish, fishNum)) < (180 - omega)
            neighborsOfInfluence = [neighborsOfInfluence fishNum];
        end        
    end
    
    % if a least one influencing neighbor is sensed, add randomness
    % no neighbors
    if isempty(neighborsOfInfluence)
        avgAngleChange = wrapTo180(360 * rand);
        mvmnt.orient(fish) = wrapTo180(mvmnt.orient(fish) + avgAngleChange);
        mvmnt.velTot(fish) = gamrnd(4, 1/3.3, 1, 1);
        mvmnt.velX(fish) = mvmnt.velTot(fish) .* cosd(mvmnt.orient(fish));
        mvmnt.velY(fish) = mvmnt.velTot(fish) .* sind(mvmnt.orient(fish)); 
    % 1+ neighbor
    else
        avgAngleChange = wrapTo180(sum(angleDiff(fish,neighborsOfInfluence))/length(neighborsOfInfluence));
        avgAngleChange = avgAngleChange + 15 * randn(1);
        mvmnt.orient(fish) = wrapTo180(mvmnt.orient(fish) + avgAngleChange);
        avgVelTot = mean(mvmnt.velTot(neighborsOfInfluence));
        sd = 0.2;
        mvmnt.velTot(fish) = avgVelTot + sd * randn(1);
        mvmnt.velX(fish) = mvmnt.velTot(fish) .* cosd(mvmnt.orient(fish));
        mvmnt.velY(fish) = mvmnt.velTot(fish) .* sind(mvmnt.orient(fish));
    end
end