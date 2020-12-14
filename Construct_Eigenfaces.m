function Construct_Eigenfaces()

    imgFolder = "DB1/DB1/";
    filePattern = fullfile(imgFolder, '*.jpg');
    imageFiles = dir(filePattern);

    faceVectors = zeros(325983, 1);

    for i = 1:length(imageFiles)
        currentFile = imgFolder + imageFiles(i).name;
        currentImage = imread(currentFile);
        currentImage = DetectFace(currentImage);
        currentImage = im2double(currentImage);
        faceVectors(:, i) = currentImage(:);
    end

   %Ett medelvärde för alla bilder
   meanOfFaces = sum(faceVectors,2)./(length(imageFiles));
    
   %S4-5 Eigenfaces_Turk_91
   %Phi = Gamma- Psi
   phiFace = faceVectors(:,:)-meanOfFaces(:,:);
   tmp = phiFace.' * phiFace;
   [eigenVector_v, eigenValue] = eigs(tmp, length(imageFiles)); %#ok<ASGLU>
   
   %u = sum(phi*v) Eq(6)
   eigenFaces = phiFace * eigenVector_v;
   
   save('eigenfacesDatabase.mat', 'phiFace','meanOfFaces','eigenFaces');
end