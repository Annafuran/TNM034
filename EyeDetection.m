function [EyeDetectedImg] = EyeDetection(inputImg)

YCbCr_img = rgb2ycbcr(inputImg);
Y = im2double((YCbCr_img(:,:,1)));
Cb = im2double((YCbCr_img(:,:,2)));
Cr = im2double((YCbCr_img(:,:,3)));

CrNegative = (1-Cr).^2;
Cb = (Cb.^2); 
CbCr =(Cb./Cr);

%Adding the normalized values 
EyeMapC = (CbCr + CrNegative + Cb)/3;

EyeMapC = histeq(EyeMapC);

se_1 = strel('Disk', 10);
EyeMapL = imdilate(Y, se_1) ./ (imerode(Y, se_1) + 1);

%Combinding the eyemaps
EyeDetectedImg = EyeMapC.*EyeMapL;

%Dialiting resulting eyemaps
se_2 = strel(10);
EyeDetectedImg = imdilate(EyeDetectedImg, se_2);

%Normalizing
EyeDetectedImg = (EyeDetectedImg./max(EyeDetectedImg(:)));

%imshow(EyeDetectedImg);

end