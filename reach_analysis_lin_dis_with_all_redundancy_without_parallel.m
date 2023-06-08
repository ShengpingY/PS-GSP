[f,h]=nonLinear_Gsp();
x0=[1 15 70];
[A,B,C,D]=linear_Gsp(f,h,x0);
input = input_initial();
dims = {[1 2],[1 3]};
s = tic
for redun_situation = 1:7
    timestep = 2;
%     for k =1:1
        [x_out, set] = reach_analysis_lin_dis(timestep,A,B,dims,x0,input{redun_situation})
        x0 = x_out;
        R_zonotope_set{redun_situation} = set.timePoint.set;
%         [A,B,C,D]=linear_Gsp(f,h,x0)
%     end
end
totalt = toc(s);
disp(totalt)