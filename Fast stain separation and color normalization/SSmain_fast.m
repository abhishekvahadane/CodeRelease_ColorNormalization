clear
clc

%% Read WSI 
img = imread('img.tiff');
ysource=size(img,1);
xsource=size(img,2);
sourcechannels=size(img,3);
% img=checkforNSR_2(img); % Remove white region along boundary of stained slide

tic 
gridsize= 10*round(min(xsource,ysource)./100);    % gridsize 10% of the input size
threshold=0.8;                                    % For white regions
patchsize=gridsize;                               
initBias=ceil(patchsize./2)+1;                    % Avoid boundary of specified size

% Add path to the spams toolbox
addpath(genpath('D:\Dropbox\TUM 1\Report or writing\My Papers\TMI\CodeRelease\spams-matlab'));
% start_spams;
% Parameter settings
nstains=2;

param.mode=2;                           % solves for =min_{D in C} (1/n) sum_{i=1}^n (1/2)||x_i-Dalpha_i||_2^2 + ...
% lambda||alpha_i||_1 + lambda_2||alpha_i||_2^2
param.lambda=0.01;
% param.lambda2=0.1;
param.posAlpha=true;                    % positive stains
param.posD=true;                        % positive staining matrix
param.modeD=0;                          % {W in Real^{m x n}  s.t.  for all j,  ||d_j||_2^2 <= 1 }
param.whiten=0;                         % Do not whiten the data
param.K=nstains;                        % No. of stain = 2
param.numThreads=-1;                    % number of threads
param.iter=200;                         % 20-50 is OK
param.verbose='false';
param.batchsize=(patchsize+1)*(patchsize+1);
%% image sampling and W estimation


point_y=initBias:gridsize:ysource-initBias;
point_x=initBias:gridsize:xsource-initBias;
samval=img(point_y,point_x,:);
C=makecform('srgb2lab');
out=applycform(samval,C);
luminlayer = out(:,:,1);
validpoints=[(double(luminlayer)/255)<threshold]';
[grid_y,grid_x]=meshgrid(point_y,point_x);
validgrid_y = grid_y(validpoints==1);
validgrid_x = grid_x(validpoints==1);
patch = uint8(zeros(patchsize+1,patchsize+1,3,length(validgrid_x)));
%samplings=zeros(ysize,xsize);

% visualize patch sampling
figure; imagesc(img);axis off;
hold on; plot(grid_x,grid_y,'b--',grid_x',grid_y','b--');
hold on; plot(validgrid_x,validgrid_y,'r*');

for i=1:length(validgrid_x)
    patch(:,:,:,i)=img(validgrid_y(i)-patchsize/2:validgrid_y(i)+patchsize/2,validgrid_x(i)-patchsize/2:validgrid_x(i)+patchsize/2,:);
    %samplings(validgrid_y(i)-patchsize/2:validgrid_y(i)+patchsize/2,validgrid_x(i)-patchsize/2:validgrid_x(i)+patchsize/2)=1.0;
end
matlabpool
parfor i = 1:length(validgrid_x)
%     patch(:,:,:,i) = nimg(validgrid_y(i)-patchsize/2:validgrid_y(i)+patchsize/2,validgrid_x(i)-patchsize/2:validgrid_x(i)+patchsize/2,:);
%     samplings(validgrid_y(i)-patchsize/2:validgrid_y(i)+patchsize/2,validgrid_x(i)-patchsize/2:validgrid_x(i)+patchsize/2)=1.0;
   [W]=getstainMat(patch(:,:,:,i), param); % two stains
    WS(:,:,i)=W;
end
matlabpool close
% Compute medians
for k=1:nstains
    Wsource(:,k)=[median(WS(1,k,:));median(WS(2,k,:));median(WS(3,k,:))];
end

%Wsource=double(Wsource./repmat([norm(Wsource(:,1)),norm(Wsource(:,2))],3,1));
% 2 stain seperation
% Wsource=double(Wsource./repmat([norm(Wsource(:,1)),norm(Wsource(:,2)),norm(Wsource(:,3))],3,1)); % 3 stain seperation
Wsource=normalize_W(Wsource,nstains);

Ivecd=double(reshape(img,size(img,1)*size(img,2),size(img,3))');
Ivecd=log(255)-log(Ivecd+1);
% Pseudo-inverse to compute H
Hs=(Wsource'*Wsource)\Wsource'*Ivecd;
t=toc;

resizedHs=reshape(Hs',ysource,xsource,nstains);
% % Separated color stains
for k=1:nstains
    WHs{k}=Wsource(:,k)*Hs(k,:);
    colorstains{k}=uint8(255*exp(-reshape(WHs{k}',ysource,xsource,sourcechannels)));
end
clear WHs
% Target recontruction:
imghat=Wsource*Hs;
imgrecon=uint8(255*exp(-reshape(imghat',ysource,xsource,sourcechannels)));
% save data
save([save_dir 'Wsource.mat'],'Wsource');
save([save_dir 'Hs.mat'],'resizedHs');

