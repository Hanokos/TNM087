function [IMG, noRice, noSmallMacs, noLargeMacs]=CountObjects(in)
%% Lab4, Task 3
%% Finds the number objects belonging to different classes
%
% Counts objects of different class and displays boundaries in different colors. 
% Input images containing three classes of ojects: grains of rice, snall
% macaronis and large macaronis
%
%% Who has done it
%
% Author: Hans Fredö, hanfr829 
% Co-author: Daniel Fridström, danfr755
% Version: (2), 2024-12-11
%
%% Syntax of the function
%      Input arguments:
%           in: the original input RGB color image of type double scaled between 0 and 1
%          
%      Output arguments:
%           IMG: the output RGB color image, displaying the boundaries of 
%              three diffferent classes of objects in different colors.
%           noRice: Number of grains of rice in the input image
%           noSmallMacs: Number of small macaromis in the input image
%           noLargeMacs: Number of large macaromis in the input image
%
% You MUST NEVER change the first line
%
%% General rule
% Don't change the structure of the template by removing %% lines
%
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%

%% Make the input color image grayscale, 
% by choosing its most appropriate channel 
% once again blue has the best contrast. 
bgray =in(:,:,3); % The grayscale version of the input color image
    
%% Threshold your image
% to separate the objects from the backgroound
% Make sure that the objects are white (value 1) and backround blaxk (0)

b_thresh = bgray < graythresh(bgray); % The thresholded image
    
%% Clean up the binary image 
% Use morphological operations to clean up the binary image from noise. 
% Especially make syre that your cleaned image don't contain any false object
% (i.e. single foreground pixels, or groups of connected foreground pixels, 
% that do not belong to the object classes  
r = 5; % seemed to work for the task at hand
se = strel("disk",r);
b_clean =imopen(b_thresh, se); % Cleaned up binary image
b_clean =imclose(b_clean,se);

%% Labelling
%  Use labelling to assign every object a unique number

L = bwlabel(b_clean); % Labelled image


    
%% Object features
% Compute relevant object features that you can use to classify 
% the three classes of objects

Stats =regionprops(L, 'Area'); % Compute object features

for n =1:length(Stats)
    Area(n) = Stats(n).Area;
end

%% Object classification
% Based on your object features, classify the objects, i.e. for each
% labelled object: decide if it belongs to the three classes: Rice, SmallMacs, or LargeMacs 
% In case you didn't suceed in cleaining up all false objects, you should
% discard them here, so they don't count as the classes of objects
upperboundlimit = 5000;
lowerboundlimit = 1000;


%% Count the objects for each class.

Rice = find(Area < lowerboundlimit);% Number of rices
SmallMacs  = find(Area > lowerboundlimit & Area < upperboundlimit);% Number of small macoronis
LargeMacs = find(Area > upperboundlimit);% Number of large macoronis

noRice  = length(Rice);
noSmallMacs  = length(SmallMacs);
noLargeMacs  = length(LargeMacs);

%% Create an RGB-image, IMG, displaying the bouandaries of different classes in different colors
% Use boundary extraction to determine object boundaries. Display object
% boundaries  using different colors for each class. Boundaries can be
% displayed either on a black background, or highlighed in the original image
[M, N] = size(L);
RGB = zeros(M, N, 3); % Initialize an RGB image (black background)
% Create a black background or use the original image as background
background = zeros(M, N, 3); % Black background
% Process boundaries for Rice class
for n = 1:noRice
boundary = bwperim(L == Rice(n)); % Extract boundary
RGB(:, :, 1) = RGB(:, :, 1) + boundary; % Add boundary to the red channel
end
% Process boundaries for Small Macrophages class
for n = 1:noSmallMacs
boundary = bwperim(L == SmallMacs(n)); % Extract boundary
RGB(:, :, 2) = RGB(:, :, 2) + boundary; % Add boundary to the green channel
end
% Process boundaries for Large Macrophages class
for n = 1:noLargeMacs
boundary = bwperim(L == LargeMacs(n)); % Extract boundary
RGB(:, :, 3) = RGB(:, :, 3) + boundary; % Add boundary to the blue channel
end
% Overlay boundaries on the background
IMG = max(RGB, background); 
% WE ADDED BOUNDARIES IN HERE NOW :)

%% Questions
%
% Before answering the questions, ensure you have tested your code according to the 
% instructions. 
% 
% Read the test images 'MacnRice1.tif', 'MacnRice2.tif' and 'MacnRice3.tif' in MATLAB and 
% normalize them to the range [0, 1]. Use them to test your code. 
% 
% Now for the questions:
%
% 1. For all the images "MacnRice1", MacnRice2, MacnRice3: 
% Have you checked the resulting images displays the
% BOUNDARIES of all objects in different colors, depeding on class?
% % (Answer 'yes' or 'no'. If 'no', please correct it!)
% Your answer: yes
%
% 2. For all three images MacnRice1, MacnRice2, MacnRice3:
% Have you confirmed that your code returns the correct number for each class:

% Image          noRice   noSmallMacs   noLargeMacs
% MacnRice1.tif  48       12            6
% MacnRice2.tif  60       14            6
% MacnRice3.tif  42       11            5

% Your answer: yes
% If 'no': your code is not functioning correctly and needs to be fixed before submission. 
% In that case, ask the teachers for clarification before submitting the code.

% If 'yes': Well done! Submit your code, togehter with the
% files 'Lab 4.1 Preparation Answers' and 'CountBrickRows.m'.


