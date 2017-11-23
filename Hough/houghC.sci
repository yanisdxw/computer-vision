//--------------------------------------------------------------------------------
// Function to fit a line passing through points in an image using Hough transform
// threshold is used as a minimum value on the accumulator to accept a local max

function houghC(im,rayon,threshold,display)

    // some parameters
    // step of the accumulator for r
    r = rayon;
    theta_step=0.5; // step of the accumulator for theta
    
    // Threshold image
    img=im2bw(im,0.5);

    sizex=size(img,1);
    sizey=size(img,2);
    sizeimg= sizex*sizey;
    sizemax=max(sizex,sizey);

    // Create the accumulator
    // theta from 0 to 360, step theta_step
    // rho from -2*sizemax to 2*sizemax, step rho_step
    size_theta = floor(360/theta_step);
    size_a = floor(sizex+2*r);
    size_b = floor(sizey+2*r);
    acc = zeros (size_a,size_b);


    // Fill the accumulator for each point in image
    for i=1:sizeimg
        if img(i) // if the pixel is not black
            // coordinate of the point in image
            x= modulo(i, sizex);
            y= floor(i/sizex)+1;

            for index_theta=1:size_theta // loop on possible line orientations
                theta = (index_theta-1)*theta_step*%pi/180;
                // compute corresponding centre of cercle(a,b)
                a = x - r*cos(theta);
                b = y - r*sin(theta);
                index_a = floor(a+r);
                index_b = floor(b+r);
                // vote for corresponding line parameters
                acc(index_a,index_b)=acc(index_a,index_b)+1;
            end
        end
    end

    // complement accumulator to be able to search on border rows and columns
    acc_marge = [0 acc(size_a,[size_b:-1:1]) 0 ;zeros(size_a,1) acc zeros(size_a,1);0 acc(1,[size_b:-1:1]) 0];


	if (display)
	max_acc = max(max(acc_marge))/255;
    imshow(uint8(acc_marge/max_acc));
    printf('Displaying accumulator. ');
    halt('Press Return');
	end

    // Begin search for local maxima of the accumulator

    max_val = [];
    ma = [];
    mb = [];

    for i=2:(size_a+1)
        for j=2:(size_b+1)
            // compute max value in the point neighborhood
            neighbors = acc_marge([i-1:i+1],[j-1:j+1]);
            neighbors(2,2) = 0;
            max_neighbors = max(max(neighbors));
            max_neighbors = max(max_neighbors,threshold);

            if acc_marge(i,j) > max_neighbors // if it is a local max
                max_val = [max_val acc_marge(i,j)];
                ma = [ma (i)-r];
                mb = [mb (j+1)-r];
            end
        end
    end
 
    // Sort by decreasing value
    [max_val,perm]=mtlb_sort(max_val,'descend');
    ma=ma(perm);
    mb=mb(perm);

    mprintf("Found %d local maxima above threshold\n",length(ma));
    for nb=1:length(ma)
        printf("a: %f, b: %f, number of pixels: %d \n",ma(nb),mb(nb),max_val(nb));
    end

    if (display)
    // Display lines
    for nb=1:length(ma)

        // display line
        imdisp=drawCercle_a_b(im,ma(nb),mb(nb),r);
        imshow(imdisp);
        printf("Displaying line %d/%d ... ",nb,length(mb));
        halt('Press Return');
    end
	end

endfunction
