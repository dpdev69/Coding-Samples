%% Emmanuel Taylor
% Elements of Discrete Signal Analysis
% Lab Assignment 09

[y, Fs] = wavread('audio09.wav');
N = length(y)
Fs
Y = fft(y);
n = (0:N-1).';
k = n;
plot(k, abs(Y))
title 'Magnitude of DFT Y'
xlabel 'k values'
ylabel 'Y Magnitudes'
grid

% N = 160000 and Fs = 44100

K = 43124;
% K was found by continuously zooming in on the leftmost peak of the signal
% to find out which value of K the signal landed on. It was determined that
% the signal's peak lied on K = 43124.

Y = Y(1:80000);
Y = [Y;zeros(80000,1)];
X = circshift(Y, -K);
x = real(ifft(X));
soundsc(x, Fs)
wavwrite(x, Fs, 'taylor_labhw_09.wav');
