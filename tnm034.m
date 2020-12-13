%%%%
%In the Matlab environment you will find many valuable functions that 
%you may call in your program. Other program libraries are not allowed. 
%You can use anynumber of functions in your file,but the format of the
%calling function should adhere to the skeleton above.Our testing of 
%your program will be done automatically in a batch run. Therefore your 
%code should not include any pop-up windows or any other kind  of user 
%interaction. Feel  free  to  divide  your  code  into  several  
%different functions,and to store pre-computed properties of
%known faces in .mat-files,which can be easily loaded when testing 
%the program.
%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%function id = tnm034(im)
%
%im: Image of unknown face, RGB-image in uint8 format in the range [0, 255]
%
%id: The identity number (integer) of the indetified person, i.e. `1���,
%`2���,..., `16��� for the persons belonging to `db1���and `0���for all other
%faces. 
%
%Your program code. 
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
%function id = tnm034(im)
    %clear 
    %clc

    %Flyttade ut bilden f�r fick den inte att l�sa fr�n mappen (?!)
    im = 'DB1/DB1/db1_01.jpg';
    refImg = imread(im);
    refImg = im2uint8(refImg);

    %Test stability
    %refImg = imrotate(refImg, 5);
    %refImg = imresize(refImg, 1.1);
    %refImg = refImg*0.7;

    %Lightning Compensation
    %refImg = GrayWorld(refImg);

    croppedFace = DetectFace(refImg);

    %imshow(croppedFace);

    Construct_Eigenfaces();

    %Emil testar
    load ('eigenfaces_database.mat');

    %Ta fram ansiktet
    face = im2double(croppedFace);
   % [width,height] = size(face);
   % face = reshape(face, [width*height,1]);
    %face = mean(face, 2);
    face2 = face(:);
    face = face2 - meanOfFaces;

    %Ta fram vikter med valt face
    omegaT2 = eigenFaces.'*face;

    %Equation 9 in Turk
    tmp2 = omegaT2-omegaT;
    tmp = sum(abs(tmp2));
    [error, number] = sort(tmp);
    bestMatchImage = number(1);
    smallestError = error(1);

    %Mathcing ID 
    threshold = 15000;
    if smallestError < threshold
        id = bestMatchImage;
    else
        id = 0;
    end

    if (id == 0)
        return;

    elseif(id < 10)
        i = int2str(id);
        imgName = strcat('DB1/DB1/db1_0', i, '.jpg');
        imshow(imgName);

    elseif(id >= 10)
        i = int2str(id);
        imgName2 = strcat('DB1/DB1/db1_', i, '.jpg');
        imshow(imgName2);
    end

%end


%imshow(mask);
