//-------------------------------------------
// Draw a line in image according to equation
// x*cos(theta)+y*sin(theta) = rho

function im=drawLine_rho_theta(im,rho,theta)

    // create a color image if it is gray level
    if size(size(im),'c')==2
        img(:,:,3)=im;
        img(:,:,1)=im;
        img(:,:,2)=im;
        im=img;
    end

    sizex=size(im,1);
    sizey=size(im,2);

    if sin(theta) <> 0 then
        for x=1:sizex
            y=floor((rho -x*cos(theta))/sin(theta))+1;
            if (y>0) & (y<sizey)
                im(x,y,:)=[0 255 0 ];
            end
        end
    end

    if cos(theta) <> 0 then
        for y=1:sizey
            x=floor((rho -y*sin(theta))/cos(theta));
            if (x>0) & (x<sizex)
                im(x,y,:)=[0 255 0 ];
            end
        end
    end

endfunction
