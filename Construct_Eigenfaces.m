function Construct_Eigenfaces()

    imgFolder = "DB1/DB1/";
    filePattern = fullfile(imgFolder, '*.jpg');
    imageFiles = dir(filePattern);

    faceVectors = zeros(108661, 1);

    for i = 1:length(imageFiles)
        currentFile = imgFolder + imageFiles(i).name;
        currentImage = imread(currentFile);
        currentImage = DetectFace(currentImage);
        [rows, columns] = size(currentImage);

        faceVector = double(reshape(currentImage, [rows*columns, 1]));
        faceVectors(:, i) = faceVector;
    end

    meanFace = mean(faceVectors, 2);
    %meanFace = reshape(meanFace, [361 301, 1]);
    
   %S4-5 Eigenfaces_Turk_91
   %Phi = Gamma- Psi
   meanFace = mean(meanFace,2);
   phiFace = faceVector-meanFace;

   %16 pga 16 bilder,ful men fungerande lösning
   [eigenVector_v, ~] = eigs(phiFace.' * phiFace, 16);

   %u = sum(v*phi) Eq(6)
   eigenFaces = eigenVector_v * phiFace;

   %omega = u*(Gamma- Tsi) Eq(7), omega describe contribution of each
   %eigenface 
   omegaT = eigenFaces.' * phiFace;

   save('eigenfaces_database.mat', 'omegaT');
   
   meanFace = reshape(meanFace, [361 301, 1]);
   imshow(meanFace);
end