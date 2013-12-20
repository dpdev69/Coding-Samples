%% Emmanuel Taylor
% ENEE222 - Discrete Signal Analysis
% Lab Assignment 11

% Creating the base of the pyramid
x = linspace(-1,1,200);
y = linspace(-1,1,200);
[X,Y] = meshgrid(x,y);

% Creating the pyramid on the Z axis. Multiplying it by negative 1.5 to
% have the base of the pyramid sitting at zero.
k = 1.5;
V = max(abs(X), abs(Y));
V = (-k)*V + 1.5;

% Constants used in the equation for a sphere.
h = 0;
j = 0;
r = 1;

% Using the equation of a sphere, we solved for the Z axis by plugging and
% solving for Z. Due to imaginary numbers outside of the sphere, all values
% of Z were made real.
Z = 1.5 - sqrt(r.^2 - (X - h).^2 - (Y - j).^2);
Z = real(Z);

% By taking the min of both Z axes of the Pyramid and the Sphere, we can
% create the pyramid with the hollowed out tip.
FinalZ = min(V,Z);
surf(X,Y,FinalZ)
colormap winter
axis tight
set(gca, 'YTick', [-1 -0.8 -0.6 -0.4 -0.2 0 0.2 0.4 0.6 0.8 1])
set(gca, 'ZTick', [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5])
shading flat
view(70,35)
