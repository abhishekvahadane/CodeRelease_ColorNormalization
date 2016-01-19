function [Wsource]=Wfast(img, param)

ysource=size(img,1);
xsource=size(img,2);

% Setting for patch sampling
gridsize= 20*round(min(xsource,ysource)./100);    % gridsize 10% of the input size, tune it! 
threshold=0.9;                                    % For white regions
patchsize=round(gridsize*1.3/2);                               
initBias=ceil(patchsize/2)+1;                    % Avoid boundary of specified size

%% image sampling and fast W estimation

% Grid sampling at non-white regions 

point_y=initBias:patchsize:ysource-initBias;
point_x=initBias:patchsize:xsource-initBias;
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

parfor i=1:length(validgrid_x)
    patch=img(validgrid_y(i)-patchsize/2:validgrid_y(i)+patchsize/2,validgrid_x(i)-patchsize/2:validgrid_x(i)+patchsize/2,:);
    %samplings(validgrid_y(i)-patchsize/2:validgrid_y(i)+patchsize/2,validgrid_x(i)-patchsize/2:validgrid_x(i)+patchsize/2)=1.0;
    [WS(:,:,i)]=getstainMat(patch, param);

end
% parpool
% parfor i = 1:length(validgrid_x)
%    [WS(:,:,i)]=getstainMat(patch(:,:,:,i), param);
%     WS(:,:,i)=W;
% end
% delete(gcp)
% Compute medians
nstains=param.K;
for k=1:nstains
    Wsource(:,k)=[median(WS(1,k,:));median(WS(2,k,:));median(WS(3,k,:))];
end

Wsource=normalize_W(Wsource,nstains);
Wsource = sortrows(Wsource',3)';  %  Sorting of color bases, comment if not required

end

