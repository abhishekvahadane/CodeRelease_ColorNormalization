
function [param]= definePar(nstains,lambda,batch)
param.mode=2;                           % solves for =min_{D in C} (1/n) sum_{i=1}^n (1/2)||x_i-Dalpha_i||_2^2 + ... 
                                         % lambda||alpha_i||_1 + lambda_2||alpha_i||_2^2
param.lambda=lambda;
% param.lambda2=0.05;
param.posAlpha=true;                    % positive stains 
param.posD=true;                        % positive staining matrix
param.modeD=0;                          % {W in Real^{m x n}  s.t.  for all j,  ||d_j||_2^2 <= 1 }
param.whiten=0;                         % Do not whiten the data                      
param.K=nstains;                        % No. of stain = 2
param.numThreads=-1;                    % number of threads
param.iter=200;                         % 20-50 is OK
param.clean=true;
if ~isempty(batch)
    param.batchsize=batch;                 % Give here input image no of pixels for trdiational dictionary learning
end
end