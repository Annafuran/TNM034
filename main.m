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
%id: The identity number (integer) of the indetified person, i.e. `1ï¿½,
%`2ï¿½,..., `16ï¿½ for the persons belonging to `db1ï¿½and `0ï¿½for all other
%faces. 
%
%Your program code. 
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
clear 
clc

%Flyttade ut bilden för fick den inte att läsa från mappen (?!)
refImg = imread('db0_1.jpg');

%Lightning Compensation
refImg = GrayWorld('db0_1.jpg');

%Color space transformation + Skin color detection
refImg = SkinColorDetection(refImg);

imshow(refImg);


