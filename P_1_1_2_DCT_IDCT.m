% Project1-1-2 DCT&IDCT
% Name: Yijian Kong
% ID: 518021910160

tic
clear;

TestPic = imread('test2.jpeg'); 
GrayPic = im2double(rgb2gray(TestPic));
DCTPic = K_DCT(GrayPic);
IDCTPic = K_IDCT(DCTPic);
% DCTPic = dct2(GrayPic);
% IDCTPic = idct2(DCTPic);

subplot(2,2,1); 
imshow(TestPic), title('Original Picture');
subplot(2,2,2); 
imshow(GrayPic), title('Gray Picture');
imwrite(GrayPic,"Gray2.jpeg");
subplot(2,2,3); 
imshow(DCTPic), title('DCT Picture');
imwrite(DCTPic,"DCT2.jpeg");
subplot(2,2,4); 
imshow(IDCTPic), title('IDCT Picture');
imwrite(IDCTPic,"IDCT2.jpeg");

toc;

function [DCTPic] = K_DCT(Pic) 
[L,W] = size(Pic);
A = zeros(L,L); 
B = zeros(W,W);
for k = 0 : L - 1
    for i = 0 : L - 1
        A(k + 1,i + 1) = cos((i + 0.5) * pi * k / L);   
    end
end
for k = 0 : W - 1
    for i = 0 : W - 1
        B(k + 1,i + 1) = cos((k + 0.5) * pi * i / W);
    end
end
A(1,:) = A(1,:) ./ sqrt(2);
B(:,1) = B(:,1) ./ sqrt(2);
DCTPic = 2 * A * Pic * B / sqrt(L * W);
end

function [IDCTPic] = K_IDCT(Pic) 
[L,W] = size(Pic);
A = zeros(L,L); 
B = zeros(W,W);
for k = 0 : L - 1
    for i = 0 : L - 1
        A(k + 1,i + 1) = cos((i + 0.5) * pi * k / L);   
    end
end
for k = 0 : W - 1
    for i = 0 : W - 1
        B(k + 1,i + 1) = cos((k + 0.5) * pi * i / W);
    end
end
A(1,:) = A(1,:) ./ sqrt(2);
B(:,1) = B(:,1) ./ sqrt(2);
IDCTPic = 2 * A' * Pic * B' / sqrt(L * W);
end
