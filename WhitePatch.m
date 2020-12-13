function [I] = WhitePatch(im)
    I = im;
    
    %White Patch algorithm
    R = I(:, :, 1);
    G = I(:, :, 2);
    B = I(:, :, 3);
    
    Rmax = max(max(I(:, :, 1)));
    Gmax = max(max(I(:, :, 2)));
    Bmax = max(max(I(:, :, 3)));
    
    alpha = Gmax/Rmax;
    beta = Gmax/Bmax;
    
    R = R.*alpha;
    G = G;
    B = B.*beta;
    
    I = cat(3,R,G,B);
      
end


