


%------------- BEGIN CODE --------------

% Parameters --------------------------------------------------------------
%The reachable set in time intervall 0~1s
params.tFinal = 10;
%initial state point
% params.R0 = interval([1;25;45;100;1;200], [2;29;50;200;2;200]);
% params.R0 = interval([0.75;24.5;49.5;100;2;50], [1.25;25.5;50.5;100;3;50]);%With
% % fault u1(x4)
 params.R0 = interval([0.75;24.5;49.5;10;2;10], [1.25;25.5;50.5;400;3;400]);%Without fault u1(x4)
% Reachability Settings ---------------------------------------------------


% settings for the algorithm from [2]
options2.algInner = 'proj';
options2.timeStep =2;
options2.taylorOrder = 3;
options2.taylmOrder = 10;



% System Dynamics ---------------------------------------------------------
p=getparam_Gsp();
%The new system
GSP = @(x,u) [p.a1*x(3)+p.a2*x(2)-p.b1*x(4)-p.b2*(x(5)+p.K*x(1))-p.k1;
                      -p.a3*x(2)*x(5)+p.k2;
                      -p.a4*x(3)-p.a5*x(2)+p.b3*x(4)-((p.a6*x(3)+p.b4)/(p.b5*x(6)+p.k3))*x(6)+p.k4;
                      0;
                      0;
                      0];
%The orignal system
% GSP = @(x,u) [p.a1*x(3)+p.a2*x(2)-p.b1*x(4)-p.b2*x(5)-p.k1;
%                       -p.a3*x(2)*x(5)+p.k2;
%                       -p.a4*x(3)-p.a5*x(2)+p.b3*x(4)-((p.a6*x(3)+p.b4)/(p.b5*x(6)+p.k3))*x(6)+p.k4;
%                       0;
%                       0;
%                       0];



sys = nonlinearSys(GSP);

% Reachability Analysis ---------------------------------------------------


% compute inner-approximation with the algorithm from [2] 
tic
[Rin2,Rout2] = reachInner(sys,params,options2);
tComp = toc;
disp(['Computation time (proj): ',num2str(tComp),' s']);


% Visualization -----------------------------------------------------------

% plot inner-approximation over time
figure; hold on; box on;
% plotOverTime(Rout2,1,'Color',CORAcolor("CORA:reachSet", 2, 1));
% hOut1 = plotOverTime(Rout2,2,'Color',CORAcolor("CORA:reachSet", 2, 1));
% hOut2 = plotOverTime(Rout2,3,'Color',CORAcolor("CORA:reachSet", 2, 1));
hIn1 = plotOverTime(Rin2,1,'Color',CORAcolor("CORA:reachSet", 3, 1));
hIn2 = plotOverTime(Rin2,2,'FaceColor',CORAcolor("CORA:reachSet", 3, 2));
hIn3 = plotOverTime(Rin2,3,'FaceColor',CORAcolor("CORA:reachSet", 3, 3));





xlabel('time');
ylabel('x_1, x_2, x_3');
l = legend([hIn1;hIn2;hIn3],'Inner-approx. (x_1)', ...
                            'Inner-approx. (x_2)',...
                            'Inner-approx. (x_3)');
set(l,'Location','northeast');

%------------- END OF CODE -------------