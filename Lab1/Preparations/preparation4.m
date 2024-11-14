clc;
clear;
close all;

%% 4 A) Show the equalized image
% Step 1: Specify the path to the image file
image_path = 'F:\LIU\Matlab\TNM087\lab1\Lab1_Images\pollen-lowcontrast.tif';

% Step 2: Read the image
image = imread(image_path);

% Convert the image to double precision in the range [0, 1]
image = im2double(image);

% Step 3: Display the original image
figure;
imshow(image);
title('Original Image');

% Step 4: Perform histogram equalization using histeq
equalized_image = histeq(image);

% Display the equalized image
figure;
imshow(equalized_image);
title('Equalized Image');

%% 4 B) Show the histogram for the equalized image
% Display the histogram of the equalized image
figure;
imhist(equalized_image);
title('Histogram of Equalized Image');

%% 5 A) Apply thresholding to separate the white and black squares
% Thresholding to separate the squares (assuming background is dark, squares are bright)
threshold_value = 0.5; % You can adjust this based on the image contrast
binary_image = equalized_image > threshold_value;

% Display the thresholded (binary) image
figure;
imshow(binary_image);
title('Thresholded Image (Binary Separation)');
