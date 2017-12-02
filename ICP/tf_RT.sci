function p = tf_RT(pt,R,T)
    p = rotation(pt,R);
    p = translation(p,T)
endfunction
