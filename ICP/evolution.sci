function err=evolution(R,T,p1,p2)
    [n,l]=size(p1);
    err = 0;
    for i = 1:n
        //calcul cost fonction by Least squares
        err = err + (norm(p1(i,:) - (p2(i,:)*R+T(:)')))^2;
    end
endfunction
