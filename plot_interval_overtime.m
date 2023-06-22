function plot_interval_overtime(set_interval)
% % % this only works for one dimensional intervals
        figure();
        if nargin == 2
            n = max(size(set_interval));
            for i = 1: n
                plot([i*0.01,i*0.01],[set_interval.lower{1,i},set_interval.upper{1,i}],options);
                hold on;
            end
            hold off;
        else
            n = max(size(set_interval.lower));
            for i = 1:1:n
                if isempty(set_interval.lower{1,i})
                    set_interval.lower{1,i} = 0;
                end
                if isempty(set_interval.upper{1,i})
                    set_interval.upper{1,i} = 0;
                end
                plot([i*0.01,i*0.01],[set_interval.lower{1,i},set_interval.upper{1,i}],'b');
                hold on;
            end
            hold off;
        end
end