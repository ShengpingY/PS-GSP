function visulizesingle(R,Sim,m)
    %this function is just an example of visulization, there are more plot
    %possibilities and choices

    %R is reachable area, Sim is simulation result in CORA, m is dimension
    %of system
    for i = 1:m 
        subplot(m,1,i);
        title(['x_',num2str(i)])
        plotOverTime(R,i);hold on;
        plotOverTime(Sim,i);hold on;
    end
    
end