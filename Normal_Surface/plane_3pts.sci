function [nvect, d]=plane_3pts(X)
// Calcul de plan passant par 3 points aléatoires
    [n,l]=size(X)
    G = cal_cent(X);
    i=int(n*rand(1,3))+1
    x(1,:) = X(i(1),:);
    x(2,:) = X(i(2),:);
    x(3,:) = X(i(3),:);
    
    nv = cross(x(2,:)-x(1,:),x(3,:)-x(1,:));
    nvect = nv/norm(nv);
    d = nvect*G';
endfunction
