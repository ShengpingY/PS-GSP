[f,h] = nonLinear(); %generic form;

% Set equalibrium point
x_eq = [... ... ...];

% Linearization of the nonlinear process
% ∆x/∆t = A*∆x + B*∆u
% ∆y = C*∆x + D*∆u
[A,B,C,D,u_eq] = linear(f,h,x_eq,u_eq);