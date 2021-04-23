%% Calculate polarization and expanse

% based on analysis in Huth & Wissel (1992)
    % polarization: arithmetic average of the angle deviation of each fish to he mean swimming
        % direction of the fish group
    % expanse: average of the distances quadratic from every fish to the fish group's center of mass

    
% overview of analysis
    % 10° < polarization_value < 20° for high polarization
    % as polarization_value decreases, polarization increases

    % expanse ~= 1 if fish group stays together
    % expanse > 1 if fish group disperses 

% polarization -- use dot product: v•u = |v||u|cos(angle)
meanDirect = [sum(mvmnt.velX) sum(mvmnt.velY)];
for fish = 1:numOfFish
    mdHypotenuse = norm(meanDirect);
    fishVect = [mvmnt.velX(fish) mvmnt.velY(fish)];
    fishHypotenuse = norm([mvmnt.velX(fish) mvmnt.velY(fish)]);
    p(fish) = acosd(dot(meanDirect, fishVect)/(mdHypotenuse * fishHypotenuse));
end
polarization(round, slice) = mean(p);

% expanse
expanse(round, slice) = sqrt(mean(mvmnt.posX - mean(mvmnt.posX)).^2 + mean(mvmnt.posY - mean(mvmnt.posY)).^2);
