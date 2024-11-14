clc
close all
clear

%% CHAGNE HERE FOR YOUR OWN FILE FOLDERS!!!
path = 'F:\LIU\Matlab\TNM087\Lab2\Lab2_Images'; 
outputPath = 'F:/LIU/Matlab/TNM087/Lab2/Preparation'; 

% Concatenate the path and filename to create the full file path
filename = 'TestPattern.tif';
image = imread(fullfile(path, filename));  % Use fullfile for proper file path handling
image = im2double(image);

%% Problem 10 Filter the image using Sobel filter in the x-direction
Sobx = [-1 -2 -1; 0 0 0; 1 2 1];
Image7 = filter2(Sobx, image);

figure;
imshow(Image7, []);
title('Image7');
imwrite(Image7, fullfile(outputPath, 'Image7.tif'));


%% Problem 11: Filter the image using Sobel filter in the y-direction
Soby = [-1 0 1; -2 0 2; -1 0 1];  % Sobel kernel for y-direction
Image8 = filter2(Soby, image);     % Apply Sobel filter in y-direction

figure;
imshow(Image8, []);
title('Image8');
imwrite(Image8, fullfile(outputPath, 'Image8.tif'));

%% Problem 12: Calculate the Gradient Magnitude
% Calculate the gradient magnitude using the formula
GradientMagnitude = sqrt(Image7.^2 + Image8.^2);

% Display and save the resulting gradient image for Problem 12
figure;
imshow(GradientMagnitude, []);
title('Gradient Magnitude (Image9)');
imwrite(GradientMagnitude, fullfile(outputPath, 'Image9.tif'));