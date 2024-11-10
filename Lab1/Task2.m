clc;
clf;
clear;
close all;

% Step 1: Read the image 'spillway-dark.tif' using imread
OImage = imread('F:\LIU\Matlab\TNM087\lab1\Lab1_Images\spillway-dark.tif');  % Make sure this file is in the current folder or use full path

% Step 2: Call the GammaCorrection function
% We use the parameters: Gamma = 0.4, Lower = 0.1, Upper = 0.9
GImage = GammaCorrection(OImage, 0.4, 0.1, 0.9);

% Step 3: Display the resulting image
imshow(GImage);  % Display the gamma-corrected image
title('Gamma Corrected Image');  % Add a title to the displayed image

% Step 4: Confirm the minimum and maximum values of GImage
min_val = min(GImage(:));  % Get the minimum pixel value of GImage
max_val = max(GImage(:));  % Get the maximum pixel value of GImage

% Display the minimum and maximum values to check the range
disp(['Minimum value of GImage: ', num2str(min_val)]);
disp(['Maximum value of GImage: ', num2str(max_val)]);

% Step 5: Check if the image contains complex numbers
if any(imag(GImage(:)) ~= 0)
    disp('Warning: GImage contains complex values. This should not happen.');
else
    disp('GImage has no complex values.');
end

% Step 6: Confirm that the values of GImage are within the valid range [0, 1]
assert(min_val >= 0, 'Error: Minimum value of GImage is less than 0.');
assert(max_val <= 1, 'Error: Maximum value of GImage is greater than 1.');
