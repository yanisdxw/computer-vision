//-------------------------------------------
// Draw a line in image according to equation
// (x-a)**2+(y-b)**2=r**2
//x = a + r*cos(theta)
//y = b + r*sin(theta)

function im=drawCercle_a_b(im,a,b,r)
    // create a color image if it is gray level
    if size(size(im),'c')==2
        img(:,:,3)=im;
        img(:,:,1)=im;
        img(:,:,2)=im;
        im=img;
    end

    sizex=size(im,1);
    sizey=size(im,2);
    theta = linspace(0, 2*%pi, 100);
    
    x = a + r*cos(theta);
    y = b + r*sin(theta);
    
    for i=1:size(x,"*")
        if (x(i)>0)&(x(i)<sizex)&(y(i)>0)&(y(i)<sizey)
            im(x(i),y(i),:) = [0 255 0]
        end
    end


endfunction
