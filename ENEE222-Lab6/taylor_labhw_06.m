%% Emmanuel Taylor
% ENEE222 - Elements of Discrete Signal Analysis
% Lab 06

% Part One
% Generating a square X-Y grid.
m = 500;
a = 0:1/m:1;
u = ones(size(a));
X = u.'*a;
Y = a.'*u;

% Equation for a straight line.
W = X > Y;

% Equation for the curved line.
V = floor(X.^2 + Y.^2);

% Equation for the figure
A = rot90(xor(W, V),2);
imshow(flipud(A));

%% Part Two
c = 0;

B = blanks(10);
for i = 0:4^10-1
    S = dec2base(i,4,10);
    S = [S;B];
    S = S(:)';
    A = str2num(S) * 2 + 5;
    Z = zeros(4);
    Z(1,1) = A(1);
    Z(1,2) = A(2);
    Z(1,3) = A(3);
    Z(1,4) = A(4);
    Z(2,1) = A(2);
    Z(2,2) = A(5);
    Z(2,3) = A(6);
    Z(2,4) = A(7);
    Z(3,1) = A(3);
    Z(3,2) = A(6);
    Z(3,3) = A(8);
    Z(3,4) = A(9);
    Z(4,1) = A(4);
    Z(4,2) = A(7);
    Z(4,3) = A(9);
    Z(4,4) = A(10);
    
    % According to this equation, 31,380 out of a total of 4^10 = 1,048,575
    % matrices are singular.
    c = c + (abs(det(Z)) < 0.5);
end
