function result = l1minimization(A,y,S)
    m = size(A,1);
    n = size(A,2);
    %options = optimset('Display','none');
    %X = linprog([zeros(n,1);ones(m,1)],[+A,-eye(m);-A,-eye(m)],[y;-y]);
    X = linprog([zeros(n,1);ones(n,1)],[eye(n),-eye(n);-eye(n),-eye(n)],zeros(2*n,1),[A zeros(m,n)],y);
    result = X(1:n,1);
end