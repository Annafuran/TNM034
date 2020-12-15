function [rotatedFace] = RotateFace(inputImg, eye1x, eye1y, eye2x, eye2y)
  
deltaX = abs(eye2x-eye1x);
deltaY = abs(eye2y-eye1y);

if (eye1x > eye2x)
    eyeRy = eye1y;
    eyeLy = eye2y;
else
    eyeRy = eye2y;
    eyeLy = eye1y;
end

%Rotate clockwise if eye1y is bigger than eye2y, otherwise opposite
sign = 1;
if(eyeLy > eyeRy)
    sign = -1;
end
  
theta = sign*(atan2(deltaY,deltaX));
%Get the angle theta in degrees
thetaDegrees = theta*180/pi;

inputImg = imrotate(inputImg,thetaDegrees);
rotatedFace = inputImg;

end