function set_limit = boundary_of_zonotope(set)
        timesteps = size(set);
        for i = 1:timesteps
            Temp = set(i);
            Z = Temp{1,1}.Z;
            x_dis = sum(Z(:,2:end),2);
            set_limit.x1.lower{i} = min(Z(1,1)+x_dis(1),Z(1,1)-x_dis(1));
            set_limit.x1.upper{i} = max(Z(1,1)+x_dis(1),Z(1,1)-x_dis(1));
            set_limit.x2.lower{i} = min(Z(2,1)+x_dis(2),Z(2,1)-x_dis(2));
            set_limit.x2.upper{i} = max(Z(2,1)+x_dis(2),Z(2,1)-x_dis(2));
            set_limit.x3.lower{i} = min(Z(3,1)+x_dis(3),Z(3,1)-x_dis(3));
            set_limit.x3.upper{i} = max(Z(3,1)+x_dis(3),Z(3,1)-x_dis(3));
%             set_interval.x1{i} = interval(Z(1,1)+x_dis(1),Z(1,1)-x_dis(1));
%             set_interval.x2{i} = interval(Z(2,1)+x_dis(2),Z(2,1)-x_dis(2));
%             set_interval.x3{i} = interval(Z(3,1)+x_dis(3),Z(3,1)-x_dis(3));
%             inter{i} = interval([Z(1,1)+x_dis(1) Z(2,1)+x_dis(2) Z(3,1)+x_dis(3)], ...
%                              [Z(1,1)-x_dis(1) Z(2,1)-x_dis(2) Z(3,1)-x_dis(3)]);
        end
end

        