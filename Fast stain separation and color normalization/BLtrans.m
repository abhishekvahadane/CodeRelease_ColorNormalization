% Beer-Lamber transformation

function I=BLtrans(I)

I=double(reshape(I,size(I,1)*size(I,2),size(I,3))); 
I=log(255)-log(I+1);  % V=WH, +1 is to avoid divide by zero
end