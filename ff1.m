pkg load image

clear all;
close all;
clc;

nao = '/home/tomato/Pictures/kosaka.jpg';
tecchi = '/home/tomato/Pictures/hirate.jpg';

function spektrum (source)
  img = imread(source);
  %figure(1); imshow(img); title("Asli");
  figure
  subplot(2,3,1); imshow(img); title("Asli");

  bw = rgb2gray(img);
  %figure(2); imshow(img); title("BW");
  subplot(2,3,2); imshow(bw); title("BW");

  bw = im2double(bw);

  F = fft2(bw);
  %figure(3); imshow(F); title("Spektrum Asli");
  subplot(2,3,3); imshow(F); title("Spektrum Asli");

  F2 = log(1+abs(F));
  %figure(4); imshow(F2, []); title("Spektrum Log");
  subplot(2,3,4); imshow(F2, []); title("Spektrum Log");

  Fs = fftshift(F2);
  %figure(5); imshow(Fs, []); title("Spektrum Pusat");
  subplot(2,3,5); imshow(Fs, []); title("Spektrum Pusat");
endfunction

spektrum(nao);
spektrum(tecchi);