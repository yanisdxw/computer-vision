//--------------------------------------------------------------------------------
// Function to fit a line passing through points in an image using Hough transform
// threshold is used as a minimum value on the accumulator to accept a local max

function hough(im,threshold,display)

    // some parameters
    theta_step = 0.5; // step of the accumulator for theta
    rho_step= 2; // step of the accumulator for rho

    // Threshold image
    img=im2bw(im,0.5);

    sizex=size(img,1);
    sizey=size(img,2);
    sizeimg= sizex*sizey;
    sizemax=max(sizex,sizey);

    // Create the accumulator
    // theta from 0 to 180, step theta_step
    // rho from -2*sizemax to 2*sizemax, step rho_step
    size_theta = floor(180/theta_step);
    size_rho = floor(4*sizemax/rho_step);
    acc = zeros (size_theta,size_rho);


    // Fill the accumulator for each point in image
    for i=1:sizeimg
        if img(i) // if the pixel is not black
            // coordinate of the point in image
            x= modulo(i, sizex);
            y= floor(i/sizex)+1;

            for index_theta=1:size_theta // loop on possible line orientations
                theta = (index_theta-1)*theta_step*%pi/180;
                // compute corresponding distance to origin (rho)
                rho = x*cos(theta)+y*sin(theta);
                index_rho = floor((size_rho/2 + rho/rho_step));
                // vote for corresponding line parameters
                acc(index_theta,index_rho)=acc(index_theta,index_rho)+1;
            end
        end
    end

    // complement accumulator to be able to search on border rows and columns
    acc_marge = [0 acc(size_theta,[size_rho:-1:1]) 0 ;zeros(size_theta,1) acc zeros(size_theta,1);0 acc(1,[size_rho:-1:1]) 0 ];

	if (display)
	max_acc = max(max(acc_marge))/255;
    imshow(uint8(acc_marge/max_acc));
    printf('Displaying accumulator. ');
    halt('Press Return');
	end

    // Begin search for local maxima of the accumulator

    max_val = [];
    mtheta = [];
    mrho = [];


    for i=2:(size_theta+1)
        for j=2:(size_rho+1)
            // compute max value in the point neighborhood
            neighbors = acc_marge([i-1:i+1],[j-1:j+1]);
            neighbors(2,2) = 0;
            max_neighbors = max(max(neighbors));
            max_neighbors = max(max_neighbors,threshold);

            if acc_marge(i,j) > max_neighbors // if it is a local max
                max_val = [max_val acc_marge(i,j)];
                mtheta = [mtheta (i-2)*theta_step*%pi/180;];
                mrho = [mrho (j-1-size_rho/2)*rho_step];
            end
        end
    end
 
    // Sort by decreasing value
    [max_val,perm]=mtlb_sort(max_val,'descend');
    mtheta=mtheta(perm);
    mrho=mrho(perm);

    mprintf("Found %d local maxima above threshold\n",length(mrho));
    for nb=1:length(mrho)
        printf("rho: %f, theta: %f, number of pixels: %d \n",mrho(nb),mtheta(nb),max_val(nb));
    end

    if (display)
    // Display lines
    for nb=1:length(mrho)

        // display line
        imdisp=drawLine_rho_theta(im,mrho(nb),mtheta(nb));
        imshow(imdisp);
        printf("Displaying line %d/%d ... ",nb,length(mrho));
        halt('Press Return');
    end
	end

endfunction
