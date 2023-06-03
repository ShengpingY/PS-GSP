% Nonlinear model of the glucose seperation process
[f,h] = nonLinear_Gsp();

% Equalibrium point
x_eq = [1 15 70];

% Linearization of the nonlinear process
% ∆x/∆t = A*∆x + B*∆u
% ∆y = C*∆x + D*∆u
[A,B,C,D,u_eq] = linear_Gsp(f,h,x_eq,u_eq);
