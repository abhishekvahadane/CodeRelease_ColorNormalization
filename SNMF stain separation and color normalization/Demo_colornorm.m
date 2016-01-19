% Main file to run different color normalization techniques

clear
clc
close all 
%% Define source and target images (Add target and source images to the folder "images")
source=imread('images/source1.png');
target=imread('images/target1.png');

nstains=2;
lambda=0.02;  % Use smaller values of the lambda (0.01-0.1) for better reconstruction. however, if the normalized image seems not fine, increase or decrease the value accordingly.

%% Our Method (The techniques is published in ISBI 2015 under the title "STRUCTURE-PRESERVED COLOR NORMALIZATION FOR HISTOLOGICAL IMAGES")
% For queries, contact: abhishek.vahadane@gmail.com, vahadane@iitg.ernet.in
% Source and target stain separation and storage of factors 
tic
[Wis, His,Hivs]=stainsep(source,nstains,lambda);
% save('source.mat','Wis','His','Hivs')
[Wi, Hi,Hiv]=stainsep(target,nstains,lambda);
% save('target.mat','Wi','Hi','Hiv')

% Color normlization
% addpath(genpath('Our Method'))
[our]=SCN(source,Hi,Wi,His);
time=toc;

% Write image to a folder
imwrite(our,'images/norm.png')
%% Visuals
figure;
subplot(131);imshow(source);xlabel('source')
subplot(132);imshow(target);xlabel('target')
subplot(133);imshow(our);xlabel('normalized source')