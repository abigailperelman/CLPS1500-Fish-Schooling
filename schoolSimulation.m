%% Simulation run
% bring in repetedly-initialized variables
initializeVariables;

% single-initialization variables
round = 1;
polarizationAvg = zeros(1, 10);
expanseAvg = zeros(1, 10);    
p = zeros(1, numOfFish);
polarization = zeros(10, 50);
expanse = zeros(10, 50);
    
% run the program
while round <= 10    
    % increment round and slice count
    slice = slice + 1;
    
    % draw fish movements
    fig = figure(1);
    set(fig, 'DoubleBuffer', 'on');
    quiver(mvmnt.posX, mvmnt.posY, cosd(mvmnt.orient), sind(mvmnt.orient), 0)
    set(gca, 'xlim', [0, 100], 'ylim', [0, 100], 'NextPlot', 'replace', 'Visible', 'on')

    % determine neighbor distance and orientation difference
    neighborDistanceAngle;
    
    % fish-neighbor interactions
    % find new orientation angle
    angleDiff = zeros(numOfFish);
    for fish1 = 1:numOfFish
        for fish2 = 1:numOfFish
            deltaTheta = mvmnt.orient(fish2) - mvmnt.orient(fish1);
            
            % in repulsion area
            if distanceDirect(fish1, fish2) < radiusRepulsion
                add90 = wrapTo180(deltaTheta + 90);
                minus90 = wrapTo180(deltaTheta - 90);
                % choose the smaller angle
                if abs(add90) < abs(minus90)
                    angleDiff(fish1, fish2) = add90;
                else
                    angleDiff(fish1, fish2) = minus90;
                end
                
            % in parallel orientation area
            elseif distanceDirect(fish1, fish2) >= radiusRepulsion && distanceDirect(fish1, fish2) < radiusParallel
                angleDiff(fish1, fish2) = wrapTo180(deltaTheta);
                
            % in attraction area
            elseif distanceDirect(fish1, fish2) >= radiusParallel && distanceDirect(fish1, fish2) < radiusAttraction
                angleDiff(fish1, fish2) = wrapTo180(distanceAngle(fish1, fish2) - mvmnt.orient(fish1));
            
            % in searching area
            else
                angleDiff(fish1, fish2) = wrapTo180(randi([-180 180]));
            end
        end
    end

    % use priority rules to determine fish of influence
    frontPriority;
    %sidePriority;
    %distancePriority;
    
    % generate new x and y coordinates
    mvmnt.posX = mvmnt.posX + timeStep * mvmnt.velX;
    mvmnt.posY = mvmnt.posY + timeStep * mvmnt.velY;   
    
    % calculate polarization and expanse
    polarizationAndExpanse;
    
    % check if user wants to continue with the simulation
    if mod(slice, 50) == 0
        % update polarization and expanse graphs
        polarizationAvg(round) = mean(polarization(round,:));
        expanseAvg(round) = mean(expanse(round, :));
        
        % draw polarization and expanse
        figure(2);
        subplot(2,1,1);
        plot(1:round, polarizationAvg(1:round), 1:round, polarizationAvg(1:round), 'o');
        title('Polarization per Round');
        xlim([1 10]);   % by round
        ylim([0 90]);   % by angle
        
        subplot(2,1,2);
        plot(1:round, expanseAvg(1:round), 1:round, expanseAvg(1:round), 'o');
        title('Expanse per Round');
        xlim([1 10]);       
        
        response = input('Would you like to continue with the simulation? Type "y" or "n". \n', 's');
        if response == 'n'
            close all;
            break;
        end
        % bring in initialized variables
        initializeVariables;
        round = round + 1;
    end
end