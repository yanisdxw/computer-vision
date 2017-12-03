function [X_extr, nvect_extr, d_extr]=extraction_plan(X, p, delta)
    [m,n] = size(X);
    vote = 0;
    for i=1:p
        [nvect, d]=plane_3pts(X);
         new_vote = vote_plane(X, nvect, d, delta);
         if vote<=new_vote then
             vote = new_vote;
             nvect_extr = nvect;
             d_extr = d;
         end         
    end
    j = 1;
    for i=1:m
        if abs(nvect_extr*X(i,:)'-d_extr)<delta then
            X_extr(j,:)=X(i,:);
            j = j+1;
        end
    end
    
    figure(1);
    clf ; // efface la figure précédente
    param3d1(X_extr(:,1), X_extr(:,2), list(X_extr(:,3), -4));
endfunction
