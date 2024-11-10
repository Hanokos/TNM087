% Read the image 'spillway-dark.tif'

%OImage = imread('aerialview-washedout.tif');
%OImage = imread('spillway-dark.tif');
OImage = imread('IntensityRampGamma25.tif');


% Apply gamma correction with 
Gamma = 0.4; % 1/2.5 = 0.4
Lower = 0.0;
Upper = 1.0;
GImage = GammaCorrection(OImage, Gamma, Lower, Upper);

% Display the image
imshow(GImage);