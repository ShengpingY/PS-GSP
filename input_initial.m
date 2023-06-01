function input = input_inital()
    input{1} = interval([0; 0; 0;],[400; 4; 400]);
    input{2} = interval([0; 0; 0;],[0; 4; 400]);
    input{3} = interval([0; 0; 0;],[400; 0; 400]);
    input{4} = interval([0; 0; 0;],[400; 4; 0]);
    input{5} = interval([0; 0; 0;],[0; 0; 400]);
    input{6} = interval([0; 0; 0;],[400; 0; 0]);
    input{7} = interval([0; 0; 0;],[0; 4; 0]);
%     for u1 = 0:400
%         input{u1} = interval([u1; 0; 0;],[u1; 4; 400]);
%     end
end