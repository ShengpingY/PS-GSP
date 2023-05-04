function res = gsp_linear_reach_01()
% example_linear_reach_01_5dim - example of linear reachability analysis
%   with uncertain inputs, can be found in [1, Sec. 3.2.3].
%
% Syntax:  
%    res = example_linear_reach_01_5dim()
%
% Inputs:
%    -
%
% Outputs:
%    res - true/false 
%
% References:
%    [1] M. Althoff, “Reachability analysis and its application to the 
%        safety assessment of autonomous cars", Dissertation, TUM 2010

% Author:       Matthias Althoff
% Written:      17-August-2016
% Last update:  23-April-2020 (restructure params/options)
% Last revision:---

%------------- BEGIN CODE --------------

% Parameters --------------------------------------------------------------

params.tFinal = 5;
params.R0 = zonotope([[1; 25; 50],0.1*diag(ones(3,1))]);
params.U = zonotope(interval([0; 0; 0], ...
                             [400; 4; 400]));


% Reachability Settings ---------------------------------------------------

options.timeStep = 0.02; 
options.taylorTerms = 4;
options.zonotopeOrder = 20; 


% System Dynamics ---------------------------------------------------------

[f,h]=nonLinear_Gsp();
x_eq=[1 15 70];
[A,B,C,D]=linear_Gsp(f,h,x_eq);


fiveDimSys = linearSys('threeDimSys',A,B);


% Reachability Analysis ---------------------------------------------------

tic
R = reach(fiveDimSys, params, options);
tComp = toc;

disp(['computation time of reachable set: ',num2str(tComp)]);


% Simulation --------------------------------------------------------------

simOpt.points = 25;
simOpt.type = 'gaussian';

simRes = simulateRandom(fiveDimSys, params, simOpt);


% Visualization -----------------------------------------------------------

% plot different projections
dims = {[1 2],[2 3]};

for k = 1:length(dims)

    figure; hold on; box on
    useCORAcolors("CORA:contDynamics")
    projDims = dims{k};

    % plot reachable sets
    plot(R,projDims, 'DisplayName', 'Reachable set');

    % plot initial set
    plot(R.R0,projDims,'DisplayName','Initial set');

    % plot simulation results
    plot(simRes,projDims, 'DisplayName', 'Simulations');

    % label plot
    xlabel(['x_{',num2str(projDims(1)),'}']);
    ylabel(['x_{',num2str(projDims(2)),'}']);
    legend('Location', 'northwest')
end

% example completed
res = true;

%------------- END OF CODE --------------