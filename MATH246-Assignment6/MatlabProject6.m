%% Matlab Project 6 Problem Set F
% Emmanuel Taylor, Kenneth Bryant, and Whitney Wilson
% Differential Equations for Scientists and Engineers
% Sections: 0221 and 0231
% May 7, 2013

%% Problem 2 Part 
% In this problem, we study three systems of equations taken from Boyce &
% DiPrima. x' = (2 -1;1 -2)x (Problem 5, Section 7.5), x' = (2 -5/2;9/5
% -1)x (Problem 4, Section 7.6), and x' = (2 -4;1 -1)x  (Problem 1, Section
% 7.8).

% Use MATLAB to find the eigenvalues and eigenvectors of each linear
% system. Use your results to write down the general solution of the
% system.
syms x y; warning off
A = [-2 1;1 -2]
[xi, R] = eig(sym(A))
% x(t) = c1*[-1;1]*exp(-3t) + c2*[1;1]*exp(-t)

B = [2 -5/2;9/5 -1]
[yi, T] = eig(sym(B))
% u(t) = exp(-t)*([5/6, 1]*sin(t) + [5/6, 0]*cos(t))
% v(t) = exp(-t)*([5/6, 1]*cos(t) - [5/6, 0]*sin(t))

C = [3 -4;1 -1]
[zi, E] = eig(sym(C))
M = [2 -4; 1 -2];
eta = M\zi
% x(t) = c1*[2;1]*exp(t) + c2*([2;1]*t*exp(t) + [1;0]*exp(t))

%% Problem 2 Part B
% For each system, find the general solution using dsolve, and plot several
% trajectories. On your graphs, draw the eigenvectors (if relevant), and
% indicate the direction of increasing time on the trajectories. State the
% type and stability of the origin as a critical point. You may find that
% the quality of your portraits can be enhanced by modifying the t-interval
% or the range of the values assumed by the initial data.
func1 = 'Dx = -2*x + y, Dy = x - 2*y, x(0) = a, y(0) = b';
[x1, y1] = dsolve(func1, 't');
xf = @(t, a, b) eval(vectorize(x1));
yf = @(t, a, b) eval(vectorize(y1));
figure; hold on
t = -5:0.2:5;
for a = -5:5
    for b = -5:5
        plot(xf(t, a, b), yf(t, a, b), 'color', 'r')
    end
end
axis([-10 10 -10 10])
xlabel t, ylabel y
title 'Problem 2 Graph - Problem 1'
hold off
% The origin of this graph is a clockwise twist source.

func2 = 'Dx = 2*x - 5*y/2, Dy = 9*x/5 - y, x(0) = a, y(0) = b';
[x2, y2] = dsolve(func2, 't');
xf = @(t, a, b) eval(vectorize(x2));
yf = @(t, a, b) eval(vectorize(y2));
figure; hold on
t = -5:0.2:5;
for a = -5:5
    for b = -5:5
        plot(xf(t, a, b), yf(t, a, b), 'color', 'r')
    end
end
axis([-10 10 -10 10])
xlabel t, ylabel y
title 'Problem 2 Graph - Problem 2'
hold off
% The origin of this graph is an attracting counterclockwise twist source.

func3 = 'Dx = 3*x - 4*y, Dy = -x - y, x(0) = a, y(0) = b';
[x3, y3] = dsolve(func3, 't');
xf = @(t, a, b) eval(vectorize(x3));
yf = @(t, a, b) eval(vectorize(y3));
figure; hold on
t = -5:0.2:5;
for a = -5:5
    for b = -5:5
        plot(xf(t, a, b), yf(t, a, b), 'color', 'r')
    end
end
axis([-10 10 -10 10])
xlabel t, ylabel y
title 'Problem 2 Graph - Problem 3'
hold off
% The origin of this graph is repelling because this is a saddle point.

%% Problem 3 Part A
% Use eig to find the eigenvalues and eigenvectors of the following
% systems. Use the eigenvalues and eigenvectors to write down the general
% solutions. Let x(t) = (x(t), y(t)). Determine the possible limiting
% behavior of x(t), of y(t), and of x(t)/y(t) as t approaches positive
% infinity.
A = [3 -1;1 -2]
[xi, R] = eig(sym(A))

