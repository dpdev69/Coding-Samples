%% Emmanuel Taylor
% ENEE222 - Elements of Discrete Signal Analysis
% September 17, 2013
% Lab Assignment 02

% Part One
% Evaluate the signal vector x which contains samples of the sinusoid
% x(t) = cos(7*pi*t/8) for t = -20:0.01:20. Plot x against t in the first
% subplot. Calculate the number of entries in the vector x, and write the
% results in the comments.
Ts = 0.01;
t = -20:Ts:(20-Ts);
x = cos(7*pi*t/8);
subplot(3,1,1)
suptitle('Lab Assignment 02')
plot(t, x)
grid
title('Sinusoid Graph Part One')

% The number of entries in the vector x is: 4000 entries.

% Part Two
% Type "help bartlett" to read the documentation of the function BARTLETT.
% Use the command w = bartlett(N) where N takes a suitable value, to
% generate a vector w having the same length as x in part (i). Plot w
% against t in the second subplot.
arraylength = length(x)
N = 4000;
subplot(3,1,2)
w = bartlett(N);
plot(t, w)
grid
title('Barlett Function Part Two')
ylabel('Signal')

% Part Three
% Using the transpose operator, and element-by-element multiplication
% as needed, "apply" the Bartlett window w to x. This means multiply each 
% element of x by the corresponding entry of w. Denote the resulting vector
% by y. Plot y in the third subplot.
subplot(3,1,3)
y = x' .* w;
plot(t, y)
grid
title('Bartlett Function Application')
xlabel('Time')
