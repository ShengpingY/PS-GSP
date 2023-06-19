function dx = nonLinear_Gsp_onlyfornolinear(x,u)
p=getparam_Gsp();
% syms x1 x2 x3 u1 u2 u3 
dx(1,1)=p.a1*x(3)+p.a2*x(2)-p.b1*u(1)-p.b2*u(2)-p.k1;
dx(2,1)=-p.a3*x(2)*u(2)+p.k2;
dx(3,1)=-p.a4*x(3)-p.a5*x(2)+p.b3*u(1)-((p.a6*x(3)+p.b4)/(p.b5*u(3)+p.k3))*u(3)+p.k4;
% dx=[p.a1*x(3)+p.a2*x(2)-p.b1*u(1)-p.b2*u(2)-p.k1;...
% -p.a3*x(2)*u(2)+p.k2;...
% -p.a4*x(3)-p.a5*x(2)+p.b3*u(1)-((p.a6*x(3)+p.b4)/(p.b5*u(3)+p.k3))*u(3)+p.k4
% ];
end
