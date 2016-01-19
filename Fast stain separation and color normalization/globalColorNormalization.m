clear
sourceimage_name = 'source_6';
targetimage_name = '18-12';
source_dir = ['testimages_2stains_proposedCN/G' sourceimage_name '/'];
target_dir = ['testimages_2stains_proposedCN/G' targetimage_name '/'];
imgsource = imread([source_dir  sourceimage_name '.jpg']);
% imgsource=imresize(imgsource,[5045 6555]);
ysource=size(imgsource,1);
xsource=size(imgsource,2);
% load([source_dir 'Wsource.mat']);
% Wsource = Wsource;
Wsource=importdata([source_dir 'Wsource.mat']);
Hsource=importdata([source_dir 'Hs.mat']);
Hsource = reshape(Hsource,[],2);
% load([target_dir 'Wsource.mat']);
% Wtarget = Wsource;
Wtarget=importdata([target_dir 'Wsource.mat']);
Htarget=importdata([target_dir 'Hs.mat']);
% load([target_dir 'Hs.mat']);
Htarget = reshape(Htarget,[],2);
% clear Hs;

% normalize a source stain

% Hsource_max = prctile(Hsource,90);
% Htarget_max = prctile(Htarget,90);
% Hsource_corr = Htarget_max./Hsource_max;
% Hsource_norm = bsxfun(@times,Hsource,Hsource_corr); 
Hsource_max = prctile(Hsource(:,2),95);
Htarget_max = prctile(Htarget(:,2),95);
Hsource_norm = Hsource;
Hsource_norm(:,2) = Hsource(:,2).*Htarget_max./Hsource_max;

imgsource_norm = Wtarget*Hsource';
imgsource_norm=uint8(255*exp(-reshape(imgsource_norm',ysource,xsource,3)));
imgsource_norm2 = Wtarget*Hsource_norm';
imgsource_norm2=uint8(255*exp(-reshape(imgsource_norm2',ysource,xsource,3)));
my_3image_compare_tool(imgsource,imgsource_norm,imgsource_norm2);

imwrite(imgsource_norm,['testimages_2stains_proposedCN/G' ,sourceimage_name, '/','imagesource_norm1.png'])
imwrite(imgsource_norm2,['testimages_2stains_proposedCN/G' ,sourceimage_name, '/','imagesource_norm2.png'])
