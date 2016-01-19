function [Ws]=get_staincolor_sparsenmf(v, param)

% Learning W through sparse NMF
Ws=mexTrainDL(v',param);

% Arranging H stain color vector as first column and then the second column
% vectors as E stain color vector
Ws = sortrows(Ws',2)';

