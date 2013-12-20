function [y,J,r] = compress1(x,M)

% COMPRESS1 Fixed-length compression by eliminating smallest entries.
% 	[Y,J,R] = COMPRESS1(X,M) determines the indices J containing 
%	the M absolutely largest entries of a vector X, nulls out the 
%	remaining entries and also computes the square norm ratio 
%	between the output vector Y and the input vector X.

		M = min(M,length(x)) ;
		xabs = abs(x) ;
		[temp, J] = sort(xabs,'descend') ;
		J = J(1:M) ;
		I = reshape(1:length(x),size(x)) ;
		y = x.*(ismember(I,J)) ;
		r = (norm(y)/norm(x))^2 ;
