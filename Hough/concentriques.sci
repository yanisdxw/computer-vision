function concentriques(im,threshold,r1,r2)
//判断两个圆是否为同心圆
    [a1 b1] = roughC(im,r1,threshold);
    [a2 b2] = roughC(im,r2,threshold);
    for i=1:size(a1,"*")
        for j=1:size(a2,"*")
            if ((a1(i)-a2(j))^2+(b1(i)-b2(j))^2<err)
                printf("a: %d, b: %d concentriques",a1(1),b1(1))
            end
        end
    end
endfunction
