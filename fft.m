pkg load image

clear all;
close all;
clc;

nao = '/home/tomato/Pictures/kosaka.jpg';
tecchi = '/home/tomato/Pictures/hirate.jpg';

function fourier (source)
  img = imread(source);
  figure
  %figure(1); imshow(img); title("Asli");
  subplot(2,3,1); imshow(img); title("Asli");

  bw = rgb2gray(img);
  %figure(2); imshow(img); title("BW");
  subplot(2,3,2); imshow(bw); title("BW");

  F = fft2(bw);
  S = abs(F);
  %figure(3); imshow(S, []); title("Fourier Transform of BW");
  subplot(2,3,3); imshow(S, []); title("Fourier Transform of BW");

  Fsh = fftshift(F);
  %figure(4); imshow(abs(Fsh), []); title("Centered Fourier Transform of BW");
  subplot(2,3,4); imshow(abs(Fsh), []); title("Centered Fourier Transform of BW");

  S2 = log(1+abs(Fsh));
  %figure(5); imshow(S2, []); title("Log Transformed Image");
  subplot(2,3,5); imshow(S2, []); title("Log Transformed Image");

  F = ifftshift(Fsh);
  f = ifft2(F);
  %figure(6); imshow(f, []); title("Reconstructed Image");
  subplot(2,3,6); imshow(f, []); title("Reconstructed Image");
endfunction

fourier(nao);
fourier(tecchi);