% x(t) = c1*[5/2 - 21^(1/2)/2;1]*exp((1/2 - 21^(1/2)/2)t) + c2[21^(1/2)/2 +
% 5/2;1]*exp((21^(1/2)/2 + 1/2)t)
% The solution will approach zero if y(t) increases faster than x(t) for
% x(t)/y(t) and approach positive infinity if y(t) increases at a slower
% rate than x(t). These two solutions could approach either zero or
% positive infinity depending on whether the exponents attached to their
% eigenvectors is positive or negative.

%% Problem 3 Part B
% Use eig to find the eigenvalues and eigenvectors of the following
% systems. Use the eigenvalues and eigenvectors to write down the general
% solutions. Let x(t) = (x(t), y(t)). Determine the possible limiting
% behavior of x(t), of y(t), and of x(t)/y(t) as t approaches positive
% infinity.
A = [3 -3;3 -2]
[xi, R] = eig(sym(A))

% x(t) = c1[5/6 - (11^(1/2)*i)/6;1]*exp((1/2 - (11^(1/2)*i)/2)t) + c2[ 5/6
% + (11^(1/2)*i)/6;1]*exp(( 1/2 + (11^(1/2)*i)/2)t)

%% Problem 3 Part C
% Use eig to find the eigenvalues and eigenvectors of the following
% systems. Use the eigenvalues and eigenvectors to write down the general
% solutions. Let x(t) = (x(t), y(t)). Determine the possible limiting
% behavior of x(t), of y(t), and of x(t)/y(t) as t approaches positive
% infinity. Find the solution with the initial condition x(0) = (7; 5; 5).
A = [-2 -1 2;0 4 5;0 -1 0]
[xi, R] = eig(sym(A))
b = [7;5;5]
c = xi\b

% x(t) = (5/2 - (15*i)/2)*[1;i-2;1]*exp(2-i) + ((15*i)/2 + 
% 5/2)*[1;-i-2;1]*exp(i+2)+ 2*[1;0;0]*exp(-2)

%% Problem 3 Part D
% Now solve the initial value problem in Part C with dsolve and compare
% the answer with the solution you obtained in Part C.
syms x y z t
[x,y,z] = dsolve('Dx = -2*x-y+2*z','Dy = 4*y+5*z','Dz = -y','x(0)=7','y(0)=5','z(0)=5','t')

