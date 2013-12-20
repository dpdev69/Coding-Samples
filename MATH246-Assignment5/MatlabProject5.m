%% Matlab Project 5 Problem Set E
% Emmanuel Taylor, Kenneth Bryant, Whitney Wilson
% Differential Equations for Scientists and Engineers
% Section: 0221 and 0231
% April 27th 2013

%% Problem 12 Part A
% Consider the following IVP: y" + 2y' + 2y = g(t), y(0)=0, y'(0)=0, g(t) =
% sin(t) if t < pi and 0 if t is >= pi. (E.4)
% Solve the equation for 0 <= t <= pi by using dsolve on the IVP
% y"+2y'+2y=sin(t), y(0)=0, y'(0)=0. Plot the solution on the interval
% 0<=t<=pi. 
figure; hold on
solution1 = dsolve('D2y + 2*Dy + 2*y = sin(t)', 'y(0)=0', 'Dy(0)=0', 't')
plot1 = ezplot(solution1, [0 pi()])
set(plot1, 'linewidth', 3, 'color', 'r')
xlabel t, ylabel y
title 'Problem 12 Part A - Dsolve Method Solution'
hold off

%% Problem 12 Part B
% Find numerical values for y=y(pi) and y'=y'(pi) using the solution from
% part a. Then use dsolve on the IVP. y"+2y'+2y=0, y(pi)=ypi, y'(pi)=y'pi.
% Plot the solution on the interval pi <= t <= 15. Combine this graph with
% your graph from part a to show the solution to (E.4) on the entire
% interval 0 <= t <= 15.
figure; hold on
solution1 = dsolve('D2y + 2*Dy + 2*y = sin(t)', 'y(0)=0', 'Dy(0)=0', 't')
plot1 = ezplot(solution1, [0 pi()])
set(plot1, 'linewidth', 3, 'color', 'r')
answer1 = subs(solution1,pi)
answer2 = subs(diff(solution1),pi)
solution2 = dsolve('D2y + 2*Dy + 2*y = sin(t)','y(pi)=0.382714432694491','Dy(pi)=-.1914');
plot2 = ezplot(solution2,[pi,15])
set(plot2, 'linewidth', 3, 'color', 'r')
axis auto
xlabel t, ylabel y
title 'Problem 12 Part B - Combined Graphs'
hold off

%% Problem 12 Part C
% Now solve the equation using the Laplace Transform method. Plot the
% solution on [0, 15], and compare it to the solution from Part .
figure; hold on
syms t s Y
eqn = sym('D(D(y))(t) + 2*D(y)(t) + 2*y(t) = sin(t)');
lteqn = laplace(eqn, t, s)
neweqn = subs(lteqn, {'laplace(y(t),t,s)', 'y(0)', 'D(y)(0)'}, {Y, 0, 0})
ytrans = simplify(solve(neweqn, Y))
y = ilaplace(ytrans, s, t)
p = ezplot(y, [0 15])
set(p, 'linewidth', 3, 'color', 'r')
axis auto
xlabel t, ylabel y
title 'Problem 13 Part C - LaPlace Method Solution'
hold off

%% Problem 12 Part D
% Find the general solution of the associated homogenous equation. What is
% the asymptotic behavior of those solutions as t approaches infinity?
% Knowing that the forcing term of the inhomogenous equation is zero after
% t = pi, what can you say about the long term behavior of the solution of
% the inhomogenous equation?
solution3 = dsolve('D2y + 2*Dy + 2*y = 0')

% The solutions of the associate homogenous equation is
% y = C8*exp(-t)*cos(t) + C9*exp(-t)*sin(t)
% At t = infinity, the solution approaches zero.
% The long term-behavior of the solution is zero.

%% Problem 13 Part A
% Use the Laplace Transform method to solve the following initial value
% problems. Then graph the solutions on the interval [0, 15]. In parts a
% and b, also graph the function on the right-hand side of the differential
% equation (the forcing function). In each part, discuss how the solution
% behaves in response to the forcing function.
syms s t Y;
g = 'heaviside(t-pi())*(1) + heaviside(t-10)*(-1)'
eqn = sym(['D(D(y))(t) + 3*D(y)(t) + 2*y(t) = ' g]);
lteqn = laplace(eqn, t, s);
neweqn = subs(lteqn, {'laplace(y(t),t,s)', 'y(0)', 'D(y)(0)'}, {Y, 1, 0});
ytrans = simplify(solve(neweqn,Y));
solution5 = ilaplace(ytrans, s, t);
figure
plot3 = ezplot(solution5, [0,15])
set(plot3, 'linewidth', 3, 'color', 'r')
axis auto
xlabel t, ylabel y
title 'Problem 13 Part A - LaPlace Method Solution'

