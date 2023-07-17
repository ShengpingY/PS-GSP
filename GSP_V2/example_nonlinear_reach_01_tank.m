% function completed = example_nonlinear_reach_01_tank
% example_nonlinear_reach_01_tank - example of nonlinear reachability 
%    analysis with conservative linearization
%
% This example can be found in [1, Sec. 3.4.5] or in [2].
%
% Syntax:  
%    completed = example_nonlinear_reach_01_tank()
%
% Inputs:
%    -
%
% Outputs:
%    completed - true/false 
%
% References:
%    [1] M. Althoff, “Reachability analysis and its application to the 
%        safety assessment of autonomous cars", Dissertation, 2010
%    [2] M. Althoff et al. "Reachability analysis of nonlinear systems with 
%        uncertain parameters using conservative linearization", CDC 2008

% Author:       Matthias Althoff
% Written:      18-August-2016
% Last update:  23-April-2020 (restructure params/options)
% Last revision:---

%------------- BEGIN CODE --------------
assignin("base","sys",sys);
x_eq = sys.x_eq;
u_eq = sys.u_eq;
constraint_x = sys.constraint_x;
constraint_u = sys.constraint_u;
% Parameters --------------------------------------------------------------

params.tFinal = 4;
% params.R0 = zonotope([[2; 4; 4; 2; 10; 4],0.2*eye(6)]);
% params.U = zonotope([0,0.005]);
% x0 = [constraint_x(1)/2-x_eq(1); constraint_x(2)/2-x_eq(2); constraint_x(3)/2-x_eq(3)];
% u0 = [constraint_u(1)/2-u_eq(1); constraint_u(2)/2-u_eq(2); constraint_u(3)/2-u_eq(3)];
x0 = [constraint_x(1)/2; constraint_x(2)/2; constraint_x(3)/2];
u0 = [constraint_u(1)/2; constraint_u(2)/2; constraint_u(3)/2];
% params.R0 = zonotope([x0,0*eye(3)]);
params.R0 = zonotope([x0,diag([1,25,50])]);
params.U = zonotope(u0,diag([200,2,200]));


% Reachability Settings ---------------------------------------------------

options.timeStep = 0.01;
options.taylorTerms = 4;
options.zonotopeOrder = 50;
options.alg = 'lin';
options.tensorOrder = 2;

options.lagrangeRem.simplify = 'simplify';


% System Dynamics ---------------------------------------------------------

tank = nonlinearSys(@glucoseSeperationProcess);


% Reachability Analysis ---------------------------------------------------

tic
R = r each(tank, params, options);
tComp = toc;
disp(['computation time of reachable set: ',num2str(tComp)]);


% Simulation --------------------------------------------------------------

simOpt.points = 100;
simRes = simulateRandom(tank, params, simOpt);


% Visualization -----------------------------------------------------------

% dims = {[1 2],[3 4],[5 6]};
dims = {[1 2],[2 3]};

for k = 1:length(dims)
    
    figure; hold on; box on;
    projDim = dims{k};
    
    % plot reachable sets
    useCORAcolors("CORA:contDynamics")
    plot(R,projDim,'DisplayName','Reachable set');
    
    % plot initial set
    plot(R(1).R0,projDim, 'DisplayName','Initial set');
    
    % plot simulation results      
    plot(simRes,projDim,'DisplayName','Simulations');

    % label plot
    xlabel(['x_{',num2str(projDim(1)),'}']);
    ylabel(['x_{',num2str(projDim(2)),'}']);
    legend()
end


% example completed
% completed = true;

%------------- END OF CODE --------------
