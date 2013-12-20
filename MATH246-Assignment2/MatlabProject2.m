%% MATLAB PROBLEM SET B
% Emmanuel Taylor and Kenneth Bryant
% MATH246: Differential Equations for Scientists and Engineers, 0221, 0232
% Section 0221: Hana, Section 0232: Jayna
% February 28, 2013

%% Problem 1 Part A
% Consider the initial value problem:
% ty' + 3y = 5t^2, y(2)=5
% Solve the initial value problem using dsolve. Determine the behavior of
% the solution as t approaches 0 from the right and as t becomes large.
% This can be done by plotting the solution with ezplot on intervals such
% as 0.5 <= t <= 5 and 0.2 <= t <= 20.
sol1 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = 5', 't')
ezplot(sol1, [0.5 5])
ezplot(sol1, [0.2 20])
title 'Solution curve of Dy = 5*t - (3/t)*y with y(2)=5'
xlabel t, ylabel y
 
% As t becomes large, the solution approaches infinity.
% As t approaches 0 from the right, the solution also approaches infinity.
 
%% Problem 1 Part B
% Consider the initial value problem:
% ty' + 3y = 5t^2, y(2)=5
% Change the initial condition to y(2) = 3. Determine the behavior of this
% solution again by plotting on intervals such as those mentioned in part
% A.
sol2 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = 3', 't')
ezplot(sol2, [0.5 5])
ezplot(sol2, [0.2 20])
title 'Solution curve of Dy = 5*t - (3/t)*y with y(2)=3'
xlabel t, ylabel y
 
% As t becomes large, the solution approaches infinity.
% As t approaches 0 from the right, the solution approaches negative
% infinity.
 
%% Problem 1 Part C
% Consider the initial value problem:
% ty' + 3y = 5t^2, y(2)=5
% Find the general solution of the differential equation by solving:
% ty' + 3y = 5t^2, y(2)=c
sol3 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = c', 't')
 
% Now find the solutions corresponding to the initial conditions:
% yj(2)=j, j=3,...,7
sol4 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = 3', 't')
sol5 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = 4', 't')
sol6 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = 5', 't')
sol7 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = 6', 't')
sol8 = dsolve('Dy = 5*t - (3/t)*y', 'y(2) = 7', 't')
 
% Plot the functions yj(x), j=3,...,7 on the same graph. Describe the
% behavior of these solutions for small positive t and for large t. Find
% the solution that is not singular at 0. Identify it's plot in the graph.
figure; hold on
syms t
for cval = 3:7
    ezplot(subs(sol3, 'c', cval), [0 5])
end
axis tight
title 'Solution curves of Dy = 5*t - (3/t)*y with y(0) = 3,...,7'
xlabel t, ylabel y
hold off
 
% As t becomes large, every solution approaches infinity, however, when t
% is very small and positive, all but the solutions of initial conditions
% y(2)=3 and y(2)=4 approach infinity. y(2)=3 approaches negative infinity
% and y(2)=4 approaches 0.
 
%% Problem 7
% Part A
% Consider the differential equation:
% e^y+(te^y-sin(y))(dy/dt)=0
% Solve using dsolve. Observe that the solution is given implicitly in the
% form f(t,y)=c
syms t y
sol9 = dsolve('exp(y)+(t*exp(y)-sin(y))*Dy=0')
 
% Part B
% Use ezcontour to see what the solution curves look like. For your t and y
% ranges, you might use -1 <= t <= 4, 0 <= y <= 3.
fig1 = figure;
hold on;
sol9func = cos(y)+t*exp(y);
ezcontour(sol9func, [-1, 4, 0, 3])
 
% Part C
% Plot the solution satisfying the initial condition y(2) = 1.5.
c = subs(sol9func, [t, y], [2, 1.5]);
p = ezplot(sol9func-c, [-1, 4, 0, 3]);
set(p, 'color', 'r', 'Linewidth', 3);
 
% Part D
% Find y(1), y(1.5), y(3). Mark these specific values on your plot.
val1 = fzero(@(y)eval(vectorize(subs(sol9func,t,1)-c)),2.3);
val2 = fzero(@(y)eval(vectorize(subs(sol9func,t,1.5)-c)),1.7);
val3 = fzero(@(y)eval(vectorize(subs(sol9func,t,3)-c)),1);
val = [val1, val2, val3];
plot([1, 1.5, 3],val,'.k','Markersize',20)
xlabel t, ylabel y
title 'Complete graph with curve satisfying y(2) = 1.5'
grid;
vpa(val)
hold off
 
