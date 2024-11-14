clc
close all
clear

%% CHAGNE HERE FOR YOUR OWN FILE FOLDERS!!!
path = 'F:\LIU\Matlab\TNM087\Lab2\Lab2_Images'; 
outputPath = 'F:/LIU/Matlab/TNM087/Lab2/Preparation'; 

% Concatenate the path and filename to create the full file path
filename = 'TestPattern.tif';
image = imread(fullfile(path, filename));  % Use fullfile for proper file path handling
image=im2double(image);

%% Problem 1 - Image1
% Create a 9x9 box filter kernel. Fö3, slide 27
kernel1 = ones(9, 9) / (9 * 9);

% Apply the filter using filter2
Image1 = filter2(kernel1, image);

% Display the resulting image
figure;
imshow(Image1, []);
title('Image1 (used filter2)');
imwrite(Image1, fullfile(outputPath, 'Image1.tif'));
%% Problem 2 - Image2
% Create a 21x21 box filter kernel. Fö3, slide 27
kernel2 = ones(21, 21) / (21 * 21);

% Apply the filter using filter2
Image2 = filter2(kernel2, image);

% Display the resulting image
figure;
imshow(Image2, []);
title('Image2 (used filter2)');
imwrite(Image2, fullfile(outputPath, 'Image2.tif'));
%% Problem 3 - Image3
kernelSize = 29; % Size of the kernel (29x29)
sigma = 4.8; % Standard deviation for the Gaussian filter

% Gaussian filter of size  a 29x29 
gaussian = fspecial('gaussian', kernelSize, sigma);
% Gaussian filter of size  a 29x29 

% Apply the filter using filter2
Image3 = filter2(gaussian, image);

% Display the resulting image
figure;
imshow(Image3, []);
title('Image3');
imwrite(Image3, fullfile(outputPath, 'Image3.tif'));
%% Problem 4 & 5
% read word document

%% Problem 6 - Replicate padding

% We are usign kernel2 from problem2 21x21 kernelsize
Image4 = imfilter(image, kernel2, 'replicate');  % Use 'replicate' padding

% Display the resulting image
figure;
imshow(Image4, []);
title('Image4');

% Save the resulting image
imwrite(Image4, fullfile(outputPath, 'Image4.tif'));
%% Problem 7 - High-pass Filter

% Create a delta kernel
deltaKernel = zeros(21, 21);
deltaKernel(11, 11) = 1;  % Set the center element to 1

% Construct the high-pass filter: ℎp(x,y) = d(x,y) − lp(x,y)
highPassKernel = deltaKernel - kernel2;

% Apply the high-pass filter using imfilter with 'replicate' padding to avoid dark borders
Image5 = imfilter(image, highPassKernel, 'replicate');

% Display the resulting high-pass filtered image
figure;
imshow(Image5, []);
title('Image5 (High-pass Filtered Image)');

% Save the resulting image
imwrite(Image5, fullfile(outputPath, 'Image5.tif'));

%% Problem 8 - mean

meanHighPass = mean2(highPassKernel);  % Mean of the high-pass filter kernel
meanHighPass_alt = mean(highPassKernel(:));  % Alternative way to compute mean
sumHighPass = sum(highPassKernel(:));  % Sum of the high-pass filter kernel

% Display the computed values
disp(['Mean of high-pass filter (mean2): ', num2str(meanHighPass)]);
disp(['Mean of high-pass filter (mean function): ', num2str(meanHighPass_alt)]);
disp(['Sum of high-pass filter: ', num2str(sumHighPass)]);

%% Problem 9 - Image6

Image6 = Image5 + image;
figure;
imshow(Image6)
title('Image6 (Image5 + image)');
imwrite(Image6, fullfile(outputPath, 'Image6.tif'));
