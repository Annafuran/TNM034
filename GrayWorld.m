function [I] = GrayWorld(im)
    %I = imread(im);
    I = im;
    
    %Gray world algorithm
    [cols, rows, channels] = size(I);
    Ravg = sum(sum(I(:, :, 1)))/(cols*rows);
    Gavg = sum(sum(I(:, :, 2)))/(cols*rows);
    Bavg = sum(sum(I(:, :, 3)))/(cols*rows);
    
    alpha = Gavg/Ravg;
    beta = Gavg/Bavg;
    
    I(:, :, 1) = alpha*I(:, :, 1);
    I(:, :, 3) = beta*I(:, :, 3);
    
    %imshow(I);
   
end


