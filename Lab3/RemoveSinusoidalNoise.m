function out=RemoveSinusoidalNoise(in,D0)
%
% function out=RemoveSinusoidalNoise(in,D0)
%
%% Lab3, Task 3
%
%% Removes the most dominant sinusoidal noise
%
% Removes the most dominant sinusoidal noise by applying a Butterworth
% Notch Reject filter in the frequency domain
%
%% Who has done it
%
% Authors: danfr755, hanfr829
% date: 2024-12-01
% version: (1)
%
%% Syntax of the function
% Input arguments:
% in: the original input grayscale image (which is corrupted by
% sinusoidal noises) of type double scaled between 0 and 1.
% D0: The bandreject width of the Notch filter being constructed
%
% Output argument:
% out: the output image where the most dominant sinusoidal noise
% is eliminated from the input image
%
% You MUST NEVER change the first line
%
%
%% General rules
%
% Don't change the structure of the template by removing %% lines
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% Localize the most dominant sinusoidal noise
% Sinusoidal noise peaks occur in pairs. Your task is to locate the most
% dominant pair, but it is sufficient to find just one of the two.
% However, when applying the Notch filter, you will create notches at both positions.
% Refer to the accompanying PDF document for further guidance on this task.
F= fftshift(fft2(in)); % the Fourier transform of the image followed by fftshift
F2= abs(F); % The spectrum/magnitude of F
% Set the pixel values at the center and a small surrounding neighborhood in F2 to zero 
% (or another small number) to avoid selecting the DC component as the dominant peak.
% Then, find the position of one of the dominant frequency peaks.
[P,Q]=size(in);
rowmid= floor(P/2)+1;
colmid = floor(Q/2)+1;
F2(rowmid-2:rowmid+2,colmid-2:colmid+2) = 0;
[~,index]=max(F2(:));
[row,col]=ind2sub(size(F2),index);
r= row; % the row number of one the two dominant peaks
c= col; % the column number of the same peak as above
%% Construct Notch filter
%
%% Find uk and vk to construct the Butterworth bandreject filter
% Use the position of one of the peaks to determine uk and vk, which represent 
% the position of the found maximum relative to the center of the frequency spectrum.
%
% For further explanation on uk and vk, refer to the lecture notes for Chapter 5.
uk= r - rowmid; % uk and vk are the positions of the peaks relative the center of the spectrum
vk= c - colmid; %
%% Construct the Butterworth Bandreject Notch filter
% If desired, you can write a separate function to construct the Notch filter.
% If you choose to do so, be sure to submit that MATLAB function as well.
%
% You’ve already constructed Gaussian filter transfer functions in Task 2 of this lab.
% The process for creating the Notch filter is similar.
% Refer to the lecture notes for Chapter 5 for examples on constructing such filter transfer functions.
n=2; % as specified in the task, the order should be 2
%föreläsning 5_6 slide 109
[X,Y]=meshgrid(0:P-1,0:Q-1);
X = X';
Y = Y';
floorP = floor(P/2);
floorQ = floor(Q/2);
D = sqrt((X-floorP-uk).^2+ (Y-floorQ-vk).^2);
D2 = sqrt((X-floorP+uk).^2+ (Y-floorQ+vk).^2);
H = (1./(1+(D0./D).^n)).*(1./(1+(D0./D2).^n)); % The filter transfer function of the Notch bandreject filter
%% Create the output image
% Apply the Notch filter to the Fourier transform of the input image in the frequency domain,
% and then transform back to the spatial domain to obtain the final output image.
out= F.*H; % the final output image, where the most dominant sinusoidal noise is eliminated
out = real(ifft2(ifftshift(out))); 
imshow(in)
figure
imshow(out)
%% Test your code
% Test your code on the four test images provided in the task instructions PDF.
% Ensure that the code performs as expected and correctly removes the sinusoidal noise.
%% Questions
% Before answering the questions, ensure you have thoroughly tested your code
% according to the instructions in the supplementary PDF file for this task.
%
% Now for the questions:
%
% 1. Did you test your code on astronaut-interference.tif and confirm that it successfully
% removes the sinusoidal noise using D0 = 1? (Answer 'yes' or 'no'. If 'no', test your code with this image and make sure it works!)
% Your answer: yes
%
% 2. The image Einstein_odd_sinus.tif has an odd number of rows and columns. Did you test your code on this image and confirm that
% it successfully removes the sinusoidal noise using D0 = 1? (Answer 'yes' or 'no'. If 'no', test your code with this image
% and make sure it works!)
% Your answer: yes
%
% 3. Did you test your code on Einstein_sinus_1.tif and confirm that it successfully
% removes almost completely the sinusoidal noise with a moderately large D0, and what D0 did you choose? 
% (Answer 'yes' or 'no'. If 'no', test your code with this image and make sure it works!)
% Your answer: (yes/no) yes
% The D0 that you used is: 14
%
% 4. Did you test your code on Einstein_sinus_2.tif and confirm that it successfully
% removes the most dominant sinusoidal noise using D0 = 1?
% (Answer 'yes' or 'no'. If 'no', test your code with this image and make sure it works!)
% Your answer: yes
%
% Did you try to increase D0 and make sure that larger D0 won't be able to
% remove the other sinusoidal noise? (Answer 'yes' or 'no'. If 'no', test your code with this image using some larger D0!)
% Your answer: yes
%
