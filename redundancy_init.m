function combination = redundancy_init(sys,options)
%% this function produce all possible redundancies
    constraint_u = sys.constraint_u;
    combination = struct;
    u_eq = sys.u_eq;
    u0 = [constraint_u(1)/2-u_eq(1); constraint_u(2)/2-u_eq(2); constraint_u(3)/2-u_eq(3)];
    if options == "linear"
        %% single redundancy
        %u1 redundant
        ugen = [0.0001,constraint_u(2)/2,constraint_u(3)/2];
        u0_1 = [0,constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = u0(2);
        u0_3 = u0(3);
        [u0_1,u0_2,u0_3] = ndgrid(u0_1,u0_2,u0_3);
        A = [u0_1(:) u0_2 u0_3];
        B = repmat(ugen,size(A,1),1);
        result1_1 = [A B];

        %u2 redundant
        ugen(1) = [constraint_u(1)/2];
        ugen(2) = [0.0001];
        ugen(3) = [constraint_u(3)/2];
        u0_1 = u0(1);
        u0_2 = [0,constraint_u(2)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = u0(3);
        [u0_2,u0_1,u0_3] = ndgrid(u0_2,u0_1,u0_3);
        A = [u0_1 u0_2(:) u0_3];
        B = repmat(ugen,size(A,1),1);
        result1_2 = [A B];
    
        %u3 redundant
        ugen(1) = [constraint_u(1)/2];
        ugen(2) = [constraint_u(2)/2];
        ugen(3) = [0.0001];
        u0_1 = u0(1);
        u0_2 = u0(2);
        u0_3 = [0,constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_3,u0_2,u0_1] = ndgrid(u0_3,u0_2,u0_1);
        A = [u0_1 u0_2 u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result1_3 = [A B];
    
        combination.single = [result1_1;result1_2;result1_3];

        %% double redundancy
        %u1u2 redundant
        ugen(1) = [0.0001];
        ugen(2) = [0.0001];
        ugen(3) = [constraint_u(3)/2];
        u0_1 = [0,constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = [0,constraint_u(2)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = u0(3);
        [u0_1,u0_2,u0_3] = ndgrid(u0_1,u0_2,u0_3);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result2_1 = [A B];
    
        %u1u3 redundant
        ugen(1) = [0.0001];
        ugen(2) = [constraint_u(2)/2];
        ugen(3) = [0.0001];
        u0_1 = [0,constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = u0(3);
        u0_3 = [0,constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_1,u0_3,u0_2] = ndgrid(u0_1,u0_3,u0_2);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result2_2 = [A B];
    
    
        %u2u3 redundant
        ugen(1) = [constraint_u(1)/2];
        ugen(2) = [0.0001];
        ugen(3) = [0.0001];
        u0_1 = u0(1);
        u0_2 = [0,constraint_u(1)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = [0,constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_2,u0_3,u0_1] = ndgrid(u0_2,u0_3,u0_1);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result2_3 = [A B];
    
    
        combination.double = [result2_1;result2_2;result2_3];
    
        %% all inputs redundant
        ugen(1) = [0.0001];
        ugen(2) = [0.0001];
        ugen(3) = [0.0001];
        u0_1 = [0,constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = [0,constraint_u(2)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = [0,constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_1,u0_2,u0_3] = ndgrid(u0_1,u0_2,u0_3);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result3 = [A B];
    
        combination.triple=result3;



    elseif options == "nonlinear"
        %% single redundancy, ugen stands for generator,u0_1/2/3 stands for center
        %u1 redundant
        ugen(1) = [0];
        ugen(2) = [constraint_u(2)/2];
        ugen(3) = [constraint_u(3)/2];
        u0_1 = [0.001:constraint_u(1)/20:constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = u0(2);
        u0_3 = u0(3);
        [u0_1,u0_2,u0_3] = ndgrid(u0_1,u0_2,u0_3);
        A = [u0_1(:) u0_2 u0_3];
        B = repmat(ugen,size(A,1),1);
        result1_1 = [A B];
    
    
        %u2 redundant
        ugen(1) = [constraint_u(1)/2];
        ugen(2) = [0];
        ugen(3) = [constraint_u(3)/2];
        u0_1 = u0(1);
        u0_2 = [0.001:constraint_u(2)/20:constraint_u(2)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = u0(3);
        [u0_2,u0_1,u0_3] = ndgrid(u0_2,u0_1,u0_3);
        A = [u0_1 u0_2(:) u0_3];
        B = repmat(ugen,size(A,1),1);
        result1_2 = [A B];
    
        %u3 redundant
        ugen(1) = [constraint_u(1)/2];
        ugen(2) = [constraint_u(2)/2];
        ugen(3) = [0];
        u0_1 = u0(1);
        u0_2 = u0(2);
        u0_3 = [0.001:constraint_u(3)/20:constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_3,u0_2,u0_1] = ndgrid(u0_3,u0_2,u0_1);
        A = [u0_1 u0_2 u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result1_3 = [A B];
    
        combination.single = [result1_1;result1_2;result1_3];
    
        %% double redundancy
        %u1u2 redundant
        ugen(1) = [0];
        ugen(2) = [0];
        ugen(3) = [constraint_u(3)/2];
        u0_1 = [0.001:constraint_u(1)/20:constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = [0.001:constraint_u(2)/20:constraint_u(2)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = u0(3);
        [u0_1,u0_2,u0_3] = ndgrid(u0_1,u0_2,u0_3);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result2_1 = [A B];
    
        %u1u3 redundant
        ugen(1) = [0];
        ugen(2) = [constraint_u(2)/2];
        ugen(3) = [0];
        u0_1 = [0.001:constraint_u(1)/20:constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = u0(3);
        u0_3 = [0.001:constraint_u(3)/20:constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_1,u0_3,u0_2] = ndgrid(u0_1,u0_3,u0_2);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result2_2 = [A B];
    
    
        %u2u3 redundant
        ugen(1) = [constraint_u(1)/2];
        ugen(2) = [0];
        ugen(3) = [0];
        u0_1 = u0(1);
        u0_2 = [0.001:constraint_u(1)/20:constraint_u(1)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = [0.001:constraint_u(3)/20:constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_2,u0_3,u0_1] = ndgrid(u0_2,u0_3,u0_1);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result2_3 = [A B];
    
    
        combination.double = [result2_1;result2_2;result2_3];
    
        %% all inputs redundant
        ugen(1) = [0];
        ugen(2) = [0];
        ugen(3) = [0];
        u0_1 = [0.001:constraint_u(1)/20:constraint_u(1)];
        u0_1 = u0_1 - u_eq(1);
        u0_2 = [0.001:constraint_u(2)/20:constraint_u(2)];
        u0_2 = u0_2 - u_eq(2);
        u0_3 = [0.001:constraint_u(3)/20:constraint_u(3)];
        u0_3 = u0_3 - u_eq(3);
        [u0_1,u0_2,u0_3] = ndgrid(u0_1,u0_2,u0_3);
        A = [u0_1(:) u0_2(:) u0_3(:)];
        B = repmat(ugen,size(A,1),1);
        result3 = [A B];
    
        combination.triple=result3;
    else
        fprintf("\nPlease input the system type, linear or nonlinear\n")
end