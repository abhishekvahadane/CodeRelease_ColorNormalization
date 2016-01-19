% Beer-Lamber transformation

function [V, VforW]=BLtrans(I)
Ivecd=double(reshape(I,size(I,1)*size(I,2),size(I,3))); 
V=log(255)-log(Ivecd+1);  % V=WH, +1 is to avoid divide by zero

% V with exclusion of white pixels
C=makecform('srgb2lab');
out=applycform(I,C);
luminlayer = out(:,:,1);
% validpoints=[(double(luminlayer(:))/255)<threshold]';
Inew=Ivecd([(double(luminlayer(:))/255)<0.9]',:);     % threshold=0.9
VforW=log(255)-log(Inew+1);
end