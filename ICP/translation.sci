function X_trans=translation(X,T)
    
    [n,l]=size(X)
    for i = 1:n
        X_trans(i,:)=X(i,:)+T(:)';
    end
    
endfunction
