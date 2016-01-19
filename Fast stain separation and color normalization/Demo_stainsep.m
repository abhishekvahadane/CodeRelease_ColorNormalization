% Demo of Fast Sparse Stain Separation (SSS)
clear
close all 
clc 

%% Read input image. We have given three types of images  of size 20k*20k, 6k*6k, and 3k*3k
% I=imread('wsi_20000.tif');
% I=importdata('I_size-6kX6k_to test on_8gb RAM processor.mat'); % For 8 GB RAM processor
% I=importdata('I_size-3kX3k_to test on_4gb RAM processor.mat'); % For 4 GB RAM processor
I=imread('images\source.tiff'); % Just for test on a small image
%% Parameters
nstains=2;    % number of stains
lambda=0.1;   % default value sparsity regularization parameter

if min(size(I,1),size(I,2))<4000
    display('Slow/direct stain separation is running because image resolution is less than 4000')
    str='slow';
else
    str=input('Please specify fast or slow =','s');
end
if str=='fast'
    % Fast tain separation (V=WH)
    display('Fast stain separation is running....')
%     parpool  % Use "matlabpool" instead if older version of MATLAB
    tic;
    [Wi, Hi,Hiv,stains]=Faststainsep(I,nstains,lambda);
    time=toc
%     delete(gcp)
else
    % Slow stain separation
    display('Slow/direct stain separation is running....')
    tic;
    [Wi, Hi,Hiv,stains]=stainsep(I,nstains,lambda);
    time=toc
end

% Visuals (for 2 stains)
figure;
subplot(131);imshow(I);xlabel('Input')
subplot(132);imshow(stains{1});xlabel('stain1')
subplot(133);imshow(stains{2});xlabel('stain2')


