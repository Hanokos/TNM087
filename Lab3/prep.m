clc
clear all
close all
%% Load and normalize the zoneplate image
path = 'F:\LIU\Matlab\TNM087\Lab3\lab3_images'; 
filename = 'characterTestPattern.tif';

im = imread(fullfile(path, filename));  
cTP = im2double(im); %Using imread and im2double is correct for loading and scaling the image to the range [0, 1].
%% prep 1

figure(1);
imshow(cTP);
title('cTP');

ft = fft2(cTP); % Compute the 2D Fourier Transform
Spec1 = fftshift(ft); % Shift zero frequency to center
ms = abs(Spec1); % Compute magnitude spectrum
Spec1 = log(1 + ms); % Apply log transformation
Spec1 = Spec1/max(Spec1(:)); %Normalise image before saving it

figure;
imshow(Spec1)
title('Spec1');
imwrite(Spec1, "F:\LIU\Matlab\TNM087\Lab3\selfmade_images\Spec1.tif")

%% prep 2

cTP_shift = circshift(cTP, [100, -200]); % Circular shift the image

% Display the shifted image
figure;
imshow(cTP_shift, []);
title('cTP_shift');

ft = fft2(cTP_shift); % Compute the 2D Fourier Transform
Spec2 = fftshift(ft); % Shift zero frequency to center
ms = abs(Spec2); % Compute magnitude spectrum
Spec2 = log(1 + ms); % Apply log transformation
Spec2 = Spec2/max(Spec2(:)); % Normalise image before saving it

figure;
imshow(Spec2)
title('Spec2');
imwrite(Spec2, "F:\LIU\Matlab\TNM087\Lab3\selfmade_images\Spec2.tif")

%% prep 4

cTP_rot =imrotate(cTP, 15, "bicubic");


ft = fft2(cTP_rot); % Compute the 2D Fourier Transform
Spec3 = fftshift(ft); % Shift zero frequency to center
ms = abs(Spec3); % Compute magnitude spectrum
Spec3 = log(1 + ms); % Apply log transformation
Spec3 = Spec3/max(Spec3(:)); % Normalise image before saving it


figure;
imshow(Spec3)
title('Spec3');
imwrite(Spec3, "F:\LIU\Matlab\TNM087\Lab3\selfmade_images\Spec3.tif")

%% prep 6

filename2 = 'characterTestPattern_2.tif';
im = imread(fullfile(path, filename2));  
cTP2 = im2double(im); %Using imread and im2double is correct for loading and scaling the image to the range [0, 1].

figure;
imshow(cTP2)
title('cTP2');

ft = fft2(cTP2); % Compute the 2D Fourier Transform
Spec4 = fftshift(ft); % Shift zero frequency to center
ms = abs(Spec4); % Compute magnitude spectrum
Spec4 = log(1 + ms); % Apply log transformation
Spec4 = Spec4/max(Spec4(:)); % Normalise image before saving it


figure;
imshow(Spec4)
title('Spec4');
imwrite(Spec4, "F:\LIU\Matlab\TNM087\Lab3\selfmade_images\Spec4.tif")

%% prep 9

filename3 = 'characterTestPattern_3.tif';
im = imread(fullfile(path, filename3));  
cTP3 = im2double(im); %Using imread and im2double is correct for loading and scaling the image to the range [0, 1].

figure;
imshow(cTP3)
title('cTP3');

Spec5 = fftshift(fft2(cTP3));
ms = abs(Spec5); % Compute magnitude spectrum
Spec5 = log(1 + ms);
Spec5 = Spec5/max(Spec5(:));

figure;
imshow(Spec5)
title('Spec5');
imwrite(Spec5, "F:\LIU\Matlab\TNM087\Lab3\selfmade_images\Spec5.tif")
