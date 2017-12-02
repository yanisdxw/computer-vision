X1 = read('foot.asc',-1,3);
X2 = read('foot_perturbed.asc',-1,3);
X3 = read('foot.asc',-1,3);
X4 = read('foot_perturbed.asc',-1,3);

X1=decimation(X1, 20)
X2=decimation(X2, 20)


dmin = 10000; //distacne minimal
N_iter = 5;// number of iteration
err_li = []
iter_li = []

R1 = [];
T1 = [];
Tf = eye(4,4);

for i=1:N_iter
     
    //matching the points
    [X1_ap,X2_ap,n_ap]=appariement(X1,X2,dmin);
    //calcul matrix transform R and T
    [R,T]=transf(X1_ap,X2_ap);
    //apply the tranformation to points origin
    X2 = tf_RT(X2,R,T);
    //calcul error between X1 and X2
    err=evolution(R,T,X1,X2)
    
    disp(err)
    err_li($+1)=err
    iter_li($+1)=i
    
    //calcul transformation total
    R1(:,:,i) = R;
    T1(:,i) = T;
    Tf = Tf*[R1(:,:,i) T1(:,i);0 0 0 1]
    
end

R = Tf(1:3,1:3);// matrix rotation
T = Tf(1:3,4);// vector translation
X4 = tf_RT(X4,R,T);

h1 = figure(1)
param3d1(X3(:,1), X3(:,2), list(X3(:,3), -4));
param3d1(X4(:,1), X4(:,2), list(X4(:,3), -4));
h2 = figure(2)
plot(iter_li,err_li)

