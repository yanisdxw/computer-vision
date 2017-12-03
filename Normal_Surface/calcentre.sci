function G = cal_cent(X)
    //calcul du barycentre G
    G = ones(1,3);
    [m,n] = size(X);
    for i=1:n 
        G(i) = sum(X(:,i))/m;
    end
endfunction
