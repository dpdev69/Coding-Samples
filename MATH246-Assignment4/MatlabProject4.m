%% Matlab Project 4 Problem Set D
% Emmanuel Taylor and Kenneth Bryant
% Differential Equations for Scientists and Engineers
% Section: 0221 and 0231
% March 29th 2013
 
%% Problem 3 Part A

% This and some of the following problems concern models for the motion of
% a pendulum, which consists of a weight attached to a rigid arm of length
% L that is free to pivot in a complete circle. Neglecting friction and air
% resistance, the angle y(t) that the arm makes with the vertical direction
% satisfies the differential equation y"(t)+(g/L)*sin(y(t))=0 (D.2) where g
% = 32.2 ft/sec^2 is the gravitational acceleration constant. We will
% assume the arm has length 32.2 ft and so replace (D.2) by the simpler
% form y"+sin(y)=0 (D.3). (Alternatively, one can rescale time, replacing t
% by sqrt(g/L)*t, to convert (D.2) to (D.3)). For motions with small
% displacements (y small), sin(y)=y, and (D.3) can be approximated by the
% linear equation y"+y=0. (D.4) This question has general solution
% y(t)=A*cos(t-gamma), with amplitude A and phase shift gamma. Hence all
% the solutions to the linear approximation (D.4) have period 2pi,
% independent of the amplitude A. In this problem we consider solutions of
% equation (D.3) satisfying the intial conditions y(0)=A, y'(0)=0. If |A|
% < pi, then solutions are periodic. However, in contrast to the linear
% equation (D.4), their periods depend on the amplitude A. We do expect
% that, for small displacements A, the solutions to the pendulum (D.3) will
% have periods close to 2pi.
 
% (A) Investigate how the period depends on the amplitude A by plotting a
% numerical solution of equation (D.3) using initial conditions y(0)=A,
% y'(0)=0 on an appropriate interval for various A. Estimate the periods of
% the pendulum for the amplitudes A = 0.1, 0.7, 1.5, 3.0. Confirm these
% results by displaying the displacements at a sequence of times, and
% finding the time at which the pendulum returns to its original position.
rhs = @(t, y) [y(2); -sin(y(1))];
figure, hold on
for A = 1:7
   [T1, Y1] = ode45(rhs, [0 10], [A * pi/8 0]);
   [T2, Y2] = ode45(rhs, [0 -10], [A * pi/8 0]);
   plot(T1, Y1(:,1), 'linewidth', 2, 'color', 'g')
   plot(T2, Y2(:,1), 'linewidth', 2, 'color', 'g')
end
title 'Problem 3 Part A with A = k(pi/8) < pi'
xlabel t, ylabel y
hold off

figure, hold on
A = 0.1;
while (A < 3.1)
   [xa, ya] = ode45(rhs, [0 10], [A 0]);
   [xb, yb] = ode45(rhs, [0 -10], [A 0]);
   plot(xa, ya(:,1), 'linewidth', 2, 'color', 'g')
   plot(xb, yb(:,1), 'linewidth', 2, 'color', 'g')
   if (A == 0.1)
       A = 0.7;
   else
       if (A == 0.7)
           A = 1.5;
       else
           if (A == 1.5)
               A = 3.0;
           else
               if (A == 3.0)
                   A = 3.1;
               end
           end
       end
   end
end
xlabel t, ylabel y
title 'Problem 3 Part A for A = {0.1, 0.7, 1.5, 3.0}'
hold off

% Here is a list of estimated periods for the different amplitudes:
% A = 0.1, T = 6.3
% A = 0.7, T = 6.5
% A = 1.5, T = 7.5
% A = 3.0, T = 16.0

[xa, ya] = ode45(rhs, 0:0.2:7, [0.1 0]);
[xa ya]
% 6.2 is the approximate period for amplitudes of 0.1

[xa, yb] = ode45(rhs, 0:0.2:7, [0.7 0]);
[xa yb]
% 6.4 is the approximate period for amplitudes of 0.7

[xa, yc] = ode45(rhs, 0:0.2:8, [1.5 0]);
[xa yc]
% 7.3 is the approximate period for amplitudes of 1.5

[xa, yd] = ode45(rhs, 0:0.2:8.6, [3.0 0]);
[xa yd]
% 15.8 is the approximate period for amplitudes of 3.0 

