function [c, ceq] = nonlcon(x,u)

if nargin==1
    u=x(4:6);
    x=x(1:3);
end

p=getparam_Gsp();
c=[];
ceq=[p.a1*x(3)+p.a2*x(2)-p.b1*u(1)-p.b2*(u(2)+p.K*x(1))-p.k1;...
-p.a3*x(2)*(u(2)+p.K*x(1))+p.k2;...
-p.a4*x(3)-p.a5*x(2)+p.b3*u(1)-((p.a6*x(3)+p.b4)/(p.b5*u(3)+p.k3))*u(3)+p.k4
];
end