%% Problem 14 Part B
% Plot the direction field for the equation dy/dt = y^2-ty, again using a
% rectangle large enough to show the possible limiting behaviors. Identify
% the unique constant solution. Why is this solution evident from the
% differential equation? If a solution curve is ever below the constant
% solution, what must its limiting behavior be as t increases? For
% solutions lying above the constant solution, describe two possible
% limiting behaviors as t increases. There is a solution curve that lies
% along the boundary of the two limiting behaviors. What does it do as t
% increases? Explain (from the differential equation) why no other limiting
% behavior is possible.
[T, Y] = meshgrid(-2:0.2:3, -1:0.2:2);
S = Y.^2-T.*Y;
L = sqrt(1+S.^2);
quiver(T, Y, 1./L, S./L, 0.5), axis equal tight
xlabel t, ylabel y
title 'Direction Field for dy/dt = y^2-ty'
 
% The unique constant solution is at y=0. This solution is evident from the
% differential equation because factoring the equation leads to y(y-t)
% which will be zero if y were zero. Depending on where we start from, t
% has different behaviors. For solutions curves below the constant
% solution, they will move towards negative infinity and gradually move
% towards y=0. Two limiting behaviors for curves lying above the constant
% solution are increasing all the way to positive infinity, or moving
% towards positive infinity but gradually moving back towards y=0.

%% Problem 14 Part C
% Confirm your analysis by using dsolve on the initial value problem y' =
% y^2-ty, y(0)=c and then examining different values for c.
sol11 = dsolve('Dy = y^2-t*y', 'y(0)=c', 't')
figure; hold on
syms t
for cval = 3:7
    ezplot(subs(sol11, 'c', cval), [-5 5])
end
title 'Solution curves of Dy = y^2=ty with y(0)=c for c=3,...,7'
xlabel t, ylabel y
hold off

%% Problem 15
% Part A
% The solution of the differential equation y'=(2y-t)/(2t-y) is given
% implicitly by |t-y| = c|t+y|^3. (This is not what dsolve produces, which
% is a more complicated explicit solution for y in terms of t. but it's
% what you get by marking the subtitution v=y/t and tv, y' = tv'+v and
% separating variables. You do not need to check this answer. However, it
% is difficult to understand the solutions directly from this algebraic
% information.
 
% Use meshgrid and quiver to plot the direction field of the differential
% equation.
x = linspace(-5,5,30);
[yy, tt] = meshgrid(x, x);
fy = (2*yy-tt)./(2*tt-yy);
ft = ones(size(fy));
s = sqrt(ft.^2+fy.^2);
fig = figure;
hold on;
quiver(tt,yy,ft./s,fy./s);
axis equal tight
xlabel t, ylabel y
title 'Direction Field for dy/dt = (2y-t)/(2t-y)'
 
% Part B
% Use ezplot to plot the solutions with initial conditions y(2) = 1 and
% y(0) = -3. (Once you determine the sign of the quantity (t-y)/(t+y)^3,
% you can get rid of the absolute values. Use hold on to put these plots
% and the vector field plot together on the same graph.
f = abs(t-y)/(abs(y+t))^3;
c1 = subs(f,[t,y],[2,1])
f1=(t-y)-c1*(t+y)^3;
p1=ezplot(f1,[-5,5,-5,5]);
set(p1,'LineWidth',2,'color','r'); 
c2=subs(f,[t,y],[0,-3])
plot(2,1,'.','Markersize',20,'color','r')
% 0+3>0, 0-3 <0
f2=(t-y)+c2*(t+y)^3;
p2=ezplot(f2,[-5,5,-5,5]);
set(p2,'LineWidth',2,'color','k'); 
grid
title 'dy/dt = (2y - t) / (2t - y)'
plot(0,-3,'.','Markersize',20,'color','k')

% Part C
% For the two different initial conditions in part b, use your pictures to
% estimate the largest interval on which the unique solution function is
% defined.
 
% y(0) = -3 is defined for -0.575 < t < positive infinity
% y(2) - 1 is defined on negative infinity < t < positive infinity
