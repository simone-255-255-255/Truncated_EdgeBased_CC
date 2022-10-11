% This demo shows examples of illuminant estimation using the truncated edge-based color constancy code.
% It showsh how it can run:
% - Grey-World
% - Shades of Gray
% - max-RGB
% - general Grey World
% - 1st order Grey-Edge
% - 2nd order Grey-Edge
%
% REFERENCE :
%
% S. Bianco, M. Buzzelli
% "Truncated Edge-Based Color Constancy"
% IEEE International Conference on Consumer Electronics (ICCE-Berlin 2022).


% some example images
input_im=double(imread('building1.jpg'));
%input_im=double(imread('cow2.jpg'));
%input_im=double(imread('dog3.jpg'));

figure(1);imshow(uint8(input_im));
title('input image');

% Grey-World
[wR,wG,wB,out1]=general_cc_truncated(input_im,0,1,0,-1);
figure(2);imshow(uint8(out1));
title('Grey-World');

% max-RGB
[wR,wG,wB,out2]=general_cc_truncated(input_im,0,-1,0,-1);
figure(3);imshow(uint8(out2));
title('max-RGB');

% Shades of Grey
mink_norm=5;    % any number between 1 and infinity
[wR,wG,wB,out3]=general_cc_truncated(input_im,0,mink_norm,0,-1);
figure(4); imshow(uint8(out3));
title('Shades of Grey');

% general Grey-World
mink_norm=5;    % any number between 1 and infinity
sigma=2;        % sigma 
diff_order=0;   % differentiation order (1 or 2)
trunc_level=-1; % -1: no truncation. Filter size is 13x13 (13=(2*3)*2+1)
tic;
[wR,wG,wB,out4]=general_cc_truncated(input_im,diff_order,mink_norm,sigma,trunc_level);
time_GGW=toc;
figure(5); subplot(1,2,1); imshow(uint8(out4));
title('general Grey-World');

mink_norm=5;    % any number between 1 and infinity
sigma=2;        % sigma 
diff_order=0;   % differentiation order (1 or 2)
trunc_level=2;  % 2: filter size is 5x5 (=2*2+1)
tic;
[wR,wG,wB,out4]=general_cc_truncated(input_im,diff_order,mink_norm,sigma,trunc_level);
time_truncGGW=toc;
subplot(1,2,2); imshow(uint8(out4));
title('truncated general Grey-World');
disp(['truncated general Grey-World speed-up: ' num2str(1/(time_truncGGW/time_GGW),'%.2f') 'x'])

% Grey-Edge (1st order)
mink_norm=5;    % any number between 1 and infinity
sigma=2;        % sigma 
diff_order=1;   % differentiation order (1 or 2)
trunc_level=-1; % -1: no truncation. Filter size is 13x13 (13=(2*3)*2+1)
tic;
[wR,wG,wB,out5]=general_cc_truncated(input_im,diff_order,mink_norm,sigma,trunc_level);
time_GE1=toc;
figure(6); subplot(1,2,1); imshow(uint8(out5));
title('Grey-Edge (1st order)');

mink_norm=5;    % any number between 1 and infinity
sigma=2;        % sigma 
diff_order=1;   % differentiation order (1 or 2)
trunc_level=2;  % 2: filter size is 5x5 (=2*2+1)
tic;
[wR,wG,wB,out5]=general_cc_truncated(input_im,diff_order,mink_norm,sigma,trunc_level);
time_truncGE1=toc;
subplot(1,2,2); imshow(uint8(out5));
title('truncated Grey-Edge (1st order)');
disp(['truncated Grey-Edge (1st order) speed-up: ' num2str(1/(time_truncGE1/time_GE1),'%.2f') 'x'])

% Grey-Edge (2nd order)
mink_norm=5;    % any number between 1 and infinity
sigma=2;        % sigma 
diff_order=2;   % differentiation order (1 or 2)
trunc_level=-1; % -1: no truncation. Filter size is 13x13 (13=(2*3)*2+1)
tic;
[wR,wG,wB,out6]=general_cc_truncated(input_im,diff_order,mink_norm,sigma,trunc_level);
time_GE2=toc;
figure(7); subplot(1,2,1); imshow(uint8(out6));
title('Grey-Edge (2nd order)');

mink_norm=5;    % any number between 1 and infinity
sigma=2;        % sigma 
diff_order=1;   % differentiation order (1 or 2)
trunc_level=2;  % 2: filter size is 5x5 (=2*2+1)
tic;
[wR,wG,wB,out6]=general_cc_truncated(input_im,diff_order,mink_norm,sigma,trunc_level);
time_truncGE2=toc;
subplot(1,2,2); imshow(uint8(out6));
title('truncated Grey-Edge (2nd order)');
disp(['truncated Grey-Edge (2nd order) speed-up: ' num2str(1/(time_truncGE2/time_GE2),'%.2f') 'x'])