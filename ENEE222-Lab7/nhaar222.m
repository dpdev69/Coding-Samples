function V = nhaar222(N)
% NHAAR222 Normalized Haar wavelet matrix.
% 	V = NHAAR222(N), where N is a positive integer, is an
%	orthonormal square matrix of size MxM, where M is the largest
%	integer power of 2 less than or equal to N. The first column
%	of the matrix is constant, while the remaining columns are
%	Haar wavelets at log2(M) different scales.

K = fix(log2(N)) ;
a = ones(N/2,1) ;
v0 = [a ; a];
v1 = [a ; -a];
V = [v0 v1];
for i=2:K
    v = v1(1:2^(i-1):N);
    v = [v ; zeros(N-length(v),1)];
    V = [V v];
    for j = 1:2^(i-1)-1
        v = circshift(v,2^(K-i+1));
        V = [V v];
    end
end

V = V*diag(1./sqrt(diag(V'*V)));
