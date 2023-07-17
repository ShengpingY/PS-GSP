function dx = glucoseSeperationProcess(x,u)
% tank6Eq - system dynamics for the tank benchmark (see Sec. VII in [1])
%
% Syntax:  
%    dx = glucoseSeperationProcess(x,u)
%
% Inputs:
%    x - state vector
%    u - input vector
%
% Outputs:
%    dx - time-derivate of the system state
% 
% References:
%    [1] M. Althoff et al. "Reachability analysis of nonlinear systems with 
%        uncertain parameters using conservative linearization", CDC 2008

% Author:        Arsalan Havaie
% Written:       12-June-2023
% Last update:   ---
% Last revision: ---
%------------- BEGIN CODE --------------

    % parameter
    a1 = 0.00751;
    b1 = 0.00192;
    k1 = 0.01061;
    a2 = 0.00418; 
    b2 = 0.05; 
    k2 = 2.5;
    a3 = 0.05; 
    b3 = 0.00959; 
    k3 = 6.84;
    a4 = 0.03755; 
    b4 = 0.1866; 
    k4 = 2.5531;
    a5 = 0.02091;
    a6 = 0.00315;
    b5 = 0.14;

    % differential equations
    dx(1,1) = a1*x(3)+a2*x(2)-b1*u(1)-b2*u(2)-k1-a2*x(1); 
    dx(2,1) = -a3*x(2)*u(2)+k2;          
    dx(3,1) = -a4*x(3)-a5*x(2)+b3*u(1)-((a6*x(3)+b4)/(b5*u(3)+k3))*u(3)+k4;         
    
%------------- END OF CODE --------------