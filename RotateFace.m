function [rotatedFace] = RotateFace(inputImg, eye1x, eye1y, eye2x, eye2y)


deltaX = abs(eye2x-eye1x);
deltaY = abs(eye2y-eye1y);

theta =  (atan2(deltaY,deltaX))*180/pi;

inputImg = imrotate(inputImg,theta);
%inputImg = imtranslate(inputImg, [25.3, -10.1]);
rotatedFace = inputImg;

end