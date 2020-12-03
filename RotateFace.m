function [rotatedFace] = RotateFace(inputImg, eye1x, eye1y, eye2x, eye2y)
  
deltaX = abs(eye2x-eye1x);
deltaY = abs(eye2y-eye1y);

%Rotera medurs om eye1y är större än eye2y, annars rotera moturs
sign = -1;
if(eye1y < eye2y)
    sign = 1;
end
  
theta = sign*(atan2(deltaY,deltaX));
%Get the angle theta in degrees
thetaDegrees = theta*180/pi;
inputImg = imrotate(inputImg,thetaDegrees);
%inputImg = imtranslate(inputImg, [25.3, -10.1]);
rotatedFace = inputImg;

end