function [Hs,iHs,Irecon] = estH(v, Ws, param,nrows,ncols)
% Hs: Gray scale density maps    
% iHs: Color image of separated stains 
% Irecon: Reconstructed stained image from separated components

% v=WH
% Ws: Learned bases
% param: SPAMS library 
%%
    param.pos=1;         % Positivity constrain on H 
    Hs_vec=mexLasso(v',Ws,param)';
    Hs_vec=full(Hs_vec);
    
    % OR use non-negative pseudo-inverese
%     Hs_vec=((Ws'*Ws)\Ws'*v')';     % Pseudo-inverse
%     Hs_vec(Hs_vec<0)=0;
    
    %% reshape to the original image size and reconstruct to
    %  intensity
    Hs = reshape(Hs_vec, nrows, ncols, param.K);	% density of A
   
	%% calculate the color image for each stain
	iHs = cell(param.K, 1);
	for i = 1 : param.K,
		vdAS =  Hs_vec(:, i)*Ws(:, i)';
		iHs{i} = uint8(255*reshape(exp(-vdAS), nrows, ncols, 3));
	end
	
	%% calculate the reconstruction
	Irecon = Hs_vec*Ws';
	Irecon = uint8(255*reshape(exp(-Irecon), nrows, ncols, 3));
end


