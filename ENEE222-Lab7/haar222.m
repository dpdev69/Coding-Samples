function V = haar222(N)

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
