function [Eye1x, Eye1y, Eye2x, Eye2y] = LocalizeEyes(mask, ymeanMouth)
%Find the position of the eye in the first half of the image
[h, w] = size(mask);
maskLeft = mask(1:ymeanMouth-35, 1:round(w/2));
[Eye1y, Eye1x] = find(maskLeft(:, :) == max(maskLeft(:)));
Eye1y = round(mean(Eye1y));
Eye1x = round(mean(Eye1x));

%Find the position of the eye in the second half of the image
maskRight = mask(1:ymeanMouth-35, round(w/2):w);
[Eye2y, Eye2x] = find(maskRight(:, :) == max(maskRight(:)));
Eye2y = round(mean(Eye2y));
Eye2x = round(w/2)+round(mean(Eye2x));
end