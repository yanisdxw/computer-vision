function X_rot=rotation(X,R)
    
    [n,l]=size(X)
    for i = 1:n
        X_rot(i,:)=X(i,:)*R;
    end

endfunction
