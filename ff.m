pkg load image

clear all;
close all;
clc;

nao = '/home/tomato/Pictures/kosaka.jpg';
tecchi = '/home/tomato/Pictures/hirate.jpg';
img = imread(tecchi);
figure(1); imshow(img); title("Asli");

img = rgb2gray(img);
figure(2); imshow(img); title("BW");

[h, t] = size(img);

for i = 1:h
  X(i,:) = fft2(img(i, :));
end

for j = 1:t
  Y(:, j) = fft2(img(:, j));
end

M = Y;
M = fftshift(M);
Ab = abs(M);
Ab = (Ab - min(min(Ab)))./(max(max(Ab))).*255;
figure(3); imshow(Ab); title("Fourier Transform of BW");
