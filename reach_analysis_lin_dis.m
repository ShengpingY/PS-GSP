function [x_out, R]= reach_analysis_lin_dis(timestep,A,B,dims,x0,input)
    
    % Parameters --------------------------------------------------------------
    
    params.tFinal = timestep;
%     params.R0 = zonotope([x0',0.1*diag(ones(max(size(x0)),1))]);
    params.R0 = zonotope([x0',0.01*diag([1 50 100])]);
    params.U = zonotope(input);
    
    
    % Reachability Settings ---------------------------------------------------
    
    options.timeStep = timestep/10; 
    options.taylorTerms = 4;
    options.zonotopeOrder = 20; 
    
    
    % System Dynamics ---------------------------------------------------------
    
%     A = [-1 -4 0 0 0; 4 -1 0 0 0; 0 0 -3 1 0; 0 0 -1 -3 0; 0 0 0 0 -2];
%     B = 1;
    
    fiveDimSys = linearSys('fiveDimSys',A,B);
    
    
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
    %dims = {[1 2],[3 4]};
    
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
%         xlim([0 1]);
%         ylim([0 100]);
        xlabel(['x_{',num2str(projDims(1)),'}']);
        ylabel(['x_{',num2str(projDims(2)),'}']);
        legend('Location', 'northwest')
    end

    %Calculate final point
    i = 1;
    x_out = 0;
    for i = 1:25
        x_out = 0 + simRes.x{i,1}(end,:);
    end
    x_out = x_out/25;  
    assignin("base","R",R);
end