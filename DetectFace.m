function [faceImg] = DetectFace(refImg)
    
    %refImg = imread('DB1/DB1/db1_13.jpg');
    refImg = WhitePatch(refImg);

    EyeMask = EyeDetection(refImg);
    MouthMask = MouthDetection(refImg);
    FaceMask = SkinColorDetection(refImg);
    
    mask = EyeMask.*FaceMask;

    %Localize the position of the mouth
    localizeMouthMask = MouthMask.*FaceMask;
    thresholdedMouth = imbinarize(localizeMouthMask, max(max(localizeMouthMask-0.01)));
    [y,x] = find(thresholdedMouth);
    ymeanMouth = round(mean(y));

    %Crop the image according to the position of the eyes
    thresholdedEyes = imbinarize(mask(1 : (ymeanMouth-35), :),max(max(mask))-0.4);

    n1 = thresholdedEyes(:, 1 : round(end/2));
    n2 = thresholdedEyes(:, round(end/2+1) : end );

    [y,x] = find(n1);
    xmeanN1 = mean(x);
    ymeanN1 = mean(y);

    [y,x] = find(n2);
    xmeanN2 = mean(x);
    ymeanN2 = mean(y);

    EyeXAvg = (xmeanN1 + (width(n1) + 1 + xmeanN2)) / 2;
    EyeYAvg = ((ymeanN1+ymeanN2) / 2)*(11/10);

    targetSize = [300 400]; %minsta height och width

    rect = [round(EyeXAvg-targetSize(1)/2) round(EyeYAvg-targetSize(2)/2) targetSize(1) targetSize(2)];
    faceImg = imcrop(mask, rect);
    imshow(refImg)
    size(faceImg)
end