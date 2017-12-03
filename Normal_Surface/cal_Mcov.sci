function Mcov = cal_Mcov(X)
    //cqlcul la matrice de covariance
    [m,n] = size(X);
    G = cal_cent(X);
    Mcov_ = [];
    for i=1:m
        Mcov_ = Mcov_ + (X(i,:)-G(:)')'*(X(i,:)-G(:)');  
    end
    Mcov = Mcov_/m;
endfunction
