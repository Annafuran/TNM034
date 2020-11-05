%%%%
%In the Matlab environment you will find many valuable functions that 
%you may call in your program. Other program libraries are not allowed. 
%You can use anynumber of functions in your file,but the format of the
%calling function should adhere to the skeleton above.Our testing of 
%your program will be done automatically in a batch run. Therefore your 
%code should not include any pop-up windows or any other kind  of user 
%interaction. Feel  free  to  divide  your  code  into  several  
%different functions,and to store pre-computed properties of
%known faces in .mat-files,which can be easily loaded when testing 
%the program.
%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%function id = tnm034(im)
%
%im: Image of unknown face, RGB-image in uint8 format in the range [0, 255]
%
%id: The identity number (integer) of the indetified person, i.e. `1�,
%`2�,..., `16� for the persons belonging to `db1�and `0�for all other
%faces. 
%
%Your program code. 
%%%%%%%%%%%%%%%%%%%%%%%%%%


function id = tnm034(im)
    I = imread(im);
    orig = I;
    
    %Gray world algorithm
    [cols, rows, channels] = size(I);
    Ravg = sum(sum(I(:, :, 1)))/(cols*rows);
    Gavg = sum(sum(I(:, :, 2)))/(cols*rows);
    Bavg = sum(sum(I(:, :, 3)))/(cols*rows);
    
    alpha = Gavg/Ravg;
    beta = Gavg/Bavg;
    
    I(:, :, 1) = alpha*I(:, :, 1);
    I(:, :, 3) = beta*I(:, :, 3);
    figure;
    subplot(1,2,1);
    imshow(orig);
    subplot(1,2,2);
    imshow(I);
end


