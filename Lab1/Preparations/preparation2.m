clc;
clear;
close all;

% Specify the path to the image file
image_path = 'F:\LIU\Matlab\TNM087\lab1\Lab1_Images\einstein-low-contrast.tif';

% Read the image
img = imread(image_path);

% Convert the image to double precision and normalize to the [0, 1] range
img_double = double(img) / 255;

% Display the normalized image
figure;
imshow(img_double);
title('Normalized Image of Einstein (Low Contrast)');

%% 2 A) Calculate and display the min and max values for the image
min_value = min(img_double(:));  % Minimum intensity value
max_value = max(img_double(:));  % Maximum intensity value

% Print the min and max values to the command window
fprintf('2 A)\n');
fprintf('Min value: %f\n', min_value);
fprintf('Max value: %f\n', max_value);

%% 2 B) Display the histogram of the normalized image
figure;
imhist(img_double);
title('Histogram of Normalized Einstein Low Contrast Image');

%% 2 C) Perform contrast stretching
K = 1;  % Set K to 1 for normalized images (for uint8 images, K would be 255)
img_stretched = (img_double - min_value) * (K / (max_value - min_value));

% Display the contrast-stretched image
figure;
imshow(img_stretched);
title('Contrast-Stretched Image of Einstein');

%% 2 D) Calculate and display the min and max values for the stretched image
stretched_min_value = min(img_stretched(:));
stretched_max_value = max(img_stretched(:));

fprintf('2 D)\n');
fprintf('Min value for the stretched image: %f\n', stretched_min_value);
fprintf('Max value for the stretched image: %f\n', stretched_max_value);

%% 2 E) Display the histogram of the contrast-stretched image
figure;
imhist(img_stretched);
title('Histogram of Contrast-Stretched Image');
