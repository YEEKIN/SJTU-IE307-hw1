% Project1-1-1 DFT&IDFT
% Name: Yijian Kong
% ID: 518021910160

tic
clear;

TestPic = imread('test2.jpeg'); 
GrayPic = im2double(rgb2gray(TestPic));
DFTPic = K_DFT(GrayPic);
IDFTPic = K_IDFT(DFTPic);
% DFTPic = fft2(GrayPic);
% IDFTPic = ifft2(DFTPic);

subplot(2,2,1); 
imshow(TestPic), title('Original Picture');
subplot(2,2,2); 
imshow(GrayPic), title('Gray Picture');
imwrite(GrayPic,"Gray1.jpeg");
subplot(2,2,3); 
imshow(DFTPic), title('DFT Picture');
imwrite(DFTPic,"DFT1.jpeg");
subplot(2,2,4); 
imshow(IDFTPic), title('IDFT Picture');
imwrite(IDFTPic,"IDFT1.jpg");

toc;

function [DFTPic] = K_DFT(Pic)
[L,W] = size(Pic);
A = zeros(L,L);
B = zeros(W,W);
for k = 0 : L - 1
    A(k + 1,:) = exp(-1j * 2 * pi * k * (0 : L - 1) / L);
end
for k = 0 : W - 1
    B(k + 1,:) = exp(-1j * 2 * pi * k * (0 : W - 1) / W);
end
DFTPic = A * Pic * B;
end

function [IDFTPic] = K_IDFT(Pic)
[L,W] = size(Pic);
A = zeros(L,L);
B = zeros(W,W);
for k = 0 : L - 1
    A(k + 1,:) = exp(1j * 2 * pi * k * (0 : L - 1) / L);
end
for k = 0 : W - 1
    B(k + 1,:) = exp(1j * 2 * pi * k * (0 : W - 1) / W);
end
IDFTPic = A * Pic * B / (L * W);
end