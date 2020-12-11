function [faceImg] = DetectFace(refImg)
    
    %refImg = imread('DB1/DB1/db1_11.jpg');
    refImg = WhitePatch(refImg);

    EyeMask = EyeDetection(refImg);
    MouthMask = MouthDetection(refImg);
    FaceMask = SkinColorDetection(refImg);
    
    mask = EyeMask.*FaceMask;

    %Localize the position of the mouth
    localizeMouthMask = MouthMask.*FaceMask;
    [h, w] = size(localizeMouthMask);
    thresholdedMouth = imbinarize(localizeMouthMask(:, round(0.4*w):round(0.6*w)), max(max(localizeMouthMask(:, round(0.4*w):round(0.6*w))-0.01)));
    [y,x] = find(thresholdedMouth);
    ymeanMouth = round(mean(y));

    %Localize the position of the eyes
    [Eye1x, Eye1y, Eye2x, Eye2y] = LocalizeEyes(mask, ymeanMouth);
    
    %Rotate the image to align the y-position of the eyes
    mask = RotateFace(mask, Eye1x, Eye1y, Eye2x, Eye2y);
    [Eye1x, Eye1y, Eye2x, Eye2y] = LocalizeEyes(mask, ymeanMouth);

    EyeXAvg = (Eye1x+Eye2x)/2;
    EyeYAvg = ((Eye1y+Eye2y)/2)*(6/5);
    
    %Crop the image according to the position of the eyes
    targetSize = [300 360]; %minsta height och width

    rect = [round(EyeXAvg-targetSize(1)/2) round(EyeYAvg-targetSize(2)/2) targetSize(1) targetSize(2)];
    faceImg = imcrop(mask, rect);
    size(faceImg);
end