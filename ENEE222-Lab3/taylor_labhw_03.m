%% Emmanuel Taylor
% ENEE222 - Elements of Discrete Signal Analysis
% Lab Assignment 3

S = [];
T = [];

for a = -2:0.05:2
    for b = -2:0.05:2
        z = a + j*b;
        v = 0;
        vec = [0 0];
        n = 0;
        while (abs(v) <= 10^6) && (length(vec) <= 1002)
            u = z^n;
            v = -0.6*vec(n+2) - 0.5*vec(n+1) + u;
            vec = [vec v];
            n = n + 1;
        end
        if (n == 1001) && (abs(v) <= 10^6)
            S = [S z];
        else
            T = [T z];
        end
    end
end

figure;
plot(S, 'o')
xlabel 'Discrete Time'
ylabel 'Values'
title 'S Vector Plot'

figure;
plot(T, 'x')
xlabel 'Discrete Time'
ylabel 'Values'
title 'T Vector Plot'

figure; hold on
plot(T, 'x')
plot(S, 'o')
xlabel 'Discrete Time'
ylabel 'Values'
title 'T and S Vector Plot'
