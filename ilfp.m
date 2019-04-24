pkg load image

clear all;
close all;
clc;

nao = '/home/tomato/Pictures/kosaka.jpg';
tecchi = '/home/tomato/Pictures/hirate.jpg';

function [U,V]=dftuv(M,N)
u=0:(M-1);
v=0:(N-1);

idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>N/2);
v(idy)=v(idy)-N;

[V,U]=meshgrid(v,u);
endfunction

function H = lpfilter(type, M, N, D0, n)
%LPFILTER Computes frequency domain lowpass filters
%   H = LPFILTER(TYPE, M, N, D0, n) creates the transfer function of
%   a lowpass filter, H, of the specified TYPE and size (M-by-N).  To
%   view the filter as an image or mesh plot, it should be centered
%   using H = fftshift(H).
%
%   Valid values for TYPE, D0, and n are:
%
%   'ideal'    Ideal lowpass filter with cutoff frequency D0.  n need
%              not be supplied.  D0 must be positive
%
%   'btw'      Butterworth lowpass filter of order n, and cutoff D0.
%              The default value for n is 1.0.  D0 must be positive.
%
%   'gaussian' Gaussian lowpass filter with cutoff (standard deviation)
%              D0.  n need not be supplied.  D0 must be positive.

% Use function dftuv to set up the meshgrid arrays needed for 
% computing the required distances.
[U, V] = dftuv(M, N);

% Compute the distances D(U, V).
D = sqrt(U.^2 + V.^2);

% Begin fiter computations.
switch type
case 'ideal'
   H = double(D <=D0);
case 'btw'
   if nargin == 4
      n = 1;
   end
   H = 1./(1 + (D./D0).^(2*n));
case 'gaussian'
   H = exp(-(D.^2)./(2*(D0^2)));
otherwise
   error('Unknown filter type.')
end
endfunction

function g = dftfilt(f, H)
%DFTFILT Performs frequency domain filtering.
%   G = DFTFILT(F, H) filters F in the frequency domain using the
%   filter transfer function H. The output, G, is the filtered
%   image, which has the same size as F.  DFTFILT automatically pads
%   F to be the same size as H.  Function PADDEDSIZE can be used to
%   determine an appropriate size for H.
%
%   DFTFILT assumes that F is real and that H is a real, uncentered
%   circularly-symmetric filter function. 

%   Copyright 2002-2004 R. C. Gonzalez, R. E. Woods, & S. L. Eddins
%   Digital Image Processing Using MATLAB, Prentice-Hall, 2004
%   $Revision: 1.5 $  $Date: 2003/08/25 14:28:22 $

% Obtain the FFT of the padded input.
F = fft2(f, size(H, 1), size(H, 2));

% Perform filtering. 
g = real(ifft2(H.*F));

% Crop to original size.
g = g(1:size(f, 1), 1:size(f, 2));
endfunction

  img = imread(nao);
  %figure(1); imshow(img); title("Asli");
  figure
  subplot(2,3,1); imshow(img); title("Asli");

  bw = rgb2gray(img);
  %figure(2); imshow(img); title("BW");
  subplot(2,3,2); imshow(bw); title("BW");

  bw = im2double(bw);
  [M, N] = size(bw);
  F = fft2(bw);
  %figure(3); imshow(F); title("Spektrum Asli");
  subplot(2,3,3); imshow(F); title("Spektrum Asli");
  
  D0 = 20;
  
  Li = lpfilter("ideal", M, N, D0);
  fli = dftfilt(bw, Li);

  F2 = log(1+abs(F));
  %figure(4); imshow(F2, []); title("Spektrum Log");
  subplot(2,3,4); imshow(F2, []); title("Spektrum Log");

  Fs = fftshift(log(1+abs(fft2(fli))));
  %figure(5); imshow(Fs, []); title("Spektrum Pusat");
  subplot(2,3,5); imshow(fftshift(Li)); title("ILPF, D0 = 20");
  subplot(2,3,6); imshow(Fs, []); title("Spektrum Hasil");
  
  figure
  imshow(fli);