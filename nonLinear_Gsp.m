function [f,h] = nonLinear_Gsp()
p=getparam_Gsp();
syms x1 x2 x3 u1 u2 u3 
f=[p.a1*x3+p.a2*x2-p.b1*u1-p.b2*u2-p.k1;...
-p.a3*x2*u2+p.k2;...
-p.a4*x3-p.a5*x2+p.b3*u1-((p.a6*x3+p.b4)/(p.b5*u3+p.k3))*u3+p.k4
];
h=[x1; x2; x3];
end