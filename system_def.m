function sys = system_def()
%% this function is for all system parameter
    sys = struct;
    [sys.f, sys.h] = nonLinear_Gsp();
    sys.x_eq = [1 15 70];
    [sys.A,sys.B,sys.C,sys.D,sys.u_eq] = linear_Gsp(sys.f,sys.h,sys.x_eq);
    sys.constraint_x = [2;50;100];
    sys.constraint_u = [400;4;400];
end

    