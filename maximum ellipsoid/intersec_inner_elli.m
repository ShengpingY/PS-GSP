function ZE_new = intersec_inner_elli(ZE,Z1,Z2,varargin)
%   persistent ZE;
    % convert zonotope Z2 to halfspace representation
    
    P1 = mptPolytope(Z1);
    P2 = mptPolytope(Z2);
    
    P1 = P1 & P2;
    A = P1.P.A;
    b = P1.P.b;
    m = size(A,1);
    n = size(A,2);
    tic
    cvx_begin
        variable B(n,n) symmetric
        variable d(n)
        maximize( det_rootn( B ) )
        subject to
           for i = 1:m
               norm( B*A(i,:)', 2 ) + A(i,:)*d <= b(i);
           end
    cvx_end
    toc
    if isempty(ZE)
        c = eye(m);
        [U_,S_,V_] = svd(c);
        Q_ = U_ * (S_.*S_)* U_';
        E_ = ellipsoid(Q_,d);
        ZE = zonotope(E_,32,'inner:norm');
    end
    EE = B * ZE; 
    new_g = EE.Z(:,2:end);
    ZE_new = zonotope(d,new_g);
    

%     % svd method
%     [U,S,V] = svd(B);
%     Q = U * (S.*S)* U';
%     E = ellipsoid(Q,d);
%     ZE_new = zonotope(E,32,'inner:norm');
end