%% Problem 3 Part B

% The period is given by the formula T = 4 multiplied by the integral from
% 0 to pi/2 of dy/sqrt(1-k^2*sin^2(y)) where k = sin(A/2). This formula may
% be derived in your textl it can be found in Section 9.3 of Boyce &
% DiPrima, Problem 29. The integral is called an elliptic integral. It
% cannot be evaluated by an elementary formula, but it can be computed by
% int in terms of a MuPAD function ellipticK, or can be evaluated
% numerically using quadl. Calculate the period for the values of A we are
% considering. Do the values agree with those obtained in Part A?

% Amplitude = 0.1:
y = @(x) 4./sqrt(1 - (sin(0.1/2) * sin(x)).^2);
T = quad(y, 0, pi/2)

% Amplitude = 0.7:
y = @(x) 4./sqrt(1 - (sin(0.7/2) * sin(x)).^2);
T = quad(y, 0, pi/2)

% Amplitude = 1.5:
y = @(x) 4./sqrt(1 - (sin(1.5/2) * sin(x)).^2);
T = quad(y, 0, pi/2)

% Amplitude = 3.0:
y = @(x) 4./sqrt(1 - (sin(3.0/2) * sin(x)).^2);
T = quad(y, 0, pi/2) 

% These computed values agree with the estimates that were found in Part A.

%% Problem 3 Part C

% Redo the numerical calculations in Part A with different tolerances,
% choosing the tolerances so that the values you get agree with those
% calculated in Part B.

options = odeset('AbsTol', 1e-10, 'RelTol', 1e-10);
format long;

% Amplitudes = 0.1:
sol1 = ode45(rhs, [0 6.28711454952848], [0.1 0], options);
deval(sol1, 6.28711454952848)

% Amplitudes = 0.7:
sol2 = ode45(rhs, [0 6.48118970198958], [0.7 0], options);
deval(sol2, 6.48118970198958)

% Amplitudes = 1.5:
sol3 = ode45(rhs, [0 7.30086487598231], [1.5 0], options);
deval(sol3, 7.30086487598231)

% Amplitudes = 3.0:
sol4 = ode45(rhs, [0 16.15553941420581], [3.0 0], options);
deval(sol4, 16.15553941420581)

%% Problem 3 Part D

% How does the period depend on the amplitude of the initial displacement?
% For small A, is the period close to 2pi? What is happening to the
% accuracy of the linear approximation as the initial displacement
% increases?
 
% ANSWER: The period does not depend on the amplitude of the initial
% displacement, it only depends on the length of the string and the
% gravitation force of g. For small A, the period is close to 2pi. The
% accuracy of the linear approximation as the initial displacement
% increases decreases.
 
%% Problem 5
% In this problem, we'll investigate the effect of damping on the pendulum,
% using the model y"+by'+sin(y)=0. Prepare Simulink models that will take
% the value of b from a "Constant" block and (1): plot the numerical
% solution of this differential equation with the initial conditions
% y(0)=0, y'(0)=4. from t=0 to t=20. (2) Do the same for the linear
% approximation y"+by'+y=0. Compare the linear and nonlinear behavior for
% the values of b = 1, 1.5, 2. Interpret what is happening physically in
% each case: i.e., describe explicitly what the graph says the pendulum is
% doing.
 
% NONLINEAR BEHAVIOR:
figure, hold on
rhs2 = @(t, y) [y(2); -y(2) - sin(y(1))];
[xa, ya] = ode45(rhs2, [0 20], [0 4]);
plot(xa, ya(:,1), 'color', 'r', 'linewidth', 2)
 
rhs3 = @(t, y) [y(2); -1.5*y(2) - sin(y(1))];
[xb, yb] = ode45(rhs3, [0 20], [0 4]);
plot(xb, yb(:,1), 'color', 'g', 'linewidth', 2)
 
rhs4 = @(t, y) [y(2); -2*y(2) - sin(y(1))];
[xc, yc] = ode45(rhs4, [0 20], [0 4]);
plot(xc, yc(:,1), 'color', 'b', 'linewidth', 2)
xlabel t, ylabel y
title 'Problem 5 Nonlinear Behavior'
hold off
 
