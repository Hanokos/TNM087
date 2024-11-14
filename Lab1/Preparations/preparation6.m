clc;
clear;
close all;

% Step 1: Create an empty RGB matrix with dimensions 400x600x3 (400 rows, 600 columns, 3 color channels)
I = zeros(400, 600, 3);

% Step 2: Create the dark blue background (dark blue is RGB: [0, 0, 0.5])
I(:,:,3) = 0.5;  % Set the blue channel to 0.5 for dark blue

% Step 3: Create the darker yellow cross (horizontal and vertical stripes)
% Use RGB values for a darker yellow: [1, 0.8, 0]
yellow = [1, 0.8, 0];  % Darker yellow color

% Horizontal yellow stripe (covering the central horizontal band of the flag)
I(150:250,:,1) = yellow(1);  % Set the red channel to 1 for yellow
I(150:250,:,2) = yellow(2);  % Set the green channel to 0.8 for darker yellow

% Vertical yellow stripe (covering the central vertical band of the flag)
I(:,200:300,1) = yellow(1);  % Set the red channel to 1 for yellow
I(:,200:300,2) = yellow(2);  % Set the green channel to 0.8 for darker yellow

%% A) Show the flag image
% Step 4: Display the Swedish flag
figure;
imshow(I);
title('Swedish Flag');
