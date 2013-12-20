%% Emmanuel Taylor - 111615834
%% Lab Assignment 04

% Loading the chirp.mat file and storing the length in N.
load chirp
N = length(chirp);
n = 1:N;

% Delaying of the original chirp file by one sample.
delchirp = [0 chirp(1:N-1)];

% A new vector C stores all the signchanges that occur and signchanges
% converts the vector into a logical vector. Next, no_halfcycles uses the
% cumsum on signchanges to retrieve the cumulative number of signchanges
% that occur.
C = chirp .* delchirp;
signchanges = C < 0;
no_halfcycles = cumsum(signchanges);

% Plot of no_halfcycles versus n
plot(no_halfcycles, n)
xlabel 'n'
ylabel 'no halfcycles'
title 'Plot of No Halfcycles versus n'
grid

% Our X and Y expressions for use with the polyfit function.
Y = 2*n./(no_halfcycles);
X = n/N;

% Due to the erratic behavior of X and Y for the first half of each vector,
% we will only use the second half of both vectors in the polyfit function.
Ysub = Y(length(Y)/2:length(Y));
Xsub = X(length(X)/2:length(X));
constants = polyfit(Xsub,Ysub,2);

% The constants returned by polyfit are a = 15, b = -12, and c = 10.
my_v = n./(15 + -12*X + 10*X.^2);
my_chirp = cos(2*pi*my_v);
save taylor_labhw_04 my_chirp
