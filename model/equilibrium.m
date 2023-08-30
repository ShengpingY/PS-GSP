function X_eq = equilibrium()
f=@(x,u)0; %objective function
%p=getparam_Gsp()
%f=@(x,u)[p.a1*x(3)+p.a2*x(2)-p.b1*u(1)-p.b2*(u(2)+p.K*x(1))-p.k1;...
% -p.a3*x(2)*(u(2)+p.K*x(1))+p.k2;...
% -p.a4*x(3)-p.a5*x(2)+p.b3*u(1)-((p.a6*x(3)+p.b4)/(p.b5*u(3)+p.k3))*u(3)+p.k4
% ];
%set of constraints
lbx=[0 0 0];
upx=[2 50 100];
lbu=[0 0 0];
upu=[400 4 400];
lb=[lbx lbu];
ub=[upx,upu];
A=[];
b=[];
Aeq=[];
beq=[];
%initial point
x_0=(lbx+upx)/2;
u_0=(lbu+upu)/2;
xeo=[x_0,u_0];
%find the minimium using fmincon
[X_eq,~] = fmincon(f,xeo,A,b,Aeq,beq,lb,ub,@nonlcon);
end
