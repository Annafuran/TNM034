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
%id: The identity number (integer) of the indetified person, i.e. `1���,
%`2���,..., `16��� for the persons belonging to `db1���and `0���for all other
%faces. 
%
%Your program code. 
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
clear 
clc

%Flyttade ut bilden f�r fick den inte att l�sa fr�n mappen (?!)
refImg = imread('DB1/DB1/db1_08.jpg');
refImg = im2uint8(refImg);

%Lightning Compensation
%refImg = GrayWorld(refImg);
refImg = WhitePatch(refImg);

EyeMask = EyeDetection(refImg);
MouthMask = MouthDetection(refImg);
FaceMask = SkinColorDetection(refImg);

mask = EyeMask.*FaceMask;

%Crop the image according to the position of the eyes

thresholded = imbinarize(mask,0.6);

n1 = thresholded(:, 1 : round(end/2));
n2 = thresholded(:, round(end/2+1) : end );

[y,x] = find(n1);
xmeanN1 = mean(x);
ymeanN1 = mean(y);

[y,x] = find(n2);
xmeanN2 = mean(x);
ymeanN2 = mean(y);

EyeXAvg = (xmeanN1 + (width(n1) + 1 + xmeanN2)) / 2;
EyeYAvg = ((ymeanN1+ymeanN2) / 2)*(7/5);

targetSize = [426 362]; %minsta height och width

rect = [EyeXAvg-targetSize(2)/2 EyeYAvg-targetSize(1)/2 targetSize(2) targetSize(1)];
imcrop(mask, rect);

%imshow(mask);




