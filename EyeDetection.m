function [EyeDetectedImg] = EyeDetection(inputImg)

YCbCr_img = rgb2ycbcr(inputImg);
Y = YCbCr_img(:,:,1);
Cb = YCbCr_img(:,:,2);
Cr = YCbCr_img(:,:,3);

CrNegative = 255-Cr;

EyeMapC = (Cb.*Cb+CrNegative.*CrNegative+Cb./Cr)/3;

se = strel('disk', 10);

EyeMapL = imdilate(Y, se) ./ (imerode(Y, se) + 1);

EyeDetectedImg = EyeMapC.*EyeMapL;

imshow(EyeDetectedImg);

end