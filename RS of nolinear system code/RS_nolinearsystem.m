


%------------- BEGIN CODE --------------

% Parameters --------------------------------------------------------------
%The reachable set in time intervall 0~10s
params1.tFinal = 10;
params2.tFinal = 10;
%initial state point
%Without fault u1(x4). The initial state values(first three state values) must be intervals
 params1.R0 = interval([0.9;24.9;51;100;2;100], [1.1;25.7;52;200;3;200]);
%With fault u1(x4).The initial state values(first three state values) must be intervals
 params2.R0 = interval([0.9;24.9;51;150;2;100], [1.1;25.7;52;150;3;200]);


% Reachability Settings ---------------------------------------------------


% settings for the algorithm from [Projection]
options.algInner = 'proj';
options.timeStep =0.1;
options.taylorOrder = 3;
options.taylmOrder = 10;



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


% compute inner-approximation with the algorithm from [Projection] 
tic
[Rin1,Rout1] = reachInner(sys,params1,options);
tComp = toc;
disp(['Computation time (proj,Without failure): ',num2str(tComp),' s']);

tic
[Rin2,Rout2] = reachInner(sys,params2,options);
tComp = toc;
disp(['Computation time (proj,With failure): ',num2str(tComp),' s']);


% Visualization -----------------------------------------------------------

% plot inner-approximation over time
%Without failure situation
figure; hold on; box on;
hIn1 = plotOverTime(Rin1,1,'Color',CORAcolor("CORA:reachSet", 3, 1));
hIn2 = plotOverTime(Rin1,2,'FaceColor',CORAcolor("CORA:reachSet", 3, 2));
hIn3 = plotOverTime(Rin1,3,'FaceColor',CORAcolor("CORA:reachSet", 3, 3));

xlabel('time');
ylabel('x_1, x_2, x_3');
l = legend([hIn1;hIn2;hIn3],'Inner-approx. without failure (x_1)', ...
                            'Inner-approx. without failure(x_2)',...
                            'Inner-approx. without failure (x_3)');
set(l,'Location','northeast');



%With failure situation
figure; hold on; box on;
hIn4 = plotOverTime(Rin2,1,'Color',CORAcolor("CORA:reachSet", 3, 1));
hIn5 = plotOverTime(Rin2,2,'FaceColor',CORAcolor("CORA:reachSet", 3, 2));
hIn6 = plotOverTime(Rin2,3,'FaceColor',CORAcolor("CORA:reachSet", 3, 3));


xlabel('time');
ylabel('x_1, x_2, x_3');
l = legend([hIn4;hIn5;hIn6],'Inner-approx. with failure (x_1)', ...
                            'Inner-approx. with failure(x_2)',...
                            'Inner-approx. with failure(x_3)');
set(l,'Location','northeast');

%------------- END OF CODE -------------