function Rin = reachInnerConstrained(sys,params,options,safeSet)
% reachInner - compute an inner-approximation of the reachable set
%
% Syntax:  
%    Rin = reachInner(sys,params,options)
%
% Inputs:
%    sys - nonlinearSys object
%    params - parameter defining the reachability problem
%    options - struct containing the algorithm settings
%
% Outputs:
%    Rin - object of class reachSet storing the inner-approximation of the 
%          reachable set
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: nonlinearSys/reachInner

% Author:       Niklas Kochdumper
% Written:      27-August-2020
% Last update:  ---
% Last revision:---

%------------- BEGIN CODE --------------
    

    %initialize unitball in zonotope form for intersect
    ZE = readfun;
    figure("Name",'x1-x2');
    % options preprocessing
    mfilename = 'reachInner';
    options = validateOptions(sys,mfilename,params,options);
    %initialize for strips
    C = eye(3);
    phi = [1; 25; 50];
    y = [0; 10; -20];
  
    CC = [1 0 0;-1 0 0;0 1 0;0 -1 0;0 0 1;0 0 -1];
%     safe_poly = mptPolytope(CC,[1;1;35;15;30;70]);



    % define set of inputs
    V_ = sys.B * (options.U + options.u);
    
    if ~isempty(sys.c)
       V_ = V_ + sys.c; 
    end
    
    % compute propagation matrices
    n = sys.dim;
    A_ = [sys.A eye(n); zeros(n,2*n)];
     
    eAt_ = expm(A_*options.timeStep);
    
    eAt = eAt_(1:n,1:n);
    T = eAt_(1:n,n+1:end);

    % initialization
    t = options.tStart:options.timeStep:options.tFinal;
    set = cell(length(t),1);
    set{1} = options.R0;
    % set{1} = mptPolytope(set{1});
    % loop over all time steps
    for i = 2:length(t)
        
        % time varying input
        if isfield(options,'u') && size(options.u,2) > 1
           V = V_ + options.u(:,i-1); 
        else
           V = V_; 
        end
        
        % set propagation
        set{i} = eAt * set{i-1} + T * V;
        
        % order reduction
        % set{i} = reduceUnderApprox(set{i},options.reductionTechniqueUnderApprox, ...
        %                           options.zonotopeOrder);

        % restriction to safe set
        temp = set{i};
        %ellipsoid method
        set{i} = intersec_inner_elli(ZE,temp,safeSet);
        %visualization of propogation result
        figure(1);
        subplot(2,1,1);
        plot(set{i},[1 2],'r');hold on;
        if i == 2
            plot(safeSet,[1 2],'g');hold on;
        end
        subplot(2,1,2);
        plot(set{i},[1 3],'r');hold on;
        if i == 2
            plot(safeSet,[1 3],'g');hold on;
        end

%         % Strip method
%         % set{i} = and_(set{i}, safeSet.set,'averaging');
%         temp = set{i};
%         % set{i} = and_(set{i}, safe_poly,'averaging'); 
% 
%         % set{i} = set{i} & safe_poly;
%         set{i} = intersectStrip(set{i},C,phi,y);
%         set{i} = shrink(set{i},0.95);
%         subplot(2,1,1);
%         plot(set{i},[1 2],'g');
%         hold on;
%         plot(safe_poly,[1 2],'r');
%         hold on;
%         plot(temp,[1 2],'b');
%         hold on;
%         subplot(2,1,2);
%         plot(set{i},[1 3],'g');
%         hold on;
%         plot(safe_poly,[1 3],'r');
%         hold on;
%         plot(temp,[1 3],'b');
%         hold on;


    end
    
    % compute output set
    timePoint.set = compOutputSet(sys,set,V_,options);
    timePoint.time = num2cell(t');
    
    % construct reachSet object
    Rin = reachSet(timePoint);
    
end

% Auxiliary Functions -----------------------------------------------------

function set = compOutputSet(sys,set,V_,options)
% compute the output set from the reachable set

    % check if output is not the identity
    if ~isscalar(sys.C) || sys.C ~= 1 || ~isempty(sys.k) || ~isempty(sys.D)

        % construct output equation
        if any(any(sys.D)) && any(sys.k)
            f = @(x,u) sys.C * x + sys.D*u + sys.k;
        elseif any(any(sys.D)) && ~any(sys.k)
            f = @(x,u) sys.C * x + sys.D*u;
        else
            f = @(x,u) sys.C * x + sys.k;
        end
        
        % compute output set for all time steps
        for i = 2:length(set)
            if isfield(options,'u') 
                if size(options.u,2) > 1
                    V = V_ + options.u(:,i-1); 
                else
                    V = V_ + options.u; 
                end
            else
                V = V_; 
            end
            set{i} = f(set{i},V);
        end
    end
end
%------------- auxilary function -------------
function z = readfun
    %avoid variables conflict
    load 'unit ball zonotope 32 generators.mat'
    z = ZE;
end
%------------- END OF CODE -------------