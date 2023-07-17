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
    result = struct;



    %% set inputs for constant redundancy
    analyinput = struct;
    analyinput.R0 = zonotope(x0, zeros(3));
    redundancystates = redundancy_init(sys,"linear");
    analyinput.timestep = 6;

    %% Analyze

    % analyze all single redundancies
    num_single = size(redundancystates.single,1);
    input_single = redundancystates.single;
    t_single = tic;
   for i = 1:num_single
        U_generator = diag([input_single(i,4),input_single(i,5),input_single(i,6)]);
        U_center = [input_single(i,1),input_single(i,2),input_single(i,3)];
        U = zonotope(U_center',U_generator);
        [res_single{i}, R_single{i}] = reach_analysis_lin_dis(sys,analyinput,U);
    end
    toc(t_single);
    % with time = 3, 60 loops, total analysis time for single redundancy is 45.27
    % seconds (around 40 seconds)with parallel computing, without visulization

%     % analyze all double redundancies
%     num_double = size(redundancystates.double,1);
%     input_double = redundancystates.double;
%     t_double = tic;
%     parfor i = 1:num_double
%         U_generator = diag([input_double(i,1),input_double(i,2),input_double(i,3)])
%         [res_double{i}, R_double{i}] = reach_analysis_lin_dis(sys,analyinput,U_generator);
%     end
%     toc(t_double);
%     %1200 loops, takes around 800 seconds

    % analyze triple redundancies
%     num_triple = size(redundancystates.triple,1);
%     input_triple = redundancystates.triple;
%     t_triple = tic;
%     parfor i = 1:num_triple
%         U_generator = diag([input_triple(i,1),input_triple(i,2),input_triple(i,3)])
%         [res_triple{i}, R_triple{i}] = reach_analysis_lin_dis(sys,analyinput,U_generator);
%     end
%     toc(t_triple);
    %
    %% To be continued not tested for double and triple redundancy
%     simres = [res_single res_double res_triple];
%     R = [R_single R_double R_triple];

    
    R = R_single;
    timesteps = size(R{1}.timePoint.set,1);
%     bundle ={};
    for i = 1:timesteps
        A = R{1}.timePoint.set(i);
        B = R{2}.timePoint.set(i);
        inter_set(i,1) = A{1,1} & B{1,1};
%         bundle{1} = A{1,1};
%         bundle{2} = B{1,1};
%         res_R(i) = zonoBundle(bundle);
    end
    set_limit_u1l = boundary_of_zonotope(R{1}.timePoint.set);
    set_limit_u1r = boundary_of_zonotope(R{2}.timePoint.set);
    set_limit_inter = boundary_of_zonotope(inter_set);
    plot_interval_overtime(set_limit_inter.x1);
    

%     timerange = size(res_R,1);
%     parfor i = 1:timerange
%         Result{1,i} = zonoBundle(res_R(i,:));
%     end


end






