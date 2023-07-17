function sys = system_def()
%% this function is for all system parameter
    sys = struct;
    [sys.f, sys.h] = nonLinear_Gsp();
    sys.x_eq = [0.9966 25.2981 51.5618];
    [sys.A,sys.B,sys.C,sys.D,sys.u_eq] = linear_Gsp(sys.f,sys.h,sys.x_eq);
    sys.constraint_x = [2;50;100];
    sys.constraint_u = [400;4;400];
end

    