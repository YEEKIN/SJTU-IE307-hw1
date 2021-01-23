% Project1-3 DFT Phase-Amplitude Inversion
% Name: Yijian Kong
% ID: 518021910160

tic
clear;
clc;

TestPic1 = imread("test1.jpeg");
TestPic2 = imread("test2.jpeg");
GrayPic1 = im2double(rgb2gray(TestPic1));
GrayPic2 = im2double(rgb2gray(TestPic2));

Temp1 = K_DFT(GrayPic1);
Temp2 = K_DFT(GrayPic2);

AmpTemp1 = abs(Temp1);
PhaseTemp1 = angle(Temp1);
AmpTemp2 = abs(Temp2);
PhaseTemp2 = angle(Temp2);

Switch12 = AmpTemp1 .* exp(1i*PhaseTemp2);
Switch21 = AmpTemp2 .* exp(1i*PhaseTemp1);

InversePic1 = K_IDFT(Switch12);
InversePic2 = K_IDFT(Switch21);

subplot(3,2,1); imshow(TestPic1), title('Original Picture1');
subplot(3,2,2); imshow(TestPic2), title('Original Picture2');
subplot(3,2,3); imshow(GrayPic1), title('Gray Picture1');
subplot(3,2,4); imshow(GrayPic2), title('Gray Picture2');
subplot(3,2,5); imshow(InversePic1), title('Mixture1');
imwrite(InversePic1,"Switch-12.jpeg");
subplot(3,2,6); imshow(InversePic2), title('Mixture2');
imwrite(InversePic2,"Switch-21.jpeg");

%delta1 = im2double(TestPic1) - InversePic2;
%delta2 = im2double(TestPic2) - InversePic1;

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
