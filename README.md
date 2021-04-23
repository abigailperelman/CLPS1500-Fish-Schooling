# CLPS1500-Fish-Schooling
This is a simulation of fish schooling as a demonstration of self-organization. It is established using parameters based on Huth & Wissel (1992).

## Individual files
schoolSimulation.m is the main file needed to run the code. 
initializeVariables.m initializes the conditions for the simulation.
neighborDistanceAngle.m calculates the distances and relative angle of orientation between each fish and their neighbors.
frontPriority.m, sidePriority.m, and distancePriority.m are the three different priority methods that can be tested in this simulation. To switch the one being used, appropriately comment and uncomment lines 52-54 in schoolSimulation.m.



## Running the simulation
To run, type "schoolSimulation" into the Matlab command window and press enter. Make sure this file and all subfunction scripts are in the same location. A figure should appear and fish will begin to swim. After a certain number of iterations, you will be prompted in the command window whether you want to continue or quit. Press "y" and hit enter if you would like to see the simulation again. Press "n" and hit enter if you would like to stop; the figure will close automatically.