%% Problem 14 Part A
% Use the Laplace Transform method to solve the following initial value
% problems. See problem 13 for additional instructions.
figure; hold on
syms t s Y
f = ['(1 - heaviside(t-2*pi))*sin(t)'];
eqn = sym(['D(D(y))(t) + 4*y(t) = ' f]);
lteqn = laplace(eqn, t, s)
neweqn = subs(lteqn, {'laplace(y(t),t,s)', 'y(0)', 'D(y)(0)'}, {Y, 0, 0})
ytrans = simplify(solve(neweqn, Y))
y = ilaplace(ytrans, s, t)
plot4 = ezplot(y, [0 15])
set(plot4, 'linewidth', 3, 'color', 'r')
axis auto
xlabel t, ylabel y
title 'Problem 14 Part A - LaPlace Method Solution'
hold off

figure; hold on
plot5 = ezplot(f, [0 15])
set(plot5, 'linewidth', 3, 'color', 'r')
axis auto
xlabel t, ylabel y
title 'Problem 14 Part A - Forcing Factor'
hold off

%% Problem 17 Part A
% This problem illustrates how the choice of method can dramatically affect
% the time it takes the computer to solve a differential equation. It can
% also affect the form of the solution. Consider the initial value problem
% y"+y'+y=(t+1)^3*e^-t*cos(t)*sin(3t), y(0)=1, y'(0)=0 (E.5). This problem
% could be solved by methods of undetermined coefficients, variation of
% parameters, or Laplace Transforms.
% Try to solve (E.5) usign dsolve. How long does it take? The MATLAB
% commands tic and toc can be used as a stopwatch.
tic
figure; hold on
sol2=dsolve('D2y+Dy+y=((t+1)^3)*exp(-t)*cos(t)*sin(3*t)','y(0)=1','Dy(0)=0')
p17partA = ezplot(sol2, [0 15])
set(p17partA, 'linewidth', 3, 'color', 'r')
axis auto
xlabel t, ylabel y
title 'Problem 17 Part A - Dsolve Method Solution'
hold off
toc
 
% Using the dsolve method from previous chapters for second order
% differential equations, it took about 0.36 seconds to get a result.
% However these results may vary because tic and toc depends on the program
% being used and the speed of the computer running the program. In this
% case, the LaPlace Transform method seemed to produce results faster.

%% Problem 17 Part B
% Now use the Laplace Transform method from Chapter 13 to solve the
% problem. How long does it take to get a result?
tic
syms t s Y
figure; hold on
eqn1 = sym('D(D(y))(t)+D(y)(t)+y(t)=((t+1)^3)*exp(-t)*cos(t)*sin(3*t)');
lteqn1 = laplace(eqn1, t, s)
neweqn1 = subs(lteqn1, {'laplace(y(t),t,s)', 'y(0)', 'D(y)(0)'}, {Y, 1, 0})
ytrans1 = simplify(solve(neweqn1, Y))
y1 = ilaplace(ytrans1, s, t)
p17partB = ezplot(y1, [0 15])
set(p17partB, 'linewidth', 3, 'color', 'b')
axis auto
xlabel t, ylabel y
title 'Problem 17 Part B - LaPlace Method Solution'
hold off
toc
 
% Using the LaPlace Transform method from chapter 13, it took about 0.23
% seconds to get a result. However these resuts may vary because tic and
% toc depend on the program being used and the speed of the computer
% running the program. In this case, the LaPlace Transform method seemed to
% produce results faster.

%% Problem 17 Part C
% Plot the two solutions over the range 0<=t<=15 and verify that they look
% the same.
figure; hold on
p17partB = ezplot(y1, [0 15])
p17partA = ezplot(sol2, [0 15])
set(p17partA, 'linewidth', 3, 'color', 'k')
set(p17partB, 'linewidth', 3, 'color', 'k')
axis auto
xlabel t, ylabel y
title 'Problem 17 Part A and B Solutions Plotted Together'
hold off
 
% Both the dsolve graph and the LaPlace Transform graph are the same.
