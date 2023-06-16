function completed = nonlinear_reach_Redundant_GSP

%------------- BEGIN CODE --------------

% Parameters --------------------------------------------------------------


%The reachable set in time intervall 0~1s
params.tFinal =1;

%initial state point
% params.R0 = zonotope([[1; 25; 50],[1 0 0;0 25 0;0 0 50]]);
params.R0 = zonotope(interval([1; 25; 50], [1; 25; 50]));


%input Intervall
% params.U = zonotope([[200; 2; 200],[200 0 0;0 2 0;0 0 200]]);
params.U = zonotope(interval([0; 0; 0], [400; 4; 400]));


% Reachability Settings ---------------------------------------------------

options.timeStep =0.01;
options.taylorTerms = 4;
options.zonotopeOrder = 175;
options.alg = 'lin';
options.tensorOrder = 2;

options.lagrangeRem.simplify = 'simplify';


% System Dynamics ---------------------------------------------------------
%differential equation f(x,u)=dx
% dx = nonLinear_Gsp_onlyfornolinear(x,u);
n=3;
m=3;
sys=nonlinearSys(@nonLinear_Gsp_onlyfornolinear,n,m);%n is number of states   m is number of input

% Reachability Analysis ---------------------------------------------------

safeSet = specification(zonotope(interval([0; 0; 0],...
                                          [2; 50; 100])),...
                                          'safeSet');

tic;
R = reach(sys, params, options);
Rout = reach(sys,params,options,safeSet);
tComp = toc;
disp(['computation time of reachable set: ',num2str(tComp)]);


% Fault model -------------------------------------------------------------

u1 = 0;
fault1.tFinal = Rout.timePoint.time{length(Rout.timePoint.time)};
fault1.R0 = zonotope([1; 25; 50], zeros(3));
fault1.U = zonotope([u1; 2; 200],...
                    [0.0001 0 0; 0 2 0; 0 0 200]);
 
u2 = 0;
fault2.tFinal = Rout.timePoint.time{length(Rout.timePoint.time)};
fault2.R0 = zonotope([1; 25; 50], zeros(3));
fault2.U = zonotope([200; u2; 200],...
                    [200 0 0; 0 0.0001 0; 0 0 200]);

u3 = 0;
fault3.tFinal = Rout.timePoint.time{length(Rout.timePoint.time)};
fault3.R0 = zonotope([1; 25; 50], zeros(3));
fault3.U = zonotope([200; 2; u3],...
                    [200 0 0; 0 2 0; 0 0 0.0001]);


% R_u1 = reach(sys,fault1,options,safeSet);
% R_u2 = reach(sys,fault2,options,safeSet);
R_u3 = reach(sys,fault3,options,safeSet);




% Simulation --------------------------------------------------------------

simOpt.points = 50;
simOpt.type = 'gaussian';

% simRes = simulateRandomsys, params, simOpt);
% simRes = simulateRandom(sys, fault1, simOpt);
% simRes = simulateRandom(sys, fault2, simOpt);
simRes = simulateRandom(sys, fault3, simOpt);


% Visualization -----------------------------------------------------------

dims = {[1 2],[1 3]};

for k = 1:length(dims)
    
    figure; hold on; box on;
    useCORAcolors("CORA:contDynamics")
    projDim = dims{k};
    
    % plot reachable sets
    useCORAcolors("CORA:contDynamics",3)
    % plot(R,projDim,'DisplayName','Reachable set');
    plot(Rout, projDim, 'DisplayName', sprintf("Reachable set over-approximation")); 
    

    % plot(R_u1, projDim, 'DisplayName', sprintf("u1 = 0"));
    % plot(R_u2, projDim, 'DisplayName', sprintf("u2 = 0")); 
    plot(R_u3, projDim, 'DisplayName', sprintf("u3 = 0")); 


    % plot initial set
    %lot(R.R0,projDim, 'DisplayName','Initial set');
    
    % plot simulation results      
    plot(simRes,projDim,'DisplayName','Simulations');

    % label plot
    xlabel(['x_{',num2str(projDim(1)),'}']);
    ylabel(['x_{',num2str(projDim(2)),'}']);
    legend('Location', 'northwest')
end

