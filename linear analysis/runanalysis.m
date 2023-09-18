
%%initialize all system parameters and store in sys
sys = system_def;

%%run analysis
Result = constant_redundancy_lin(sys);

%%result visulization 
m = max(size(sys.x_eq));
%there are totally 2*m+1 results, the (2*k)th and (2*k+1)th results are
%repectivly lower bound and upper bound input failure, the final reult is
%analysis result without input failure
for i = 1:(2*m+1)
    figure('Name',['The ',num2str(i),'th input situation']);
    visulizesingle(Result.R{1,i},Result.Sim{1,i},m);
    hold off
end
