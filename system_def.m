function sys = system_def()
%% this function is for all system parameter
    sys = struct;
    [sys.f, sys.h] = nonLinear_Gsp();
    X_eq = equilibrium();
    sys.x_eq =  X_eq(1,1:3)
    [sys.A,sys.B,sys.C,sys.D,sys.u_eq] = linear_Gsp(sys.f,sys.h,sys.x_eq);
    sys.constraint_x = [2;50;100];
    sys.constraint_u = [400;4;400];


    %initialize the analysis mode
    %there are three modes: "outerapproximation","innerapproximation","Ellipsoid_innerapproximation"
    sys.mode = "outerapproximation";
    sys.simtime = 4; % initialize simulation time
    sys.timestep = 0.1; % initialize time step for each discrete interal

    
end

    