% LINEAR BEHAVIOR:
figure, hold on
rhs5 = @(t, y) [y(2); -y(2) - y(1)];
[xd, yd] = ode45(rhs5, [0 20], [0 4]);
plot(xd, yd(:,1), 'color', 'r', 'linewidth', 2)
 
rhs6 = @(t, y) [y(2); -1.5*y(2) - y(1)];
[xe, ye] = ode45(rhs6, [0 20], [0 4]);
plot(xe, ye(:,1), 'color', 'g', 'linewidth', 2)
 
rhs7 = @(t, y) [y(2); -2*y(2) - y(1)];
[xf, yf] = ode45(rhs7, [0 20], [0 4]);
plot(xf, yf(:,1), 'color', 'b', 'linewidth', 2)
xlabel t, ylabel y
title 'Problem 5 Linear Behavior'
hold off
 
%% Problem 7 Part A
% A paratrooper steps out of an airplane at a height of 1000 ft and after 5
% seconds, opens her parachute. Her weight, with equipment, is 195 lbs. Let
% y(t) denote her height above the ground after t seconds. Assume that the
% force due to air resistance is 0.005*y'(t)^2 lbs in free fall and
% 0.6*y'(t)^2 lbs with the chute open. At what height does the chute open?
% How long does it take to reach the ground? At what velocity does she hit
% the ground? (This model assumes that air resistance is proportional to
% the square of the velocity and that the parachute opens instantaneously.)
 
% (Hint: This problem can be solved most efficiently by using the Events
% option to ode45 to detect significant events. Pay attention to units.
% Recall that the mass of the paratrooper is 195/32, measured in
% (lb*sec^2)/ft. Here, 32 is the acceleration due to gravity measured in
% ft/sec^2.

v0 = 0;
w = 195;
m = 195/32.2;
g = 32.2;
y0 = 1000;

% Free Fall
func1 = @(t, y) [y(2); (((.005 * y(1) * (t.^2)) - w)/m)];
[x1, y1] = ode45(func1, [0,5], [1000 0]);
[x1, y1]

% From the data chart, you can see that at t = 5, the distance = 633.9 and
% that v = -134.2. This can be found on the last row of the chart.
time = x1(69)
height = y1(69)

% When the parachute opens
func2 = @(t, y) [y(2); -g + ((g * .6)/w) * y(2)^2];
[x2, y2] = ode45(func2, [0:.1:35], [height -134.3]);
[x2, y2]

% The paratrooper will hit the ground betwee 34.4 and 34.4 seconds after
% the v = -18/02 ft/s. These are the values frmo which the distance changes
% from negative to positive which indicates that the paratrooper has
% touched the ground.

%% Problem 7 Part B

% Let v = y' be the velocity during the second phase of the fall (while the
% chute is open). One can view the equation of motion as an autonomous
% first order ODE in the velocity: v' = -32 + (192/1950)v^2. Make a
% qualitative analysis of this first order equation, finding in particular
% the critical or equilibrium velocity. This velocity is called the
% terminal velocity. How does the terminal velocity compare with the
% velocity at the time the chute opens and with the velocity at impact?
y = '32*(-1 + (.6/195)*x^2)';
critical = solve('32*(-1 + (.6/195)*x^2)');
% Critical velocity is 18.028 ft/s. This is much smaller than the values of
% when the parachute opens but is very close to the impact velocity.

safe = critical(1) * 1.05
% The variable safe is the value at which the paratrooper can land safely.
% This value is -18.929.

Dv = -32 + (192/1950) * (safe^2)
% The final acceleration: 3.28 ft/s towards the earth.

y0 = [500:1000];
func1 = @(t, y) [y(2); (-w + (.005 * y(1) * (t.^2)))/m];
for s = 1:501;
[x1, y1] = ode45(func1, [0,5], [y0(s) 0]);
ZZ = [x1, y1];
C = [y1(1), y1(69)];
end
 
%% Problem 7 Part C

% Assume the paratrooper is safe if she strikes the ground at a velocity
% within 5% of the terminal velocity in Part B. Except for the initial
% height, use the parameters in Part A. What is the lowest height from
% which she may parachute safely? (Please do not try this at home!)
veq = solve('32 * (-1 + (.6/195) * x^2)')
func3 = @(t,y) [y(2); -g + ((g * .6)/w) * y(2)^2];
[x3, y3] = ode45(func3, [5:.01:10], [500 -134.3]);
[x3, y3]

