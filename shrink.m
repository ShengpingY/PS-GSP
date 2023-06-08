function res = shrink(X,parameter)
    
% C = eye(3);
%    phi = [1; 25; 50];
%    y = [0; 10; -20];

   % Z = zonotope([0; 10; 200],[1 0 0 24; 0 25 0 3; 0 0 50 9]);
   % X = zonotope([0; 10; 100],[1 0 0 ; 0 25 0; 0 0 50]);
   c_offset = (1-parameter) * X.Z(:,1);
   X_offset = zonotope(c_offset,[0 0 0 ; 0 0 0; 0 0 0]);
   XX = parameter * eye(3) * X;
   res = XX + X_offset;
   % res_zono = intersectStrip(Z,C,phi,y);
   % 
   % % just for comparison
   % % CC = [1 0 0;-1 0 0;0 1 0;0 -1 0;0 0 1;0 0 -1];
   % % poly = mptPolytope(CC,[1;1;35;15;30;70]);
   % % Zpoly = Z & poly;
   % 
   % figure('Name','LAst TRy'); hold on 
   % plot(Z,[1 2],'b','DisplayName','zonotope');
   % plot(X,[1 2],'r','DisplayName','safeset');
   % plot(XX,[1 2],'DisplayName','shrink');
   % plot(X_offset,[1 2],'DisplayName','X_offset');
   % plot(res_offset,[1 2],'-','DisplayName','res_offset');
   % % plot(poly,[1 2],'k*','DisplayName','Strips');
   % % plot(Zpoly,[1 2],'r','DisplayName','zono&strip');
   % plot(res_zono,[1 2],'g','DisplayName','zonoStrips');
   % legend();