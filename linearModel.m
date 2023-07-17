[f,h]=nonLinear_Gsp();
x_eq=[1 15 70];
[A,B,C,D,u_eq1]=linear_Gsp(f,h,x_eq);
X_0=[1;25;50];
u1=[0 400];
u2=[0 4];
u3=[0 400];
u_eq1=double(u_eq1);
[num,dem] = ss2tf(A, B, C, D,3);
Y=sim('nonlinear_Modell.slx');
X=Y.yout{1}.Values;
x1=X.Data(:,1);
X1lin=X.Data(:,4);
t=Y.tout;
subplot(3,1,1)
plot(t,x1,t,X1lin,'--',LineWidth=2)
xlabel('zeit in sek')
ylabel('h in m')
legend('h','hlin')
grid on
subplot(3,1,2)
x2=X.Data(:,2);
X2lin=X.Data(:,5);
plot(t,x2,t,X2lin,'--',LineWidth=2)
xlabel('zeit in sek')
ylabel('Kp in %')
legend('kp','kplin')
grid on
subplot(3,1,3)
x3=X.Data(:,3);
X3lin=X.Data(:,6);
plot(t,x3,t,X3lin,'--',LineWidth=2)
xlabel('zeit in sek')
ylabel('pe in Kpa')
legend('pe','pelin')
grid on
r=zeros(length(x1));
for i=1:length(X1lin)
    r(i)=abs(X1lin(i)-x1(i));
end
figure
plot(t,r,LineWidth=2)
grid on
