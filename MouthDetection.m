function [mouthMap] = MouthDetection(inputImg)

YCbCr_img = rgb2ycbcr(inputImg);
Cb = im2double((YCbCr_img(:,:,2)));
Cr = im2double((YCbCr_img(:,:,3)));

%Declaring variables for mouth map
Cr_2 = Cr.^2/(max(max(Cr)));
Cr_Cb = (Cr./Cb)/(max(max(Cr./Cb)));
[width, height,~] = size(inputImg);
n = width*height;

%this is basically the mean, could use mean(Cr_2) etc
num = (1/n)* sum(sum(Cr_2));
den = (1/n)* sum(sum(Cr_Cb));

eta = 0.95 * (num/den);

% Create mouth map
mouthMap = Cr_2 .* ((Cr_2 - (eta .* Cr_Cb)).^2);

%Normalizing
mouthMap = (mouthMap./max(mouthMap(:)));

%Dialiting resulting mouth map
se_2 = strel('disk', 5);
mouthMap = imdilate(mouthMap, se_2);

end