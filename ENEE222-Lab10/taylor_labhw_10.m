%% Emmanuel Taylor
% ENEE222 - Elements of Discrete Signal Analysis

% Lab Assignment 10
[x, Fs] = wavread('dialtones10.wav');
N = length(x);
Fs
soundsc(x, Fs)
n = 0:N-1;
t = n/Fs;
plot(t, x)
T = 0.27;
Tpause = 0.93;
k = n;
F = (k/N)*Fs;
X = fft(x);
plot(F, abs(X))
