function X_ech=decimation(X, k_ech)
// Fonction downsampling facteur k_ech
[n,l]=size(X)
n_ech=int(n/k_ech)
X_ech=zeros(n_ech,l);
for i = 1:n_ech
    X_ech(i,:)=X(i*k_ech,:);
end
endfunction
//
//X=read('bunny.asc',-1,3);
//[n,l]=size(X)
//X_ech=decimation(X,10)
//write('bunny_ech.asc',X_ech);
//figure(1);
//clf
//param3d1(X_ech(:,1), X_ech(:,2), list(X_ech(:,3), -4));
