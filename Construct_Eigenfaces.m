function Construct_Eigenfaces()

    imgFolder = "DB1/DB1/";
    filePattern = fullfile(imgFolder, '*.jpg');
    imageFiles = dir(filePattern);

    faceVectors = zeros(120701, 1);

    for i = 1:length(imageFiles)
        currentFile = imgFolder + imageFiles(i).name;
        currentImage = imread(currentFile);
        currentImage = DetectFace(currentImage);
        [rows, columns] = size(currentImage);

        faceVector = double(reshape(currentImage, [rows*columns, 1]));
        faceVectors(:, i) = faceVector;
    end

    meanFace = mean(faceVectors, 2);

    meanFace = reshape(meanFace, [401 301, 1]);

    imshow(meanFace)
end