% The lowest height from which she may parachute safely is 398 feet.
% Looking at the ode45 chart, we can see that the paratrooper reached veq
% at 32 feet below the starting point. After 5 seconds, the 366 feet needed
% to deploy the parachute was added to the final 32 feet needed for the
% safe velocity.
%% Problem 15 Part A

% This problem is based on Problems 18 and 19 in Boyce & DiPrima, Section
% 3.8. Consider the initial value problem. u" + u' = 3cos(wt), u(0) = 0 and
% u'(0) = 0.

%Find the solution (using dsolve). For w = 0.5, 0.6, 0.7, 0.8, 0.9, plot
%the solution curves on the interval 0 <= t <= 15. Note that w0 = 1 is the
%natural frequency of the homogenous equation. Describe how the solution
%curves change as w gets closer to w0.
figure; hold on
p=ezplot(dsolve('D2u + u = 3*cos(.5*t)', 'u(0) = 0', 'Du(0) = 0'), [0 15]);
q=ezplot(dsolve('D2u + u = 3*cos(.6*t)', 'u(0) = 0', 'Du(0) = 0'), [0 15]);
r=ezplot(dsolve('D2u + u = 3*cos(.7*t)', 'u(0) = 0', 'Du(0) = 0'), [0 15]);
s=ezplot(dsolve('D2u + u = 3*cos(.8*t)', 'u(0) = 0', 'Du(0) = 0'), [0 15]);
t=ezplot(dsolve('D2u + u = 3*cos(.9*t)', 'u(0) = 0', 'Du(0) = 0'), [0 15]);
set(p, 'Linewidth', 2, 'color', 'r');
set(q, 'Linewidth', 2, 'color', 'g');
set(r, 'Linewidth', 2, 'color', 'b');
set(s, 'Linewidth', 2, 'color', 'c');
set(t, 'Linewidth', 2, 'color', 'k');
axis([0 15 -20 20]);
xlabel('Time'), ylabel('Displacement')
title 'Problem 15 Part A'
hold off
 
% By looking at the different plots for the different values for w, as w
% gets closer to w0, the amplitude starts to increase.
 
%% Problem 15 Part B

% Note that the formula you found in Part A is invalid when w = 1. Find and
% plot the solution curve for w = 1 on the interval 0 <= t <= 15. Based on
% the discussion of forced vibrations in your text, what phenomenon should
% be exhibited for this value of w? Corroborate your answer by plotting on
% a longer interval.
figure;
p = ezplot(dsolve('D2u + u = 3*cos(t)', 'u(0) = 0', 'Du(0) = 0'), [0 15]);
set(p, 'Linewidth', 2);
xlabel('Time'), ylabel('Displacement')
title 'Problem 15 Part B Interval [0 15]'
 
figure;
q = ezplot(dsolve('D2u + u = 3*cos(t)', 'u(0) = 0', 'Du(0) = 0'), [0 30]);
set(q, 'Linewidth', 2);
xlabel('Time'), ylabel('Displacement')
title 'Problem 15 Part B Interval [0 30]'

% This phenomenon is called Resonance.
 
%% Problem 15 Part C

% Plot the solution for w = 0.9 on a longer interval and compare it with
% the solution from Part B. What phenomenon is exhibited by the curve for w
% = 0.9?
figure; hold on
p=ezplot(dsolve('D2u + u = 3*cos(.9*t)', 'u(0) = 0', 'Du(0) = 0'), [0 120]);
set(p, 'Linewidth', 2, 'color', 'r');
xlabel t, ylabel y
title 'Problem 15 Part C Interval [0 30]'

q = ezplot(dsolve('D2u + u = 3*cos(t)', 'u(0) = 0', 'Du(0) = 0'), [0 120]);
set(q, 'Linewidth', 2, 'color', 'b');
xlabel('Time'), ylabel('Displacement')
title 'Problem 15 Part B Interval [0 30]'
hold off

% This phenomenon is what is known as amplitude modulation. This occurs
% when there is a periodic change in the amplitude which is known as a
% beat.
