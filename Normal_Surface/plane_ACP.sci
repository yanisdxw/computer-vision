function [nvect, d, res]=plane_ACP(X)
    G = cal_cent(X);
    Mcov = cal_Mcov(X);
    [evals,vp] =spec(Mcov);
    nvect= evals(:,1);
    d = nvect'*G';
    res = vp(:,1);
endfunction
