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

   meanOfFaces = mean(faceVectors, 2);
   %meanFace = reshape(meanFace, [361 301, 1]);
    
   %S4-5 Eigenfaces_Turk_91
   %Phi = Gamma- Psi
   %meanOfFaces = mean(meanOfFaces,2);
   phiFace = faceVectors(:,:)-meanOfFaces(:,:);
   %16 pga 16 bilder,ful men fungerande lösning, eigenValue inte relevant
   %för lösning
   tmp = phiFace.' * phiFace;
   [eigenVector_v, eigenValue] = eigs(tmp, 16);
   
   %u = sum(phi*v) Eq(6)
   eigenFaces = phiFace * eigenVector_v;

   %omega = u*(Gamma- Tsi) Eq(7), omega describe contribution of each
   %eigenface
   omegaT = eigenFaces.' * phiFace;
   meanOfFaces = reshape(meanOfFaces, [361 301, 1]);
   save('eigenfaces_database.mat', 'omegaT','meanOfFaces','eigenFaces');
   
   meanOfFaces = reshape(meanOfFaces, [361 301, 1]);
  % imshow(meanOfFaces);
end