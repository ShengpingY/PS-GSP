function [simRes, R]= reach_analysis_lin_dis(sys,input,U)
    
    % Parameters --------------------------------------------------------------
    
    params.tFinal = input.timestep;
    params.R0 = input.R0;
    params.U = U;
    x_eq = sys.x_eq;
    % Reachability Settings ---------------------------------------------------
    
    options.timeStep = 0.01; 
    options.taylorTerms = 4;
    options.zonotopeOrder = 20; 
    % System Dynamics ---------------------------------------------------------
    Sys = linearSys('linearizedSys',sys.A,sys.B);
    
    % Reachability Analysis ---------------------------------------------------
%     safeSet = specification(zonotope(interval([0-x_eq(1); 0-x_eq(2); 0-x_eq(3)],...
%                                           [2-x_eq(1); 50-x_eq(2); 100-x_eq(3)])),...
%                                           'safeSet');
    tic
    R = reach(Sys, params, options);
    tComp = toc;
    disp(['computation time of reachable set: ',num2str(tComp)]);
    
    
    % Simulation --------------------------------------------------------------
    simOpt.points = 25;
    simOpt.type = 'gaussian';
    simRes = simulateRandom(Sys, params, simOpt);


%     %Calculate final point
%     i = 1;
%     x_out = 0;
%     for i = 1:25
%         x_out = 0 + simRes.x{i,1}(end,:);
%     end
%     x_out = x_out/25;  

end