function Result = constant_redundancy_lin(sys)
    %This function is used for linear system's constant redundancy failure
    %analysis, which will use result from reach analysis as single analysis
    %and use parallel computing to do multiple reachability analysis and
    %the intersection will also be actuated here.

    %% intialize
    x_eq = sys.x_eq;
    u_eq = sys.u_eq;
    constraint_x = sys.constraint_x;
    constraint_u = sys.constraint_u;
    x0 = [constraint_x(1)/2-x_eq(1); constraint_x(2)/2-x_eq(2); constraint_x(3)/2-x_eq(3)];
    u0 = [constraint_u(1)/2-u_eq(1); constraint_u(2)/2-u_eq(2); constraint_u(3)/2-u_eq(3)];
    Result = struct;



    %% set inputs for constant redundancy
    analyinput = struct;
    analyinput.R0 = zonotope(x0, zeros(3));
    redundancystates = redundancy_init(sys,"linear");
    analyinput.timestep = sys.simtime;
    %% Analyze
    n = max(size(u_eq));% n is dimension of inputs
    for i = 1:(2*n+1)
        u0 = [constraint_u(1)/2-u_eq(1); constraint_u(2)/2-u_eq(2); constraint_u(3)/2-u_eq(3)];
        U_generator = constraint_u/2;
        if i == 2*n+1
            U_generator = constraint_u/2;
            U = zonotope(u0,U_generator);
            [Sim{i}, R{i}] = reach_analysis_lin_dis(sys,analyinput,U);
        elseif mod(i,2) == 1 %lower bound
            U_generator((i+1)/2) = 0;
            u0((i+1)/2) = 0-u_eq((i+1)/2);
            U = zonotope(u0,U_generator);
            [Sim{i}, R{i}] = reach_analysis_lin_dis(sys,analyinput,U);
        elseif mod(i,2) == 0 %upper bound
            U_generator(i/2) = 0;
            u0(i/2) = constraint_u(i/2)-u_eq(i/2);
            U = zonotope(u0,U_generator);
            [Sim{i}, R{i}] = reach_analysis_lin_dis(sys,analyinput,U);
        end
    end
    Result.Sim = Sim;
    Result.R = R;    


%%%% analyze all single constant failure mode%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     num_single = size(redundancystates.single,1);
%     input_single = redundancystates.single;
%     t_single = tic;
%     for i = 1:num_single
%         U_generator = diag([input_single(i,4),input_single(i,5),input_single(i,6)]);
%         U_center = [input_single(i,1),input_single(i,2),input_single(i,3)];
%         U = zonotope(U_center',U_generator);
%         [res_single{i}, R_single{i}] = reach_analysis_lin_dis(sys,analyinput,U);
%     end
%     toc(t_single);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end






