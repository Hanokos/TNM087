clc;
clear;
close all;

% Step 1: Specify the paths to the image files
ImageMaskPath = 'F:\LIU\Matlab\TNM087\lab1\Lab1_Images\angiography-mask-image.tif';
ImageLivePath = 'F:\LIU\Matlab\TNM087\lab1\Lab1_Images\angiography-live-image.tif';

% Read the images
ImageMask = imread(ImageMaskPath);
ImageLive = imread(ImageLivePath);

% Convert the images to double precision in the range [0, 1]
ImageMask = im2double(ImageMask);
ImageLive = im2double(ImageLive);

%% 3 A) Show the enhanced difference image
% Compute the difference between the live image and the mask image
ImageDiff = ImageLive - ImageMask;

% Display the difference image
figure;
imshow(ImageDiff, []);
title('Difference Image');
