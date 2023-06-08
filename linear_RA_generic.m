%------------- BEGIN CODE --------------

clear all


% System Dynamics ---------------------------------------------------------

[f,h] = nonLinear_Gsp();
x_eq = [1 15 70];   %set equilibrium point
[A,B,C,D,u_eq] = linear_Gsp(f,h,x_eq);

Sys = linearSys('linearizedSys',A,B);
%for generic version
% [f,h] = nonLinear();
% x_eq = [1 15 70];   %set equilibrium point
% [A,B,C,D,u_eq] = linear(f,h,x_eq);
% 
% Sys = linearSys('linearizedSys',A,B);


% Parameters --------------------------------------------------------------

params.tFinal = 0.3;


%constraints set for u1[0,2m]
%constraints set for u2[0,2n]
%constraints set for u3[0,2l]
m=200; n=2; l=200; 
u_1=m; u_2=n; u_3=l;

%  0 < x1 < 2
%  0 < x2 < 50
%  0 < x3 < 100
params.R0 = zonotope([1; 25; 50]-x_eq.', zeros(3));
%params.R0 = zonotope(interval([0; 10; -20], [0; 10; -20]));

%  0 < u1 < 400
%  0 < u2 < 4
%  0 < u3 < 400
%params.U = zonotope(interval([0; 0; 0], [400; 4; 400]));
params.U = zonotope([m; n; l]-u_eq.',...
                    [m 0 0; 0 n 0; 0 0 l]);



% Reachability Settings ---------------------------------------------------

options.timeStep = 0.01; 
options.taylorTerms = 4;
options.zonotopeOrder = 175; 
% options.linAlg = 'adaptive'; % use adaptive parameter tuning 
% options.error = 0.1;


% Reachability Analysis ---------------------------------------------------

safeSet = specification(zonotope(interval([0; 0; 0]-x_eq.',...
                                          [2; 50; 100]-x_eq.')),...
                                          'safeSet');
tic;
%Rin = reachInner(Sys,params,options);
Rout = reach(Sys,params,options,safeSet);
tComp = toc;
%stepssS = length(R.timeInterval.set);
disp(['computation time of reachable set: ',num2str(tComp)]);

% Fault model -------------------------------------------------------------
%chosse which input is fault

%u1 is fault
    u1=0;
    u_1=u1;
    m=0.0001;

% %u2 is fault
%    u2=0;
%    u_2=u2;
%    n=0.0001;
% 
% %u3 is fault
%     u3=0;
%     u_3=u3;
%     l=0.0001;

fault.tFinal = Rout.timePoint.time{length(Rout.timePoint.time)};
fault.R0 = zonotope([1; 25; 50]-x_eq.', zeros(3));
fault.U = zonotope([u_1; u_2; u_3]-u_eq.',...
                    [m 0 0; 0 n 0; 0 0 l]);

R_u = reach(Sys,fault,options,safeSet);


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

simOpt.points = 50;
simOpt.type = 'gaussian';
simRes = simulateRandom(Sys, fault, simOpt);


% Visualization -----------------------------------------------------------

% plot different projections
dims = {[1 2],[1,3]};

for k = 1:length(dims)

    figure; hold on; box on
    useCORAcolors("CORA:contDynamics")
    projDims = dims{k};

    % plot reachable sets
    %plot(R,projDims, 'DisplayName', 'Reachable set');
    useCORAcolors("CORA:contDynamics", 3)
     
    plot(Rout, projDims, 'DisplayName', sprintf("Reachable set over-approximation"));
    %plot(safeSet,projDims,'DisplayName', sprintf('Safe Set'));

    plot(R_u, projDims, 'DisplayName', sprintf("Reachable set over-approximation if input u is fault")); 

    % plot initial set
    % plot(R.R0,projDims,'DisplayName','Initial set');

    % plot simulation results
    plot(simRes,projDims, 'DisplayName', 'Simulations');

    % label plot
    xlabel(['x_{',num2str(projDims(1)),'}']);
    ylabel(['x_{',num2str(projDims(2)),'}']);
    legend('Location', 'northwest')
end


%------------- END OF CODE --------------