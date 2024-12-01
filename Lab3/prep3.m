%% Load 
clc
clear all
close all

path = 'F:\LIU\Matlab\TNM087\Lab3\lab3_images'; 

% First image
filename = 'Einstein1.jpg'; 
im = imread(fullfile(path, filename));
E1 = im2double(im);

e1ft = fftshift(fft2(E1));
angle1 = angle(e1ft);
Spec1 = abs(e1ft);

% Second image
filename2 = 'Einstein2.jpg'; 
im2 = imread(fullfile(path, filename2));
E2 = im2double(im2);

e2ft = fftshift(fft2(E2));
angle2 = angle(e2ft);
Spec2 = abs(e2ft);

%% prep 14
E1_E2 = real(ifft2(Spec1.*exp(1i*angle2))); % specutrum of E1 and angle of E2

figure;
imshow(E1_E2)
imwrite(E1_E2, "F:\LIU\Matlab\TNM087\Lab3\selfmade_images\E1_E2.tif")
%% prep 15
E2_E1 = real(ifft2(Spec2.*exp(1i*angle1))); % specutrum of E2 and angle of E1

figure;
imshow(E2_E1)
imwrite(E2_E1, "F:\LIU\Matlab\TNM087\Lab3\selfmade_images\E2_E1.tif")
