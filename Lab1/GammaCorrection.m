function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )
%function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )

%%  Lab 1 Task 2
%   Implement gamma correction:
%   Truncate the original gray values using lower and upper quantiles
%   (Lower, Upper) and then apply gamma correction with exponent Gamma 
%   to the input image OImage,
%   The result is the double image GImage with maximum gray value one
%
%% Who has done it
%
% Authors: danfr755, hanfr829
% date: 2024-11-11
%
%% Syntax of the function
%
%   Input arguments:
%       OImage: Grayscale image of type uint8 or double
%       Gamma: exponent used in the gamma correction, 
%       Lower: value in the range 0, 1
%       Upper: value in the range 0, 1 and lower < upper
%       Lower and Upper are quantile values. 
%   Output argument: GImage: gamma corrected gray value image of type double
%
% You MUST NEVER change the first line
%

%% Important rule
% Don't change the structure of the template by removing %% lines
%
%% Image class handling
% Make sure that you can handle input images of class uint8, uint16 and double 

if ~isa(OImage, 'double')
    OImage = double(OImage) / double(intmax(class(OImage)));  % Normalize to range [0,1]
end


%% Compute lower and upper gray value boundaries. 
% Use the parameteers Lower and Upper to find the corresponding gray values for the boundaries
% (look at the help function for the command 'quantile')
% The quantile values should be computed for the full mage, not for rows or columns. 
% This is similar to how you computes max- and minvalues in preparation 1A 

lowgv = quantile(OImage(:), Lower);  % Lower bound quantile
uppgv = quantile(OImage(:), Upper);  % Upper bound quantile
%% Compute a scaled version of the image, where: 
% the lower-bound gray value is zero 
% the upper-bound gray value is one 
% Then make sure that the range of ScaledImage is [0,1] by setting all 
% pixels<0 to 0 and all pixels >1 to 1

ScaledImage = (OImage - lowgv) / (uppgv - lowgv);
ScaledImage = max(0, min(ScaledImage, 1));  % Ensure values are in [0, 1]
%% Gamma mapping of the previous result 
% Make sure that ScaledImage is in the range [0,1] before applying gamma
% correction! You can e.g. use min(ScaledImage(:)) and max(ScaledImage(:))
% No for-loops should be used!
GImage = ScaledImage .^ Gamma;
%% Test your code

% Read the image 'spillway-dark.tif' (using imread) and call it OImage
% Call your function, using:
% GImage = GammaCorrection(Oimage, 0.4, 0.1, 0.9);
% Display GImage (using imshow) to make sure that it looks ok.

% If you get the warning: "Displaying real part of complex input" 
% it means that the image "ScaledImage" has negative values which causes
% complex numbers after gamma-correction. This must be fixed by making sure
% that "ScaledImage" is truncated to the range [0,1]

% Confrim that the min-value of GImage is >=0: min(GImage(:))
% Confrim that the max-value of GImage is <=1: max(GImage(:))

%% Experiments with your code
%
% Use your code to modify the images 'aerialview-washedout.tif' and
% 'spillway-dark.tif' for different values for Gamma, Lower and Upper
% Write some comments on your experiments and propose some good parameters
% to use (don't forget to comment your text)
% 
% 'spillway-dark.tif':
% These parametere was good for this image:
% Gamma = 0.4;
% Lower = 0.1;
% Upper = 0.9;
%
% 'aerialview-washedout.tif'
% These parametere was good for this image:
% Gamma = ;
% Lower = ;
% Upper =;
%
%
% The image 'IntensityRampGamma25.tif' illustrates the effect of an intensity
% ramp displayed on a monitor with gamma =2.5. 
% Which value for gamma should you use in your code to correct the image to appear as a linear intensity ramp?
% (Set Lower=0 and Upper=1)
%
% Answear: y= 1/2.5 = 0.4, Gamma = 0.4

%% Control question
% Before you hand in your code:
% 
% Have you tested your code accordiing to the instructions above and confirmed
% that GImage is in the range [0,1] and can be displayed (using imshow) without warnings?
% Answer 'yes' or 'no'.

% Your answer:  YES, we got: Minimum and maximum value of GImage: 0 and 1.

% If 'no': your code is not functioning correctly and needs to be fixed before submission. 
% In that case, ask the teachers for clarification before submitting the code.
% If 'yes': feel free to submit your code (after finishing also part 1 and
% part 3 of the lab).
