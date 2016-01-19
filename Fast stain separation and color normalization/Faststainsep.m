% Demo for sparse stain separation (SSS)
function [Wi, Hi,Hiv,sepstains]=Faststainsep(I,nstains,lambda)

% Please cite below paper if you use this code: 

% @inproceedings{Vahadane2015ISBI,
% 	Author = {Abhishek Vahadane and Tingying Peng and Shadi Albarqouni and Maximilian Baust and Katja Steiger and Anna Melissa Schlitter and Amit Sethi and Irene Esposito and Nassir Navab},
% 	Booktitle = {IEEE International Symposium on Biomedical Imaging},
% 	Date-Modified = {2015-01-31 17:49:35 +0000},
% 	Title = {Structure-Preserved Color Normalization for Histological Images},
% 	Year = {2015}}

% Contact: vahadane@iitg.ernet.in, abhishek.vahadane@gmail.com
%% input image should be color image
ndimsI = ndims(I);
if ndimsI ~= 3,
    error('colordeconv:InputImageDimensionError', ...
        'Input image I should be 3-dimensional!');
end
rows=size(I,1);cols=size(I,2);

%% add SPAMS library
start_spams;

% Define parameter for SPAMS toolbox dictionary learning
param=definePar(nstains,lambda,[]);

%% Beer-Lamber tranformation
V=BLtrans(I);    % V=WH see in paper
%% Estimate stain color bases + acceleration
Wi=Wfast(I,param);      
Hiv=((Wi'*Wi)\Wi'*V')';     % Pseudo-inverse
Hiv(Hiv<0)=0; 
Hi=reshape(Hiv,rows,cols,param.K);
	%% calculate the color image for each stain
	sepstains = cell(param.K, 1);
	for i = 1 : param.K,
		vdAS =  Hiv(:, i)*Wi(:, i)';
		sepstains{i} = uint8(255*reshape(exp(-vdAS), rows, cols, 3));
    end
    
%     figure;
%     subplot(131);imshow(I)
%     subplot(132);imshow(sepstains{1})
%     subplot(133);imshow(sepstains{2})
end

