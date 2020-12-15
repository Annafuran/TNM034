function [binaryImg] = SkinColorDetection(inputImg)
%Function to detect skin color and create a binary mask containing the
%skin pixels
binaryImg = zeros(size(inputImg, 1), size(inputImg,2));

%Convert the image from RGB to YCbCr
YCbCr_img = rgb2ycbcr(inputImg);
Y = YCbCr_img(:,:,1);
Cb = YCbCr_img(:,:,2);
Cr = YCbCr_img(:,:,3);

%The values are from this article: https://arxiv.org/ftp/arxiv/papers/1708/1708.02694.pdf
[row, column] = find(Cb>=85 & Cr>=135 & Y >= 80);

%Mark the skin pixels
for n=1:size(row,1)
    binaryImg(row(n), column(n)) = 1;
end

se = strel('disk',12);

%Morphological operations to get rid of holes in the face and some of the
%background
binaryImg = imopen(binaryImg, se);
binaryImg = imclose(binaryImg, se);

binaryImg = imdilate(binaryImg, se);
binaryImg = imdilate(binaryImg, se);
binaryImg = imerode(binaryImg, se);
binaryImg = imerode(binaryImg, se);

end
