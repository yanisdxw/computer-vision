function [X1_ap,X2_ap,n_ap]=appariement(X1,X2,dmin)
    [n1,l1]=size(X1);
    [n2,l2]=size(X2);
    
    X1_ap = X1;
    [n_ap l_ap] = size(X1);
    X2_ap = [];
   
      
    for i = 1:n_ap 
        p_diff = [];
        // matrix of points that includes all the points cloest possible 
        // and their distance to original points. 
        for j = 1:n2 
            dist = distance(X1_ap(i,:),X2(j,:))
            // calcule distance entre point origin and point decalage
            if dist<dmin then 
            // if their distance is les than dmin then add it to matrix p_diff
                p_diff = [p_diff;X2(j,:) dist]
            end
        end
        [X index] = min(p_diff(:,4));//find the point that has least distance to point original. 
        X2_ap(i,:)=p_diff(index,1:3);
    end
endfunction
