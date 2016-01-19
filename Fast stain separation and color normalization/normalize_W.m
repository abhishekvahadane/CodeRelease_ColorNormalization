
function [W]=normalize_W(W,k)

if k==2
    % 2 stain
    W=double(W./repmat([norm(W(:,1)),norm(W(:,2))],3,1));
elseif k==3
    % 3 stains
    W=double(W./repmat([norm(W(:,1)),norm(W(:,2)),norm(W(:,3))],3,1)); % 3 stain seperation
end
end