% Project1-2 DCT 8*8 Block
% Name: Yijian Kong
% ID: 518021910160

tic
clear;

TestPic = imread('test2.jpeg');
GrayPic = im2double(rgb2gray(TestPic));

[m,n]=size(GrayPic);

fun1 = @(block_struct) K_DCT(block_struct.data);
fun2 = @(block_struct) K_IDCT(block_struct.data);

Blp1 = blockproc (GrayPic,[8,8],fun1);

mask1 = [1 1 1 1 1 1 0 0;
    1 1 1 1 1 0 0 0;
    1 1 1 1 0 0 0 0;
    1 1 1 0 0 0 0 0;
    1 1 0 0 0 0 0 0;
    1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;];
DCT1 = blkproc(Blp1,[8,8],'P1.*x',mask1);
IDCT1 = blockproc (DCT1,[8,8],fun2);

mask2 = [1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;];
DCT2 = blkproc(Blp1,[8,8],'P1.*x',mask2);
IDCT2 = blockproc (DCT2,[8,8],fun2);

subplot(2,2,1); imshow(TestPic), title('Original Picture');
subplot(2,2,2); imshow(GrayPic), title('Gray Picture');
subplot(2,2,3); imshow(IDCT1), title('8*8-21 DCT Picture');
imwrite(IDCT1,"DCT-21.jpeg");
subplot(2,2,4); imshow(IDCT2), title('8*8-1 DCT Picture');
imwrite(IDCT2,"DCT-1.jpeg");

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
