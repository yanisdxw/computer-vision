function [R,T]=transf(X1_ap,X2_ap)
    [n,l]=size(X1_ap);
    p1_m = [];
    p1_m = [sum(X1_ap(:,1))/n,sum(X1_ap(:,2))/n,sum(X1_ap(:,3))/n];
    // find the central point p1_m
    p2_m = [];
    p2_m = [sum(X2_ap(:,1))/n,sum(X2_ap(:,2))/n,sum(X2_ap(:,3))/n];
    // find the central point p2_m
    
    //find points translate around theirs centre
    for i=1:n 
        q1(i,:) = X1_ap(i,:)-p1_m;
        q2(i,:) = X2_ap(i,:)-p2_m;
    end
    
    // calcul matrix H
    H = [];
    for i=1:n 
        H = H + q1(i,:)'*q2(i,:)
    end
    
    // ues singular-value decomposition to find rotation and translation 
    [U S V] = svd(H);
    R = V*U';
    T = p1_m' - R*p2_m';
    
endfunction
