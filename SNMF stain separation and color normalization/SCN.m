function [sourcenorm]=SCN(source,Hta,Wta,Hso)
% Normalize source image to target 

% 
% We provide the open source MATLAB implementation of strucure preserved normalization scheme in the following paper
% to be published in ISBI 2015: 
% 
% Author contact: abhishek.vahadane@gmail.com, vahadane@iitg.ernet.in
%
% BibTex: 
% 
% @inproceedings{Vahadane2015ISBI,
% 	Author = {Abhishek Vahadane and Tingying Peng and Shadi Albarqouni and Maximilian Baust and Katja Steiger and Anna Melissa Schlitter and Amit Sethi and Irene Esposito and Nassir Navab},
% 	Booktitle = {IEEE International Symposium on Biomedical Imaging},
% 	Date-Modified = {2015-01-31 17:49:35 +0000},
% 	Title = {Structure-Preserved Color Normalization for Histological Images},
% 	Year = {2015}}
% 
% Please cite this article if you use it. 
% See instruction.txt for more insights into our algorithm and on how to
% run given code
% 
%
% ******************************************************************************************************

%% Load source and target separations
% load([folder,'1\','source.mat']);
% Hso=Hi; 
% load([folder,'target\','target.mat']);Hta=Hi; Wta=Wi; clearvars -except Hso Hta Wta source

% nstains=size(Wta,2);

%% Color normalization

% Equalize the dynamic range of the source and target gray stains

% dy_Hs(1,:,:) = stretchlim(Hs(1,:)/max(Hs(1,:))).*max(Hs(1,:));
% dy_Hs(2,:,:) = stretchlim(Hs(2,:)/max(Hs(2,:))).*max(Hs(2,:));
% 
% dy_Ht(1,:,:) = stretchlim(Ht(1,:)/max(Ht(1,:))).*max(Ht(1,:));
% dy_Ht(2,:,:) = stretchlim(Ht(2,:)/max(Ht(2,:))).*max(Ht(2,:));
% Hsnorm=Hs./repmat(dy_Hs(:,2),1,size(Hs,2)).*repmat(dy_Ht(:,2),1,size(Hs,2));
Hso=reshape(Hso,size(Hso,1)*size(Hso,2),size(Hso,3));
Hso_Rmax = prctile(Hso,99);   % 95 precentile of values in each column
Hta=reshape(Hta,size(Hta,1)*size(Hta,2),size(Hta,3));
Hta_Rmax = prctile(Hta,99);
normfac=(Hta_Rmax./Hso_Rmax);
Hsonorm = Hso.*repmat(normfac,size(Hso,1),1);

% Normalize source

Ihat=Wta*Hsonorm';

% Back projection into spatial intensity space (Inverse Beer-Lambert space)

sourcenorm=uint8(255*exp(-reshape(Ihat',size(source,1),size(source,2),size(source,3))));
end
%% Visuals
%
% figure;
% subplot(2,4,1);imshow(source);xlabel('source')
% subplot(2,4,2);imshow(sourcerecon);xlabel('Reconstrued source from separated components')
% subplot(2,4,3);imshow(colorstains{1});xlabel('source stain1 color')
% subplot(2,4,4);imshow(colorstains{2});xlabel('source stain2 color')
% subplot(2,4,5);imshow(target);xlabel('target')
% subplot(2,4,6);imshow(sourcenorm);xlabel('Normalized source')
% subplot(2,4,7);imshow(resizedHs(:,:,1));xlabel('H matrix stain 1')
% subplot(2,4,8);imshow(resizedHs(:,:,2));xlabel('H matrix stain 2')


% imwrite(sourcerecon,'source1recon.png','compression','none')
% imwrite(colorstains{1},'source1stain1.png','compression','none')
% imwrite(colorstains{2},'source1stain2.png','compression','none')
% imwrite(colorstaint{1},'targetstain1.png','compression','none')
% imwrite(colorstaint{2},'targetstain2.png','compression','none')
% imwrite(sourcenorm,'norm2.tif','compression','none')
% imwrite(targetrecon,'targetrecon.png','compression','none')
% imwrite(sourcebinary,'source1Sampling.png','compression','none')
%% Save data
% save source, target, Hgray density maps and color stains, Reconstructed
% image after by using separated WH
% save('source1.mat','source','Ws','Wsp','resizedHs','sourcerecon')
% save('target.mat','target','Wt','Wtp','resizedHt','targetrecon')
