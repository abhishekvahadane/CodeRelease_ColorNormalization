% Main file to run different color normalization techniques

clear
clc

% Parameters
nstains=2;
lambda=0.02;
addpath(genpath('D:\Dropbox\TUM 1\Report or writing\My Papers\TMI2015\CodeRelease'))

target=imread('G:\Color normalization for JPI\target\PrognosisTMABlock1_A_3_1_H&E.tif');
[Wi, Hi,Hiv]=stainsep(target,nstains,lambda);

%% Define source and target images (Add target and source images to the folder "images")
folder='G:\Color normalization for JPI\source';
list=dir([folder,'\*.tif']);
writefolder='G:\Color normalization for JPI\source_norm\NormalSeparation_0.02';

for k=1:length(list)
source=imread([folder,'\',list(k).name]);


%% Our Method (The techniques is published in ISBI 2015 under the title "STRUCTURE-PRESERVED COLOR NORMALIZATION FOR HISTOLOGICAL IMAGES")
% For queries, contact: abhishek.vahadane@gmail.com, vahadane@iitg.ernet.in
% Source and target stain separation and storage of factors 
% tic
[Wis, His,Hivs]=stainsep(source,nstains,lambda);
% save('source.mat','Wis','His','Hivs')
% save('target.mat','Wi','Hi','Hiv')

% Color normlization
% addpath(genpath('Our Method'))
[our]=SCN(source,Hi,Wi,His);
% time=toc;
imwrite(our,[writefolder,'\',list(k).name(1:end-4),'_norm5','.tif']);
end
%% Other state of art methods

% addpath(genpath('stain_normalization_toolbox by Khan'))

% verbose = 0;   % Do not display result of each method
% 
% [reinhard] = Reinhard( source, target, verbose );   % Reinhard method
% 
% [macenko] = Macenko(source,target, 255, 0.15, 1, verbose); % Macenko method
% currentFolder = pwd;
% cd('KhanApp')                                      
% Khan=khan(source,target);               % Khan method
% cd(currentFolder)
% %% Visuals and write normalized images in the folder "images"
% imwrite(our,'images\Proposed.png');
% imwrite(Khan,'images\khan.png');
% imwrite(reinhard,'images\reinhard.png');
% imwrite(macenko,'images\macenko.png');
% 
% % gt=imread('images\ground truth.png');
% subplot(2,4,2);imshow(source);xlabel('Source')
% subplot(2,4,3);imshow(target);xlabel('Target')
% % subplot(2,4,3);imshow(gt);xlabel('ground truth')
% subplot(2,4,5);imshow(our);xlabel('Proposed')
% subplot(2,4,6);imshow(Khan);xlabel('Khan')
% subplot(2,4,7);imshow(reinhard);xlabel('Reinhard')
% subplot(2,4,8);imshow(macenko);xlabel('Macenko')
% 
