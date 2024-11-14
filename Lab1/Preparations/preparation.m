clc;
clf;
clear;
close all;

% Specify the path to the image file
image_path = 'F:\LIU\Matlab\TNM087\lab1\Lab1_Images\book-cover.tif';  % Adjust this if the image is in a different folder

% Read the image into the workspace
Image = imread(image_path);
Image2 = Image / 16; % for task B and C

%% 1 A) Find the highest pixel value in the image
whos Image % Display image class and size
max_pixel_value = max(Image(:));

figure();  % Open a figure window
imshow(Image);
title('Original Image');
disp(['A) The highest pixel value in the image is: ', num2str(max_pixel_value)]);

%% Display Histogram for the Original Image
figure();
imhist(Image);
title('Histogram of Original Image');

%% 1 B) Find the highest pixel value in the image
max_pixel_value_Image2 = max(Image2(:));
disp(['B) The highest pixel value in Image2 is: ', num2str(max_pixel_value_Image2)]);

%% Display Histogram for Image2
figure();
imhist(uint8(Image2 * 16));  % Scale Image2 back for histogram visualization
title('Histogram of Image2');

%% 1 C) Display Image2
figure(); 
imshow(Image2);
title('Image2');

figure(); 
imshow(Image2, []);
title('Image2 - With Display Range Adjustment');

%% 1 D) Compute a new image, Image3, by multiplying Image2 by a factor of 16
Image3 = Image2 * 16;

% Display Image3
figure();
imshow(Image3, []);
title('Image3 - Recovered Image by Multiplying Image2 by 16');

% Compare Image3 to the original Image
% Use the difference to see if any values changed
difference = Image - Image3;
disp(['D) Maximum difference between Image and Image3 is: ', num2str(max(difference(:)))]);

% Display Histogram for Image3
figure();
imhist(uint8(Image3));  % Display the histogram of Image3 after scaling
title('Histogram of Image3'); % The histogram for Image3 will show that pixel values are clustered into multiples of 16,
                              % confirming the loss of precision after the scaling operation

%% 1 E) Determine the number of gray levels in Image3
% Calculate the unique gray levels in Image3
gray_levels_Image3 = unique(Image3);
num_gray_levels_Image3 = numel(gray_levels_Image3);

disp(['E) The number of gray levels in Image3 is: ', num2str(num_gray_levels_Image3)]);

%%  Visualize the transformation of gray levels using A and B
A = uint8(0:255);  % Vector of all possible gray levels
B = uint8((A / 16) * 16);  % Perform the same operation (A/16)*16 to see gray level transformation

% Display the effect of the transformation
figure(43);
plot(A, B, 'o-'); 
title('Gray Level Transformation: A -> B');
xlabel('Original Gray Level (A)');
ylabel('Transformed Gray Level (B)');

%% 1 F) and 1 G) and 1 H) 
%Read the word document