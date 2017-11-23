// HOMOGRAPHY2D - computes 2D homography
//
// Usage:   H = homography2d(x1, x2)

//
// Arguments:
//          x1  - 3xN set of homogeneous points
//          x2  - 3xN set of homogeneous points such that x1<->x2
//
// Returns:
//          H - the 3x3 homography such that x2 = H*x1
//
// This code follows the normalised direct linear transformation
// algorithm given by Hartley and Zisserman "Multiple View Geometry in
// Computer Vision" p92.
//

// Peter Kovesi
// School of Computer Science & Software Engineering
// The University of Western Australia
// pk at csse uwa edu au
// http://www.csse.uwa.edu.au/~pk
//
// May 2003  - Original version.
// Feb 2004  - Single argument allowed for to enable use with RANSAC.
// Feb 2005  - SVD changed to 'Economy' decomposition (thanks to Paul O'Leary)

function H = homography2d(x1,x2)

    // Attempt to normalise each set of points so that the origin
    // is at centroid and mean distance from origin is sqrt(2).
    [x1, T1] = normalise2dpts(x1);
    [x2, T2] = normalise2dpts(x2);

    // Note that it may have not been possible to normalise
    // the points if one was at infinity so the following does not
    // assume that scale parameter w = 1.

    A=[];

    // TODO : Create matrix A
    for i=1:size(x1,2)
        A=[A;zeros(1,3) -x2(3,i)*x1(:,i)' x2(2,i)*x1(:,i)';x2(3,i)*x1(:,i)' zeros(1,3) -x2(1,i)*x1(:,i)' ]

    end
    
 
    // TODO : Perform SVD
    
    [U,S,V]=svd(A)

    // TODO : Extract homography from SVD result
    
    h=V(:,size(V,2));
    H=[h(1:3)';h(4:6)';h(7:9)']

    // Denormalise
    H= T2\H*T1;

endfunction
