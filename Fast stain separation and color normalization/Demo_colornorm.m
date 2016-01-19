% Demo for fast color normalization
clear 
close all 
clc
%% Read source and target Whole slide images (WSIs) 
source=imread('images\source.tiff');
target=imread('images\target.tiff');

%% Fast separation of WSI
nstains=2;
lambda=0.02;

parpool;
[Wis, His,Hivs,stainss]=Faststainsep(source,nstains,lambda);
[Wit, Hit,Hivt,stainst]=Faststainsep(target,nstains,lambda);
delete('gcp')
%%  Stain Linear Normalization
Hso_Rmax = prctile(Hivs,99);   % 95 precentile of values in each column
Hta_Rmax = prctile(Hivt,99);
normfac=(Hta_Rmax./Hso_Rmax);
Hsonorm = Hivs.*repmat(normfac,size(Hivs,1),1);

imgsource_norm = Wit*Hsonorm';
rows=size(source,1);cols=size(source,2);
sourcenorm=uint8(255*exp(-reshape(imgsource_norm',rows,cols,3)));

%% Visuals
figure;
subplot(131);imshow(source);xlabel('source');
subplot(132);imshow(target);xlabel('target');
subplot(133);imshow(sourcenorm);xlabel('normalized source');
