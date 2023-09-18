
%Comparison between CORA and simulation result
%%%%%%%%%%%%%%
%Plot x1
%%%%%%%%%%%%%%
figure; hold on; box on;
subplot(2,2,1);
hIn1 = plotOverTime(Rin1,1,'Color',CORAcolor("CORA:reachSet", 3, 3));
xlabel('time [s]');
ylabel('x_1');
%l = legend([hIn1],'Inner-approx. (x_1)');
load('Simulationresult.mat')
hold on; 
for idx = 4:4:512
    q = data{1,idx}.yout{1}.Values;
        
   
    time = q.Time;
    
    data1 = q.Data(:, 1);
        
  
    plot(time, data1, 'b');
    xlim([0 10]);
    ylim([0 3]);
%     scatter1 = scatter(hIn1,data1,'MarkerFaceColor','r','MarkerEdgeColor','k')
%     scatter1.MarkerFaceAlpha= .2

    %legend('Inner-approx. (x_1)');

end



%%%%%%%%%%%%%%
%Plot x2
%%%%%%%%%%%%%%

subplot(2,2,2);
hIn1 = plotOverTime(Rin1,2,'Color',CORAcolor("CORA:reachSet", 3, 3));
xlabel('time [s]');
ylabel('x_2');
%l = legend([hIn1],'Inner-approx. (x_2)');
load('Simulationresult.mat')
hold on; 
for idx = 4:4:512
    q = data{1,idx}.yout{1}.Values; 



   
    time = q.Time;
   
    
    data2 = q.Data(:, 2);
    xlim([0 10]);
    ylim([15 30]);


    plot(time, data2, 'b');

    %legend('Inner-approx. (x_2)');

end



%%%%%%%%%%%%%%
%Plot x3
%%%%%%%%%%%%%%


subplot(2,2,[3,4]);
hIn1 = plotOverTime(Rin1,3,'Color',CORAcolor("CORA:reachSet", 3, 3));
xlabel('time [s]');
ylabel('x_3');
%l = legend([hIn1],'Inner-approx. (x_3)');
load('Simulationresult.mat')
hold on; 
for idx = 4:4:512
    q = data{1,idx}.yout{1}.Values; 
    
  
    time = q.Time;

    data3 = q.Data(:, 3);

  
    plot(time, data3, 'b');
    xlim([0 10]);
    ylim([40 60]);
    %legend('Inner-approx. (x_3)');
    
end