% Array of Mach number Values from 0.4 to 1.0 %
Mach = linspace(0.4,0.9,6);

% Set gamma value % 
gamma = 1.4;

% Set minimum pressure coefficient %
Cp_0 = -0.90;

% Calculate critical pressure coefficient using Eqn. 5.48 (Anderson, 8th Ed.
% Intro to Flight)
Cp_cr = Cp_critical(Mach, gamma)

% Calculate pressure coefficient using Eqn. 5.28 (Anderson, 8th Ed. Intro
% to Flighht)
Cp = Cp_calc(Mach, Cp_0)

% Generate curves to fit data %
p1 = polyfit(Mach,Cp_cr,5);
p2 = polyfit(Mach,Cp,5);

% Find intersection of the curves using "Fast and Robust Curve
% Intersections" by Douglas Schawrz from MATLAB Central File Exchange: 
% http://www.mathworks.com/matlabcentral/fileexchange/11837-fast-and-
% robust-curve-intersections
[x_intersect, y_intersect] = intersections(Mach, Cp_cr, Mach, Cp)

% Plot data points, curves, and intersection %
y1 = polyval(p1,Mach);
y2 = polyval(p2,Mach);

figure
plot(Mach, y1, Mach, y2)
legend('Cp Critical','Cp', 'Location','southeast')
hold on
plot(Mach, Cp_cr,'o')
plot(Mach, Cp, 'x')
scatter(x_intersect, y_intersect, 'filled')
hold off

title('Cp vs. Mach Number');
xlabel('Mach Number');
ylabel('Cp');