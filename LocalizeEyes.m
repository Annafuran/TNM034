function [Eye1x, Eye1y, Eye2x, Eye2y] = LocalizeEyes(mask, ymeanMouth)

[Eye1y, Eye1x] = find(mask(1: (ymeanMouth-35), :) == max(mask(:)));
Eye1y = round(mean(Eye1y));
Eye1x = round(mean(Eye1x));

mask(Eye1y-30:Eye1y+30, Eye1x-30:Eye1x+30) = 0.0;
[Eye2y, Eye2x] = find(mask(1: (ymeanMouth-35), :) == max(mask(:)));
Eye2y = round(mean(Eye2y));
Eye2x = round(mean(Eye2x));

end