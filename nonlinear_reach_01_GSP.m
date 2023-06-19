function completed = nonlinear_reach_01_GSP

%------------- BEGIN CODE --------------

% Parameters --------------------------------------------------------------

params.tFinal =1;%The reachable set in time intervall 0~1s
%initial state point
% params.R0 = zonotope([[1; 25; 50],[1 0 0;0 25 0;0 0 50]]);
params.R0 = zonotope(interval([1; 25; 50],[1; 25; 50]));


%input Intervall
% params.U = zonotope([[200; 2; 200],[200 0 0;0 2 0;0 0 200]]);%constaint set of u
params.U = zonotope(interval([0; 0; 0], [400; 4; 400]));


% Reachability Settings ---------------------------------------------------

options.timeStep = 1;
options.taylorTerms = 4;
options.zonotopeOrder = 50;
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
%safeset of state
safeSet = specification(zonotope(interval([0; 0; 0],...
                                          [2; 50; 100])),...
                                          'safeSet');

tic
R = reach(sys, params, options,safeSet);
tComp = toc;
disp(['computation time of reachable set: ',num2str(tComp)]);



% Simulation --------------------------------------------------------------

simOpt.points = 60;
simRes = simulateRandom(sys, params, simOpt);


% Visualization -----------------------------------------------------------

dims = {[1 2],[1 3]};

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
