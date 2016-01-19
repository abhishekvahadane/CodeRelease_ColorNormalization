function [vecI]=vectorise(I)
vecI=reshape(I,size(I,1)*size(I,2),size(I,3));
end