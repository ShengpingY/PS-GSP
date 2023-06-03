function [A,B,C,D,u_eq] = linear_Gsp(f,h,x_eq)
syms x1 x2 x3 u1 u2 u3
x = [x1 x2 x3];
u = [u1 u2 u3];

A = jacobian(f,x);
B = jacobian(f,u);
C = jacobian(h,x);
D = jacobian(h,u);

u_ap = (subs(f,x,x_eq));
u_eq = solve(u_ap,u);
u1e = u_eq.u1;
u2e = u_eq.u2;
u3e = u_eq.u3;
u_eq = [u1e u2e u3e];

A = double(subs(A,[x,u],[x_eq,u_eq]));
B = double(subs(B,[x,u],[x_eq,u_eq]));
C = double(subs(C,[x,u],[x_eq,u_eq]));
D = double(subs(D,[x,u],[x_eq,u_eq]));
u_eq = double(u_eq);
end