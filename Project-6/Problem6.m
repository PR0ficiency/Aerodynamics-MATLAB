% Store given data in arrays %
x = linspace(0,1,21);
CpL = [1 0.51 0.38 0.30 0.28 0.27 0.25 0.26 0.25 0.24 0.23 0.23 0.23 0.23 0.23 0.23 0.23 0.21 0.20 0.19 0.15];
CpU = [-1.77 -1.50 -1.39 -1.28 -1.23 -1.20 -1.04 -0.95 -0.89 -0.76 -0.71 -0.62 -0.53 -0.49 -0.39 -0.30 -0.24 -0.19 0.01 0.05 0.15];

CpL_int = trapz(x,CpL);
CpU_int = trapz(x,CpU);

Cl = CpL_int + CpU_int

center_pressure = trapz(x,x.*(CpL+CpU))/Cl

Cm_LE = Cl*center_pressure

Cm_AC = Cm_LE + Cl*(0.246)
y1 = zeros(size(x));
y2 = zeros(size(x));
for i=1:length(x)
    y1(i) = sqrt(1-CpL(i));
    y2(i) = sqrt(1-CpU(i));
end

% Plot wind tunnel data % 
figure
subplot(1,2,1)
plot(x,CpL,x,CpU)
legend('Cp-Lower Surface','Cp-Upper Surface')
title('Cp data vs. x')
subplot(1,2,2)
plot(x,y1,x,y2)
legend('Lower Surface','Upper Surface')
title('Normalized Velocity vs. x')