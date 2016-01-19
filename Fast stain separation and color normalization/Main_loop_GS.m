% Main file to run different color normalization techniques

clear
clc

% Parameters
nstains=2;
lambda=0.05;
addpath(genpath('D:\Dropbox\TUM 1\Report or writing\My Papers\TMI2015\CodeRelease'))

target=imread('G:\Color normalization for JPI\target\PrognosisTMABlock1_A_3_1_H&E.tif');
[Wit, Hit,Hivt,stainst]=Faststainsep(target,nstains,lambda);

%% Define source and target images (Add target and source images to the folder "images")
folder='G:\Color normalization for JPI\source';
list=dir([folder,'\*.tif']);
writefolder='G:\Color normalization for JPI\source_norm\GridSampling_0.05';

for k=1:length(list)


%% Our Method (The techniques is published in ISBI 2015 under the title "STRUCTURE-PRESERVED COLOR NORMALIZATION FOR HISTOLOGICAL IMAGES")
% For queries, contact: abhishek.vahadane@gmail.com, vahadane@iitg.ernet.in
% Source and target stain separation and storage of factors 
% tic
source=imread([folder,'\',list(k).name]);
[Wis, His,Hivs,stainss]=Faststainsep(source,nstains,lambda);
% save('source.mat','Wis','His','Hivs')
% save('target.mat','Wi','Hi','Hiv')

%%  Stain Linear Normalization
Hso_Rmax = prctile(Hivs,99);   % 95 precentile of values in each column
Hta_Rmax = prctile(Hivt,99);
normfac=(Hta_Rmax./Hso_Rmax);
Hsonorm = Hivs.*repmat(normfac,size(Hivs,1),1);

imgsource_norm = Wit*Hsonorm';
rows=size(source,1);cols=size(source,2);
sourcenorm=uint8(255*exp(-reshape(imgsource_norm',rows,cols,3)));
imwrite(sourcenorm,[writefolder,'\',list(k).name(1:end-4),'_norm','.tif']);
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