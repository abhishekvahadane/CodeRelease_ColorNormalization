function [Ws]=getstainMat(I, param)
% Source Input
% I : Patch for W estimation

Ivecd=BLtrans(I);    % Beer-Lamber law
%% step 2: Sparse NMF factorization (Learning W; Ivecd=WH)
Ws=mexTrainDL(Ivecd',param);

%% Label the columns to be Hematoxylin and eosin
Ws = sortrows(Ws',3)';
