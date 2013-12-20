%% Emmanuel Taylor
% Elements of Discrete Signal Analysis
% Lab Assignment 08

function [Y,K,L,R] = compress2(X,M)

	% COMPRESS2 Fixed-length compression by eliminating smallest entries.
	% 	[Y,K,L,R] = COMPRESS2(X,M) determines the indices [K L] containing 
	%	the M absolutely largest entries of a vector X, nulls out the 
	%	remaining entries and also computes the square norm ratio 
	%	between the output vector Y and the input vector X.

% Saving a copy of X because it will be overwritten, calculating the
% absolute value of the entries of the matrix X.
preX = X;
Xabs = abs(X);

% Reshaping matrix X into a single column vector while sorting it in
% descending order. Also marking the M number of greatest values and
% nulling the others to 0.
Xvec = reshape(Xabs, numel(X), 1);
Xvec_sorted = sort(Xvec, 'descend');
Xvec_MG = Xvec_sorted(1:M);
Xvec_MG(M + 1:length(Xvec_sorted)) = 0;

% Iterates through each entry in the vector and determing whether or not it
% is matched with the saved value of X. If so, a 1 will be returned. If
% not, a 0 will be returned. The original value of X is then multiplied to
% this result to create the resulting vector Y.
v = 0;
for i = 1:size(X,1)
    for j = 1:size(X,2)
        l = 0;
        for k = 1:length(Xvec_MG)
            if Xabs(i,j) == Xvec_MG(k)
                l = l + 1;
            end
        end
        
        if l == 0
            X(i,j) = 0;
        end
        
        if l ~= 0 && X(i,j) ~= 0
            v = v + 1;
            preK(v)=i;
            preL(v)=j;
        end
    end
end

% The respective output matrix Y, indices K and L, and the squared norm R.
Y = X;
K = preK';
L = preL';
R=(norm(reshape(Y,numel(Y),1)))^2/(norm(reshape(preX,numel(preX),1)))^2;
