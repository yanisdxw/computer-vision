function vote = vote_plane(X, nvect, d, delta)
// Nombre de points de X à une distance inférieur à delta du plan
//Ax +By +Cz + D = 0
    [m,n] = size(X);
    nvote = 0;
    for i=1:m
        if abs(nvect*X(i,:)'-d)<delta then
            nvote = nvote+1;
        end
    end
    vote = nvote;
endfunction
