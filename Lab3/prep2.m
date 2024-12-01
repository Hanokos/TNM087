%% Load 
clc
clear all
close all

path = 'F:\LIU\Matlab\TNM087\Lab3\lab3_images'; 
 
%% prep 11
filename = 'verticalbars_2.tif'; 
v2 = imread(fullfile(path, filename));

ft = fft2(v2); % Compute the 2D Fourier Transform
Spec6 = fftshift(ft); % Shift zero frequency to center
ms = abs(Spec6); % Compute magnitude spectrum
Spec6 = log(1 + ms); % Apply log transformation
Spec6 = Spec6/max(Spec6(:)); % Normalise image before saving it

figure;
imshow(Spec6)
%% prep 12
filename2 = 'verticalbars_4.tif'; 
v4 = imread(fullfile(path, filename2));

ft = fft2(v4); % Compute the 2D Fourier Transform
Spec7 = fftshift(ft); % Shift zero frequency to center
ms = abs(Spec7); % Compute magnitude spectrum
Spec7 = log(1 + ms); % Apply log transformation
Spec7 = Spec7/max(Spec7(:)); % Normalise image before saving it

figure(9)
imshow(Spec7)
