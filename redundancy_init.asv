function combination = redundancy_init(sys)
%% this function produce all possible redundancies
    constraint_u = sys.constraint_u;
    combination = struct;
    
    %% single redundancy, u1,u2,u3 stands for generator
    %u1 redundant
    u1 = [0.001:constraint_u(1)/20:constraint_u(1)];
    u2 = [constraint_u(2)/2];
    u3 = [constraint_u(3)/2];
    [u1,u2,u3] = ndgrid(u1,u2,u3);
    A = [u1(:) u2 u3];

    %u2 redundant
    u1 = [constraint_u(1)/2];
    u2 = [0.001:constraint_u(2)/20:constraint_u(2)];
    u3 = [constraint_u(3)/2];
    [u1,u2,u3] = ndgrid(u1,u2,u3);
    B = [u1(:) u2(:) u3(:)];

    %u3 redundant
    u1 = [constraint_u(1)/2];
    u2 = [constraint_u(2)/2];
    u3 = [0.001:constraint_u(3)/20:constraint_u(3)];
    [u1,u2,u3] = ndgrid(u1,u2,u3);
    C = [u1(:) u2(:) u3(:)];

    combination.single = [A;B;C];

    %% double redundancy
    %u1u2 redundant
    u1 = [0.001:constraint_u(1)/20:constraint_u(1)];
    u2 = [0.001:constraint_u(2)/20:constraint_u(2)];
    u3 = [constraint_u(3)/2];
    [u1,u2,u3] = ndgrid(u1,u2,u3);
    A2 = [u1(:) u2(:) u3(:)];

    %u1u3 redundant
    u1 = [0.001:constraint_u(1)/20:constraint_u(1)];
    u2 = [constraint_u(2)/2];
    u3 = [0.001:constraint_u(3)/20:constraint_u(3)];
    [u1,u2,u3] = ndgrid(u1,u2,u3);
    B2 = [u1(:) u2(:) u3(:)];

    %u1u2 redundant
    u1 = [constraint_u(1)/2];
    u2 = [0.001:constraint_u(2)/20:constraint_u(2)];
    u3 = [0.001:constraint_u(3)/20:constraint_u(3)];
    [u1,u2,u3] = ndgrid(u1,u2,u3);
    C2 = [u1(:) u2(:) u3(:)];
    combination.double = [A2;B2;C2];

    %% all inputs redundant
    u1 = [0.001:constraint_u(1)/20:constraint_u(1)];
    u2 = [0.001:constraint_u(2)/20:constraint_u(2)];
    u3 = [0.001:constraint_u(3)/20:constraint_u(3)];
    [u1,u2,u3] = ndgrid(u1,u2,u3);
    combination.triple=[u1(:) u2(:) u3(:)];
end