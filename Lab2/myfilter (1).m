function [olp, ohp, obr, obp, oum, ohb]=myfilter(im, lp1, lp2)
% 
% function [olp, ohp, obr, obp, oum, ohb]=myfilter(im, lp1, lp2)
%
%% LAB2, TASK2
%
%% Performs filtering
%
% Filters the original grayscale image, im, given two different lowpass filters
% lp1 and lp2 with two different cutoff frequencies.
% The results are six images, that are the result of lowpass, highpass,
% bandreject, bandpass filtering as well as unsharp masking and highboost
% filtering of the original image
%
%% Who has done it
%
% Authors: Daniel Fridström danfr755, Hans Fredö hanfr829
%
%
%% Syntax of the function
%
%      Input arguments:
%           im: the original input grayscale image of type double scaled
%               between 0 and 1
%           lp1: a lowpass filter kernel of odd size
%           lp2: another lowpass filter kernel of odd size, with lower cutoff
%                frequency than lp1
%
%      Output arguments:
%            olp: the result of lowpass filtering the input image by lp1
%            ohp: the result of highpass filtering the input image by
%                 the highpass filter constructed from lp1
%            obr: the result of bandreject filtering the input image by
%                 the bandreject filter constructed from lp1 and lp2
%            obp: the result of bandpass filtering the input image by
%                 the bandreject filter constructed from lp1 and lp2
%            oum: the result of unsharp masking the input image using lp2
%            ohb: the result of highboost filtering the input image using
%                 lp2 and k=2.5
%
% You MUST NEVER change the first line
%
%% Important rule
%
% Don't change the structure of the template by removing %% lines
%
%% Here starts your code. 
% Write the appropriate MATLAB commands right after each comment below.
%
%% Lowpass filtering
% Lowpass filter the input image by lp1. Use symmetric padding in order to
% avoid the dark borders around the filtered image.
% Perform the lowpass filtering here:

%filtering im with lowpass 1 using symmetric padding
olp = imfilter(im, lp1, "symmetric"); % The lowpass filtered image

%% Highpass filtering
% Construct a highpass filter kernel from lp1, call it hp1, here:

%getting size of lowpass filter 1
[x, y] = size(lp1);

%making impulse with the same size as lp1
impulse = zeros(x,y);

%changing the centerpoint to 1
impulse(floor(x/2)+1, floor(y/2)+1) = 1;

% highpass filter = 1 - lowpass filter
hp1= impulse - lp1; % the highpass filter kernel

% Filter the input image by hp1, to find the result of highpass filtering
% the input image, here:

%filtering im with highpass 1 using symmetric padding
ohp = imfilter(im, hp1, "symmetric"); % the highpass filtered image

%% Bandreject filtering
% Construct a bandreject filter kernel from lp1 and lp2, call it br1, 
% IMPORTANT: lp2 has a lower cut-off frequency than lp1
% here:

%getting lp1 and lp2 size
[x1, y1] = size(hp1);
[x2, y2] = size(lp2);

fixadHp1 = padarray(hp1, [(x2-x1)/2, (y2-y1)/2], 0, 'both');

%Bandreject according to formula br = lp2 + hp1
br1 = lp2 + fixadHp1; % the bandreject filter kernel

% Filter the input image by br1, to find the result of bandreject filtering
% the input image, here:

%obr = imfilter(im, hp1, "symmetric"); 
obr = imfilter(im, br1, "symmetric"); % the bandreject filtered image

%% Bandpass filtering
% Construct a bandpass filter kernel from br1, call it bp1, here:

sizelp2 = size(lp2); % d = size(X)   returns  d = [2 3 4]
bpimpuls = zeros(sizelp2); % creates a matrix with all zeroes with the same size as lp2
bpimpuls(floor(sizelp2(1)/2)+1, floor(sizelp2(2)/2)+1) = 1; % we change the middle value to create a impuls matrix

%impulse - br1
bp1 = bpimpuls - br1; % the bandpass filter kernel


% Filter the input image by bp1, to find the result of bandpass filtering
% the input image, here:

obp = imfilter(im, bp1, "symmetric"); % the bandpass filtered image

%% Unsharp masking
% Perform unsharp masking using lp2, here:

% The typical blending formula for unsharp masking is sharpened = original + (original − blurred) × amount.
blurred = imfilter(im, lp2, "symmetric");
mask = im - blurred;
oum = im + mask; % the resulting image after unsharp masking

%% Highboost filtering
% Perform highboost filtering using lp2 (use k=2.5), here:

% The typical blending formula for unsharp masking is sharpened = original + (original − blurred) × amount.
% amount = k
k = 2.5;

%highboost according to formula
ohb = im + mask*k; % the resulting image after highboost filtering
%% Test your code
% Test your code on various images using different low-pass filters as input arguments. 
% In particular, it is highly recommended to test your code on the image zoneplate.tif, 
% which contains a range of frequencies. This makes it interesting to observe how different 
% filters allow certain frequencies to pass while blocking others. For filter kernels,
% it is useful to experiment with different box filters and Gaussian
% filters. Also, make sure your code functions correctly with any image and any filter kernels. 
%
%% Questions
% Before answering the questions, you must test your code according to the 
% following instructions. First, read the image 'zoneplate.tif' in MATLAB and 
% ensure that it is normalized to the range [0, 1]. Assume the image is stored in 'im'.
% 
% Display this test image, and take special note that it contains information 
% at different frequencies, where low-frequency details are concentrated in the 
% center, increasing in frequency as you move outward from the center.
% 
% Next, create two Gaussian filters:
% - lp1: a Gaussian filter of size 35x35 with a standard deviation of 5.8
% - lp2: a Gaussian filter of size 43x43 with a standard deviation of 7.2
% 
% Run your code with the following command:
% [olp, ohp, obr, obp, oum, ohb] = myfilter(im, lp1, lp2)
%
% Display all six output images and answer the questions below.
%
% NOTICE: You need to apply contrast stretching to the image 'obp', as you learned 
% in Lab 1. Otherwise, it will appear very dark.
%
% Now for the questions:
%
% 1. Did you test your code following the instructions above and examine all six output images? (Answer 'yes' or 'no'. If 'no', test your code!)
% Your answer: YES
%
%  2. Did you make sure your code functions correctly with any image and any filter kernels? 
% (Answer 'yes' or 'no'. If 'no', make sure it does!)
% Your answer: YES
%
% 3. Do these six output images look as expected? Answer 'yes' or 'no'.
% Your answer: YES
%
%