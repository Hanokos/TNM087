function [olp, ohp1, ohp2]=FilterFreq(f, D0)
%
% function [olp, ohp1, ohp2]=FilterFreq(f, D0)
%
%% Lab3, Task 2
%
%% Performs filtering in the frequency domain
%
% Lowpass and highpass filters the image in the frequency domain by
% a Gaussian filter constructed in the frequency domain
%
%% Who has done it
%
% Authors: danfr755, hanfr829
% date: 2024-12-01
% version: (1)
%
%% Syntax of the function
%      Input arguments:
%           f: the original input grayscale image of type double scaled
%               between 0 and 1
%           D0: The cutoff frequency of the Gaussian lowpass filter
%
%      Output arguments:
%           olp: Result after lowpass filtering the input image using
%                the Gaussian lowpass filter.
%           ohp1: Result after highpass filtering the input image using
%                 the Gaussian highpass filter (Approach 1).
%           ohp2: Result of highpass filtering the input image using 
%                 the lowpass version of the input image (Approach 2).
%
%%
% You MUST NEVER change the first line
%
%% General rule
%
% Don't change the structure of the template by removing %% lines
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% Zero Pad the Input Image
% The input image is zero-padded to a size of P x Q, where P = 2M and Q = 2N 
% (with M x N being the size of the input image). Note that the original 
% image should be positioned in the top-left corner of the zero-padded image.

f = im2double(f); % Ensure its scaled between 0 and 1
[M, N] = size(f);
P = 2*M;
Q = 2*N;
fp= zeros(P,Q); % the zero padded image

fp(1:M,1:N) = f;
%% construct the Gaussian lowpass and highpass filter transfer functions
% If you want, you can write a separate function to construct the Gaussian filter.
% If you do so, don't forget to submit that MATLAB function as well.
%
% The transfer function is supposed to be the same size as the padded image
% that is P x Q
% The cutoff frequency of this filter, D0, is the second input argument of
% this MATLAB function

% "Butterworth LP filter", Föreläsning5_6 sida 104 & 108
[X, Y] = meshgrid(0:P-1, 0:Q-1);
X = X';
Y = Y';
D = sqrt((X-P/2).^2+(Y-Q/2).^2);% Compute the distance from the center (P/2, Q/2)
GLPF= exp(-(D.^2)/(2*D0.^2)); % the Gaussian lowpass filter transfer function

% "Butterworth HP filter", Föreläsning5_6 sida 111
%  GHPF (u,v)= 1 - GLPF(u,v)
GHPF = 1 - GLPF; % the Gaussian highpass filter transfer function   
%% Perform filtering in the frequency domain
% Find the product between the filter transfer function and the Fourier
% transform of the padded image (Notice that the zero frequency is supposed
% to be shifted to the center of the Fourier transform)

%Fourier transform
FT = fftshift(fft2(fp));

OLP= GLPF.*FT; % The Fourier transform of the lowpass filtered image
OHP= GHPF.*FT; % The Fourier transform of the highpass filtered image
%% Find the padded lowpass and highpass filtered images
% The zero frequency of OLP and OHP should be shifted back to the top left corner of the
% image followed by the inverse Fourier transform. Take the real part of
% the result.

OLP_shift = ifftshift(OLP); % shift zero frequency back 
OHP_shift = ifftshift(OHP); 

olpf= real(ifft2(OLP_shift));  % The padded lowpass filtered image of size P x Q
ohpf= real(ifft2(OHP_shift)); % The padded highpass filtered image of size P x Q    
%% Find the lowpass and highpass filtered image
% Extract the final lowpass and highpass filtered images from their padded
% versions

olp= olpf(1:M, 1:N); % The final lowpass filtered image
ohp1 = ohpf(1:M, 1:N); % The final highpass filtered image (approach 1)
%% Find the highpass filtered image (approach 2)
% Read the document for this task

ohp2 = f - olp; % The final highpass filtered image
%% Test your code
% Test your code on various images (e.g., Einstein1.jpg, Einstein2.jpg, or characterTestPattern.tif)
% using different cutoff frequencies. Examine the results of both lowpass and highpass filtering 
% on the input image. 
% Ensure that your code operates correctly with any image.
%% Questions
%
% Before answering the questions, ensure you have tested your code according to the 
% following instructions. 
% 
% First, read the image 'Einstein1.jpg' in MATLAB and 
% normalize it to the range [0, 1]. Assume the image is stored in 'im'.
% 
% Run your code with the following command:
%
% [olp, ohp1, ohp2] = FilterFreq(im, D0)
% using three different cutoff frequencies: 40, 80, and 120.
% 
% Display the output images and answer the questions below.
% 
%% Now for the questions:
%
% 1. Did you test your code following the instructions above and examine all three output 
% images for the three cutoff frequencies? (Answer 'yes' or 'no'. If 'no', test your code!)
% Your answer:  YES
%
% 2. Did you ensure your code functions correctly with any input image? 
% (Answer 'yes' or 'no'. If 'no', make sure it does!)
% Your answer: YES
%
% 3. What happens to the lowpass filtered image when you increase the cutoff frequency? 
% Will the result be blurrier or less blurry? Explain why this happens.
% Your answer: (don't forget to provide an explanation)
%
%   It gets less blurry. This is because the Gaussian lowpass filter lets
%   the frequency below that threshold to pass while higher get
%   removed.This lead to more details from the high freuqnecu compoents
%   stays in the image.
%
%
% 4. What happens to the highpass filtered image when you increase the cutoff frequency? 
% Do you observe more or fewer details? Explain why this happens.
% Your answer: (don't forget to provide an explanation)
%
%   It gets more blurry.  This is because the Gaussian Highpass filter
%   removes the frequency below that threshold and keeps the one with
%   higher than the cutoff frequency. So when the cutoff freueuncy is high
%   it removes more low frequency componentes, thus making the image to only
%   have a few high component that gives details.
%
%
%
% 5. Did you confirm that ohp1 and ohp2 are identical for all three cutoff frequencies?
% (Answer 'yes' or 'no'. If 'no', make sure you do!)
% Your answer: YES
%
% 6. What is the maximum number of decimal places (n, as referred to in the instructions) to which 
% you rounded ohp1 and ohp2 to ensure they were identical for the following cutoff frequencies, 
% using the original image Einstein1.jpg.
% 
% Your answer:
% What is n for a cutoff frequency of 40?  the maximum of decimal is 10
% What is n for a cutoff frequency of 80?  the maximum of decimal is 9
% What is n for a cutoff frequency of 120? the maximum of decimal is 10
%
%