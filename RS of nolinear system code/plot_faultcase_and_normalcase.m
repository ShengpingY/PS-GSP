%Comparison between normal case and fault case
%State value x1
figure; box on;
subplot(1,3,1);
hIn1 = plotOverTime(Rin1,1,'Color',CORAcolor("CORA:reachSet", 3, 3));
hold on;
hIn1 = plotOverTime(Rin2,1,'Color',CORAcolor("CORA:reachSet", 3, 2));
xlabel('time');
ylabel('x_1');
l = legend([hIn1,hIn2],'Inner-approx. (x_1)with fault u_1');
       xlim([0 10]);
    ylim([0 5]);
    


%State value x2
subplot(1,3,2);
hold on;box on;
hIn1 = plotOverTime(Rin1,2,'Color',CORAcolor("CORA:reachSet", 3, 3));
hold on;
hIn1 = plotOverTime(Rin2,2,'Color',CORAcolor("CORA:reachSet", 3, 2));
xlabel('time');
ylabel('x_2');
l = legend([hIn1,hIn2],'Inner-approx. (x_2)with fault u_1');
     xlim([0 10]);
    ylim([15 30]);




%State value x3
subplot(1,3,3);
hold on;box on;
hIn1 = plotOverTime(Rin1,3,'Color',CORAcolor("CORA:reachSet", 3, 3));
hold on;
hIn1 = plotOverTime(Rin2,3,'Color',CORAcolor("CORA:reachSet", 3, 2));
xlabel('time');
ylabel('x_3');
l = legend([hIn1,hIn2],'Inner-approx. (x_3)with fault u_1');
   xlim([0 10]);
    ylim([40 60]);