%% Problem 5 Part A
% Here we reconsider the pendulum models examined in Problems 3-6 of
% Problem Set D. (See also the discussion in Sections 9.2 and 9.3 of Boyce
% & DiPrima. Consider first the undamped pendulum. theta" + sin(theta) = 0,
% theta(0) = 0, theta'(0) = b. Let x = theta and y = theta'; then x and y
% satisfy the system. x' = y; y' = -sin(x), x(0) = 0; y(0) = b. Solve this
% system numerically and plot, on a single graph, the resulting
% trajectories for the initial velocities b - 0.5, 1, 1.5, 2, 2.5. Use a
% positive time range (e.g., 0 <= t <= 15), and use axis equal to improve
% your pictures.
figure; hold on
func3 = @(t, x) [x(2); -sin(x(1))];
for b = 0.5:0.5:2.5
    [t, xa] = ode45(func3, [0 15], [0 b]);
    plot(xa(:,1), xa(:,2), 'color', 'r', 'linewidth', 2)
end
xlabel t, ylabel y
title 'Problem 5 Part A Graph'
axis equal
hold off

%% Problem 5 Part B
% Based on your pictures in Part A, describe physically what the pendulum
% seems to be doing in the three cases. theta'(0) = 1.5, 2, and 2.5

% When b = 1.5, the pendulum swings back and forth without leaving its
% original path, rotating more than 180 degrees in one direction.

% When b = 2.0, the pendulum reaches the top edge of the trajectory,
% however it stays and never leaves the orbit still swinging back.

% When b = 2.5, it swings past the top, and never swings back in the
% opposite direction leaving it in elliptical orbit.

%% Problem 5 Part C
% The energy of the pendulum is defined as the sum of kinetic energy
% (theta')^2/2 and potential energy 1 - cos(theta), so E = (1/2)(theta')^2
% + 1 - cos(theta) = (1/2)y^2 + 1 - cos(x). Show, by taking the derivative
% dE/dt, that E is constant when theta(t) is a solution to the equation.
% What basic physical principle does this represent?

% E = y^2/2 + 1 - cos x
% dE/dt = y dy/dt + sin x dx/dt
% set dx/dt = y, dy/dt = -sin x for solution
% dE/dt = y(-sin x) + (sin x)(y) = 0
% Since dE/dt is 0, E is constant, which demonstrates the conservation of
% energy. Enet = K + U which equals 0

%% Problem 5 Part D
% Use ezcontour to plot the level curves for the energy. Choose the x and y
% ranges according to where most of the solutions from Part A lie. Explain
% how your picture is related to the trajectory plot from Part A.
figure; hold on
eqn1 = '1 - cos(x) + y^2/2';
efunc = @(x, y) eval(vectorize(eqn1));
cvals = efunc(0, 0.5:0.2:2.5);
[X Y] = meshgrid(-3.5:0.1:3.5, -3.5:0.1:3.5);
contour(X, Y, efunc(X, Y), cvals)
xlabel t, ylabel y
title 'Problem 5 Part D Graph'
hold off

% The countour plot in this part is very similar to the plot of Part A. The
% figure shows that at low energy levels and for those that are more in the
% center of the graph, the pendulum swing stays in the orbit as expected.
% At high energy levels, the orbit gets broken and the pendulum swings past
% it.

%% Problem 5 Part E
% If the pendulum reaches the upright position (i.e., theta = pi), what
% must be true of the energy? Now explain why there is a critical value E
% sub zero of the energy, below which the pendulum swings back and forth
% without reaching the upright position, and above which it swings overhead
% and continues to revolve in the same direction. What is the critical
% value E sub 0? What is the value of b corresponding to E sub 0? What do
% you expect the pendulum to do when b has this critical value? What did
% the plot in Part A show? Explain.

% In order to reach upright position, the pendulum's kinetic energy must be
% greater than the potential energy at that position which means more
% initial energy. This is why upright position is only reached for certain
% values of initial energy. This is shown in the contour plot.

% At critical values E0, the total energy equals the potential energy at
% the upright positions. After plugging x = 0, b = y, and E = 2, E0 will
% equal 1 - cos(pi) + (b^2)/2, therefore, b = 0 and E0 = 2. When b = 0, the
% pendulum reaches upright position but does not swing past it. This is
% also shown in the plot of Part A.

%% Problem 5 Part F
% Now consider the damped pendulum theta" + 0.5*theta' + sin(theta) = 0.
% theta(0) = 0, theta'(0) = b. Numerically solve the corresponding first
% order system (which you must determine) and plot the resulting
% trajectories for the initial velocities b = 0.5, 1, 1.5, ... , 6. You
% will notice that each of the trajectories in your graph tend toward
% either the critical point (0, 0) or the critical point (2pi, 0). Explain
% what this means physically. There is a value for b sub 0 for which the
% trajectory tends toward the critical point (pi, 0). Estimate, up to
% two-decimal accuracy, the value of b sub 0. What would this correspond to
% physically?

% The  1st order system is x' = y, y' = -sin x - y/2
figure; hold on
f = @(t, x) [x(2); -sin(x(1))-x(2)/2];
for b = 0.5:0.5:6
    [t, xa] = ode45(f, [0 15], [0 b]);
    plot(xa(:,1), xa(:,2), 'color', 'r', 'linewidth', 2)
end
xlabel t, ylabel y
title 'Problem 5 Part F(1) Graph'
axis equal
hold off

% The trajectories tending to occur towards (0, 0) or (2pi, 0) mean that
% the will eventually stop at the original position. The trajectories at
% the 2pi mark stop after making one full revolution.

figure; hold on
f = @(t, x) [x(2); -sin(x(1))-x(2)/2];
for b = 3.085:0.005:3.09
    [t, xa] = ode45(f, [0 15], [0 b]);
    plot(xa(:,1), xa(:,2), 'color', 'r', 'linewidth', 2)
end
xlabel t, ylabel y
title 'Problem 5 Part F(2) Graph'
axis equal
hold off

% The value of b0 falls between 3.085 and 3.09 so this makes 3.09 a good
% estimate. This is similar to a case where the pendulum reaches upright
% position and remains in that position afterward.

%% Problem 5 Part G
% Recall the energy defined in Part C. Compute E^t and determine which of
% the following are possible. (1) E is increasing, (2) E is decreasing, (3)
% E is constant. Explain how the possibilities are reflected in the
% solutions to Part F.

% E = y^2/2 + 1 - cos x
% dE/dt = y dy/dt + sin x dx/dt = y (-sin x - y/2) + y sin x = -y^2/2

% Because dE/dt is less than or equal to zero, 2 and 3 are possible. Energy
% can only be constant or it can decrease. It is impossible for it to
% decrease because dE/dt will never be positive. As shown in Part F, all
% initial conditions except one start with an initial velocity approach
% zero energy with increasing time.

%% Problem 7 Part A
% Consider the competing species model (Boyce & DiPrima, Problem 4, Section
% 9.4) dx/dt = x(1.5 - 0.5x - y); dy/dt = y(0.75 - 0.125y - y) For x,y > 0.
% Find all critical points of the system. At each critical point, calculate
% the corresponding linear system and find the eigenvalues of the
% coefficient matrix; then identify the type and stability of each critical
% point. 

% Finding Critical Points
syms x y
syst1 = x*(1.5-0.5*x-y);
syst2 = y*(0.75-0.125*x-y);
[xc, yc] = solve(syst1, syst2, x, y);
disp('Critical points:');
disp([xc yc])

% Finding Stability
A = jacobian([syst1 syst2], [x y])
evals = eig(A);
disp('Eigenvalues at (0,0);');
disp(double(subs(evals, {x, y}, {0, 0})))
disp('Eigenvalues at (0,3/4):');
disp(double(subs(evals, {x, y}, {0, 4})))
disp('Eigenvalues at (3/2,0);');
disp(double(subs(evals, {x, y}, {3/2, 0})))
disp('Eigenvalues at (1,1):');
disp(double(subs(evals, {x, y}, {1, 1})))
disp('Eigenvalues at (0,0);');
disp(double(subs(evals, {x, y}, {0, 0})))
disp('Eigenvalues at (0,3/4):');
disp(double(subs(evals, {x, y}, {0, 3/4})))
disp('Eigenvalues at (3/2,0);');
disp(double(subs(evals, {x, y}, {3/2, 0})))
disp('Eigenvalues at (6/5,3/5):');
disp(double(subs(evals, {x, y}, {6/5, 3/5})))

% According to the eigenvalues we calculated, our stability points are:
% (0,0) - unstable node.
% (0,3/4) - asymptotically stable node.
% (3/2,0) - asymptotically stable node.
% (6/5,3/5) - unstable saddle point.

%% Problem 7 Part B
% Plot the vector field on oa region small enough to distinguish the
% critical points but large enough to judge th epossible solution behaviors
% away from the critical points. 
[X, Y] = meshgrid(0:0.1:2, 0:0.3:4.5);
U = X.*(1.5-0.5*X-Y);
V = Y.*(0.75-0.125*X-Y);
L = sqrt((U/2).^2 + (V/4.5).^2);
vectorfield = quiver(X, Y, U./L, V./L, 0.4);
axis tight
xlabel t, ylabel y
title 'Problem 7 Part B - Vector Field'

%% Problem 7 Part C
% Use several initial data points (x0, y0) in the first quadrant to draw a
% phase portrait for the system. Identify the direction of increasing t on
% the trajectories you obtain. Use the information from Parts A and B to
% choose a representative sample of initial conditions. Then combine the
% vector field and phase portrait on a simple graph.

f = @(t, x) [x(1)*(1.5-x(1)-.5*x(2)); x(2)*(0.75-0.125*x(1)-x(2))];
warning off
figure; axes; hold on
for a = .25:0.25:1.75
    for b = 0.5:0.5:4
        [t, xa] = ode45(f, [0 10], [a b]);
        plot(xa(:,1), xa(:,2))
        [t, xa] = ode45(f, [0 -5], [a b]);
        plot(xa(:,1), xa(:,2))
    end
end
axis([0 2 0 4.5])
xlabel t, ylabel y
title 'Problem 7 Part C Trajectories'

figure; axes; hold on
for a = [1 2]
    for b = 0.1:0.1:0.9
        [t, xa] = ode45(f, [0 20], [a*b a*2.5*(1-b)]);
        plot(xa(:,1), xa(:,2))
        [t, xa] = ode45(f, [0 -5], [a*b a*2.5*(1-b)]);
        plot(xa(:,1), xa(:,2))
    end
end
axis([0 2 0 4.5])
xlabel t, ylabel y
phaseportrait = gca;
title 'Problem 7(2) Trajectories'

% Now, combine portrait and vector field:

[X, Y] = meshgrid(0:0.1:2, 0:0.3:4.5);
U = X.*(1.5-0.5*X-Y);
V = Y.*(0.75-0.125*X-Y);
L = sqrt((U/2).^2 + (V/4.5).^2);
vectorfield = quiver(X, Y, U./L, V./L, 0.4);
axis tight
xlabel t, ylabel y
title 'Problem 7 Part C Vector Field and Trajectories'
hold on

for a = [1 2]
    for b = 0.1:0.1:0.9
        [t, xa] = ode45(f, [0 20], [a*b a*2.5*(1-b)]);
        plot(xa(:,1), xa(:,2))
        [t, xa] = ode45(f, [0 -5], [a*b a*2.5*(1-b)]);
        plot(xa(:,1), xa(:,2))
    end
end
axis([0 2 0 4.5])
xlabel t, ylabel y
phaseportrait = gcf;
hold off

%% Problem 7 Part D
% Suppose the initial state of the population is given by x(0) = 0.1, y(0)
% = 0.1. Find the state of the population t = 1, 2, 3, 4, 5, ... , 20.

[t, xa] = ode45(f, [0:20], [2.5, 2]);
disp([t xa])

% The population jumpes down from t = 0 to 3. Aftet that, the population
% continues decreasing to 0.6 at t = 20.

%% Problem 7 Part E
% Explain why, practically speaking, "peaceful coexistence" is the only
% outcome; i.e., with the exception of the situation in which one or both
% species starts out without any population, the population distributions
% always tend toward a certain equilibrium point. Sketch on your final plot
% from Part C the separatrices that connect the stable equilibrium point to
% the two unstable points at which one population is zero; these
% separatrices divide the solution curves that tend toward the origin as t
% approaches positive infinity from those that are unbounded as t
% approaches negative infinity. Hint: Since the separatrices are
% trajectories coming out of the saddle points, one can plot them by
% solving the equation for initial conditions very close to the saddle
% points. 

% There is no peaceful coexistence because the trajectories are near a
% point of equilibrium. This represents a positive population of one
% species and a zero population for the other. This forms separatrices and
% they divide the solution curves that tend toward the origin as t
% approaches infinity from those that are unbounded as t approaches
% infinity.

[t, xa] = ode45(f, [0, -10], [0.99 0.99]);
separatrix(1) = plot(xa(:,1), xa(:,2), ':');
[t, xa] = ode45(f, [0, -10], [1.01 1.01]);
separatrix(1) = plot(xa(:,1), xa(:,2), ':');
xlabel t, ylabel y
title 'Problem 7 Part E Trajectories and Separatrices'
hold on

for a = [1 2]
    for b = 0.1:0.1:0.9
        [t, xa] = ode45(f, [0 20], [a*b a*2.5*(1-b)]);
        plot(xa(:,1), xa(:,2))
        [t, xa] = ode45(f, [0 -5], [a*b a*2.5*(1-b)]);
        plot(xa(:,1), xa(:,2))
    end
end
axis([0 2 0 4.5])
xlabel t, ylabel y
hold off

%% Problem 7 Part F
% The vertical line x = 2.5 cuts a separatrix. By using the event detection
% feature of ode45 and the hint in Part E, find a numerical approximation
% to the number ybar such that (2.5, ybar) is on the separatrix.

hitline = @(t, x) eval('deal(x(1) - 2.5, 1, 1)', 'x(1) - 2.5');
options = odeset('Events', hitline, 'relTol', 1e-4);
[t, xa] = ode45(f, [0, -10], [1.001 1.001], options);
xa(length(t),:)

% Thus, the separatrix cuts the vertical line x = 1.5 at y = 1.693.
