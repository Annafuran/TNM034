
for i = 1:16
    imgNo = int2str(i);
    if i < 10
        imStr = strcat('DB1/DB1/db1_0', imgNo, '.jpg');
    else
        imStr = strcat('DB1/DB1/db1_', imgNo, '.jpg');
    end
    %imStr = 'DB0/DB0/db0_4.jpg';
    image = imread(imStr);
    
    %Testing changes in light intensity
    %image = im2double(image);
    %image = 1.3*image;
    
    %Testing changes in rotation
    %Does not work for image 9, 12 if rotating +5 degrees
    %Does not work for image 4, 6, 16 if rotating -5 degrees
    %image = imrotate(image, 5);
    
    %Testing changes in scaling
    %Does not work for image 10 if scale = 1.1
    image = imresize(image, 1.1);
    
    res = tnm034(image)
    
    if res ~= i
        number = num2str(i);
        msg = strcat('Threshold too large for image ', number, '!'); 
        disp(msg);
    end
end