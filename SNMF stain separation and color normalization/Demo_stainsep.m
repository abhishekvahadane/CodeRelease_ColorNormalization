% Demo of Sparse Stain Separation (SSS)
clear 
clc
close all

% Read input image
I=imread('images\he.png');

% Parameters
nstains=2;    % number of stains
lambda=0.1;   % default value sparsity regularization parameter, 
% lambda=0 equivalent to NMF
tic;
% Stain separation (V=WH)
[Wi, Hi,Hiv,stains]=stainsep(I,nstains,lambda);
time=toc
% Visuals (for 2 stains)
figure;
subplot(131);imshow(I);xlabel('Input')
subplot(132);imshow(stains{1});xlabel('stain1')
subplot(133);imshow(stains{2});xlabel('stain2')


