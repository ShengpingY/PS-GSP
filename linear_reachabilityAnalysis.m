
%------------- BEGIN CODE --------------

clear all;


% System Dynamics ---------------------------------------------------------

[f,h] = nonLinear_Gsp();
x_eq = [1 15 70];
[A,B,C,D,u_eq] = linear_Gsp(f,h,x_eq);

Sys = linearSys('linearizedSys',A,B);


% Parameters --------------------------------------------------------------

params.tFinal = 300;

%  0 < x1 < 2
%  0 < x2 < 50
%  0 < x3 < 100
params.R0 = zonotope([1-x_eq(1); 25-x_eq(2); 50-x_eq(3)], zeros(3));
%params.R0 = zonotope(interval([0; 10; -20], [0; 10; -20]));

%  0 < u1 < 400
%  0 < u2 < 4
%  0 < u3 < 400
%params.U = zonotope(interval([0; 0; 0], [400; 4; 400]));
params.U = zonotope([200-u_eq(1); 2-u_eq(2); 200-u_eq(3)],...
                    [200 0 0; 0 2 0; 0 0 200]);


% Reachability Settings ---------------------------------------------------

options.timeStep = 1; 
options.taylorTerms = 4;
options.zonotopeOrder = 50; 
%options.linAlg = 'wrapping-free';
% options.error = 0.1;


% Reachability Analysis ---------------------------------------------------

safeSet = zonotope(interval([0-x_eq(1); 0-x_eq(2); 0-x_eq(3)],...
                            [2-x_eq(1); 50-x_eq(2); 100-x_eq(3)]));
tic
Rin = reachInnerConstrained(Sys,params,options,safeSet);
%Rout = reach(Sys,params,options);
tComp = toc;
%stepssS = length(R.timeInterval.set);
disp(['computation time of reachable set: ',num2str(tComp)]);

% Fault model -------------------------------------------------------------

% u1 = 0;
% fault1.tFinal = Rin.timePoint.time{length(Rin.timePoint.time)};
% fault1.R0 = zonotope([1-x_eq(1); 25-x_eq(2); 50-x_eq(3)], zeros(3));
% fault1.U = zonotope([u1-u_eq(1); 2-u_eq(2); 200-u_eq(3)],...
%                     [0.0001 0 0; 0 2 0; 0 0 200]);
% 
% u2 = 0;
% fault2.tFinal = Rin.timePoint.time{length(Rin.timePoint.time)};
% fault2.R0 = zonotope([1-x_eq(1); 25-x_eq(2); 50-x_eq(3)], zeros(3));
% fault2.U = zonotope([200-u_eq(1); u2-u_eq(2); 200-u_eq(3)],...
%                     [200 0 0; 0 0.0001 0; 0 0 200]);
% 
% u3 = 0;
% fault3.tFinal = Rin.timePoint.time{length(Rin.timePoint.time)};
% fault3.R0 = zonotope([1-x_eq(1); 25-x_eq(2); 50-x_eq(3)], zeros(3));
% fault3.U = zonotope([200-u_eq(1); 2-u_eq(2); u3-u_eq(3)],...
%                     [200 0 0; 0 2 0; 0 0 0.0001]);

% 
% R_u1 = reachInnerConstrained(Sys,fault1,options,safeSet);
% R_u2 = reachInnerConstrained(Sys,fault2,options,safeSet);
% R_u3 = reachInnerConstrained(Sys,fault3,options,safeSet);

% Rfault = [R_u1, R_u2, R_u3];

% Redundancy Analysis------------------------------------------------------

% R_red = reachSet;
% R_red.timePoint.time = R.timePoint.time;
% R_red.timePoint.error = R.timePoint.error;
% R_red.timeInterval.time = R.timeInterval.time;
% R_red.timeInterval.error = R.timeInterval.error;

% for i = 1:stepssS
% 
%     R_red.timePoint.set{i,1} = R.timePoint.set{i} & R_u1.timePoint.set{i};
%     R_red.timeInterval.set{i,1} = R.timeInterval.set{i} & R_u1.timeInterval.set{i};
% 
% end


% Simulation --------------------------------------------------------------

simOpt.points = 10;
simOpt.type = 'gaussian';

simRes = simulateRandom(Sys, params, simOpt);
% simResF1 = simulateRandom(Sys, fault1, simOpt);
% simResF2 = simulateRandom(Sys, fault2, simOpt);
% simResF3 = simulateRandom(Sys, fault3, simOpt);

% simResF = [simResF1, simResF2, simResF3];

% Visualization -----------------------------------------------------------

% plot different projections
dims = {[1 2],[1,3]};
%dims = {[1 2 3]};

for k = 1:length(dims)

    figure; hold on; box on
    useCORAcolors("CORA:contDynamics")
    projDims = dims{k};

    % plot reachable sets
    %plot(R,projDims, 'DisplayName', 'Reachable set');
    useCORAcolors("CORA:contDynamics")

    %plot(Rout, projDims, 'DisplayName', sprintf("Reachable set over-approximation")); 
    plot(Rin, projDims, 'DisplayName', sprintf("Reachable set inner-approximation")); 
    plot(safeSet,projDims,'DisplayName', sprintf('Safe Set'));

    % plot(R_u1, projDims, 'DisplayName', sprintf("u1 = 0"));
    % plot(R_u2, projDims, 'DisplayName', sprintf("u2 = 0")); 
    % plot(R_u3, projDims, 'DisplayName', sprintf("u3 = 0")); 

    % plot initial set
    plot(Rin.R0,projDims,'DisplayName','Initial set');

    % plot simulation results
    %plot(simRes,projDims, 'DisplayName', 'Simulations');
    % plot(simResF,projDims, 'DisplayName', 'Simulations with fault');

    % label plot
    xlabel(['x_{',num2str(projDims(1)),'}']);
    ylabel(['x_{',num2str(projDims(2)),'}']);

    legend('Location', 'northwest')
end

% for l = 1:3
% 
%     figure; hold on; box on
%     useCORAcolors("CORA:contDynamics")
% 
%     plotOverTime(Rout, l, 'DisplayName', sprintf("Reachable set"));
%     plotOverTime(simRes,l, 'DisplayName', 'Simulations');
%     % plotOverTime(R_u1, l, 'DisplayName', sprintf("u1 = 0"));
%     % plotOverTime(R_u2, l, 'DisplayName', sprintf("u2 = 0"));
%     % plotOverTime(R_u3, l, 'DisplayName', sprintf("u3 = 0"));
% 
%     % label plot
%     xlabel(['t']);
%     ylabel(['x_{',num2str(l),'}']);
% 
%     legend('Location', 'northwest')

% end


%------------- END OF CODE --------------