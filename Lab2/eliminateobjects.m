function output = eliminateobjects(im, q)
%
% function output=eliminateobjects(im, q)
%
%% LAB2, TASK 3
%
%% Eliminates objects smaller than those enclosed by a square of size q x q
%% 
% This code eliminates objects smaller than (or equal to) those enclosed by
% a square of size q x q pixels. It achieves this by filtering the image 
% with an appropriate box kernel in a single pass, followed by thresholding 
% the filtered result with a suitable threshold value. In the input image, 
% the background pixels have an intensity of B = 0.1, while all objects 
% have an average intensity value of Q = 0.8. The goal is to reduce the 
% average intensity of these objects to one fifth of their original 
% intensity (or less), specifically to Q/5 or lower.
%
%% Who has done it
%
% Authors: 
% Daniel Fridström danfr755 , Hans Fredö hanfr829.
% version: (2), 2024-11-23
%
%% Syntax of the function
%      Input arguments:
%           im: the original input grayscale image of type double scaled
%               between 0 and 1, containing a number of objects
%           q: The size that is specified in the task (all objects smaller
%              than (or equal to) those enclosed by a square of size q×q
%              pixels have to be eliminated)
%
%      Output argument:
%           output: is the input image, in which all objects smaller
%                   than q x q are eliminated
%
% You MUST NEVER change the first line
%
%% General rule
%
% Don't change the structure of the template by removing %% lines
%
%% Here starts your code. 
% Write the appropriate MATLAB commands right after each comment below.
%
%
%% Finding the size of the box filter
Q = 0.8; % The average intensity of the objects
B = 0.1; % The background pixel intensity

% We want to reduce the average intensity of the objects smaller than q x q
% to Q/5. Write the equation to calculate the size of the box filter (n x n) 
% based on B and Q.
% The equation here:

n_formula = q * sqrt(5*(Q-B)/(Q-5*B)); % The size of the required filter

%% Find the smallest (odd) size of the filter here:

% FIXED HERE. WE CHANGED FROM FLOOR TO CEIL. SHOULD SOLVE THE PROBLEM!
n = ceil(n_formula); % the smallest odd size of the filter
if mod(n, 2) == 0
    n = n + 1; % Ensure its odd
end

%% Construct the box kernel here:
% A box filter is an n x n matrix with equal weights summing to 1
fbox = ones(n, n) / (n * n); % the box filter kernel

%% Apply the box filter kernel to the image here:

im_filt = imfilter(im, fbox, "symmetric", 'same'); % the filtered image


%% Threshold the filtered image
% If you have implemented everything correctly so far, the background 
% and all objects smaller than q x q will have pixel values less than Q/5. 
% Determine an appropriate threshold value (what should this threshold be?) 
% to threshold the filtered image. Call the resulting image after 
% thresholding `o_thresh`. In this image, the background and all objects 
% smaller than q x q should be represented as black (0), while larger 
% objects and the areas surrounding them should be white (1). 
% Note that you don't need to use for loops here; this operation can 
% be accomplished with a single MATLAB command. 
% Perform the thresholding on the filtered result below:

threshold_value = Q / 5;
o_thresh = im_filt > threshold_value; % The result of thresholding the filtered image

%% Create the output image
% Use the thresholded image (o_thresh) as a mask to create the output image. 
% In the resulting image (output), objects smaller than q x q should be 
% eliminated. This means that where o_thresh is equal to 1, the output 
% image (output) should retain the corresponding pixels from the input image (im). 
% Conversely, where o_thresh is equal to 0, the output image should have 
% the intensity value of the background (B).
%
% HINT: For example, if you have created a mask containing logical values 
% of 0 and 1, and you want the output image (OUT) to be equal to the input 
% image (IN1) where the mask is 1, and equal to a different value (IN2) 
% where the mask is 0, you can accomplish this with the following command:
%
% OUT= mask.*IN1 + (~mask.*IN2);
%
% Create the output image here:

output = o_thresh.* im + (~o_thresh) * B; % the output image
%% Questions
% Before answering the questions, you must test your code on at least four different input images, 
% as specified in the document for Lab 2 (Task 3).
% 
% Now for the questions:
%
% 1. Did you test your code on those four test images, following the instructions in the document for
% Lab 2 (Task 3)? Answer 'yes' or 'no'
% Your answer: 
%   Yes
%
% 2. Do the output images for all tests look as expected? Answer 'yes' or 'no'.
% Your answer: 
%   Yes
%
% 3. Did you ensure that there are only two intensity levels in your resulting images by zooming in, 
% and did you not observe any shadow-like intensity around the objects? Answer 'yes' or 'no'.
% Your answer: 
%   Yes
%
% 4. Why was your code unable to eliminate one of the 2 x 2 objects in test4.tif when q = 2? 
% Your answer:
%
%   When q = 2, the area of the smallest filter is equivalent to the area of the object 
%   (which is also 2 x 2 = 4 pixels). The box filter reduces the intensity of 
%   the object but does not entirely suppress it to Q/5 or lower. Therefore, it passes the 
%   threshold test and is not eliminated in the resulting image. 
%
%