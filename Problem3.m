%% Standard Variables %%

SL_rho = 0.0023769; %slug/ft^3

%% Predator %%

% From standard atmosphere tables %
pred_OA_rho = 0.0012673; %slug/ft^3

% Given Data %
pred_OA = 20000; %ft 
pred_grossWeight = 2250; %lb
pred_fuelWeight = 400; %lb
pred_span = 50; %ft
pred_wingArea = 125; %ft^2
pred_aspectRatio = 20;
pred_oswaldEff = 0.75;
pred_CD_0 = 0.035;
pred_CL_max = 3.50;
pred_engineHP = 85; %bhp
pred_propEff = 0.9; %P_A = eta * bhp
pred_minVelInt = 10; %ft/s
pred_topVinf = 250; %ft/s

% Range of Velocities %

pred_Vinf = transpose(linspace(0,pred_topVinf,(pred_topVinf)/pred_minVelInt + 1));

% Sea Level %

SL_pred_PA = pred_propEff * pred_engineHP;
SL_pred_CL = CL(pred_grossWeight, SL_rho, pred_Vinf, pred_wingArea);
SL_pred_CD = CD(pred_CD_0, SL_pred_CL, pred_oswaldEff, pred_aspectRatio);
SL_pred_LiftDragRatio = LDR(SL_pred_CL, SL_pred_CD, pred_CL_max);
SL_pred_TR = TR(pred_grossWeight, SL_pred_LiftDragRatio);
SL_pred_PR = SL_pred_TR .* pred_Vinf;

SL_pred_PR (SL_pred_PR == 0) = NaN;

SL_pred_RC = 60*(550*SL_pred_PA - SL_pred_PR) / pred_grossWeight;

% Convert power required to horse power %

SL_pred_PR_hp = SL_pred_PR / 550;

% Plot Sea Level Data %

figure
subplot(2,1,1)
plot(pred_Vinf, SL_pred_PR_hp);
hold on
plot([150 pred_Vinf(end)], [SL_pred_PA SL_pred_PA]);
hold off
axis([50,250,0,170]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Power (hp)');
legend('Power Required', 'Power Available','Location','northwest');
title('Predator - Power vs. Freestream Velocity (Sea Level)');
ax = gca;
ax.XMinorGrid = 'on';

SL_pred_LiftDragRatio (SL_pred_LiftDragRatio == 0) = NaN;

subplot(2,1,2)
plot(pred_Vinf, SL_pred_LiftDragRatio);
axis([50,250,0,30]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Lift/Drag Ratio');
title('Predator - Lift/Drag Ratio vs. Freestream Velocity (Sea Level)');

figure
plot(pred_Vinf, SL_pred_RC);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Rate of Climb (ft/min)');
title('Predator - Rate of Climb vs. Freestream Velocity (Sea Level)');
ylim([0,850]);

% 20000 feet %

OA_pred_PA = SL_pred_PA * SL_rho/pred_OA_rho;
OA_pred_CL = CL(pred_grossWeight, pred_OA_rho, pred_Vinf, pred_wingArea);
OA_pred_CD = CD(pred_CD_0, OA_pred_CL, pred_oswaldEff, pred_aspectRatio);
OA_pred_LiftDragRatio = LDR(OA_pred_CL, OA_pred_CD, pred_CL_max);
OA_pred_TR = TR(pred_grossWeight, OA_pred_LiftDragRatio);
OA_pred_PR = SL_pred_PR * sqrt(pred_OA_rho/SL_rho);

OA_pred_PR (OA_pred_PR == 0) = NaN;

OA_pred_RC = 60*(550*OA_pred_PA - OA_pred_PR) / pred_grossWeight;

% Convert power required to horse power %

OA_pred_PR_hp = OA_pred_PR / 550;

% Plot OA Data %

figure
subplot(2,1,1)
plot(pred_Vinf, OA_pred_PR_hp);
hold on
plot([150 pred_Vinf(end)], [OA_pred_PA OA_pred_PA]);
hold off
axis([50,250,0,170]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Power (hp)');
legend('Power Required', 'Power Available','Location','northwest');
title('Predator - Power vs. Freestream Velocity (20,000 ft)');
ax = gca;
ax.XMinorGrid = 'on';

subplot(2,1,2)
plot(pred_Vinf, SL_pred_LiftDragRatio);
axis([50,250,0,30]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Lift/Drag Ratio');
title('Predator - Lift/Drag vs. Freestream Velocity (20,000 ft)');

figure
plot(pred_Vinf, OA_pred_RC);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Rate of Climb (ft/min)');
title('Predator - Rate of Climb vs. Freestream Velocity (20,000 ft)');
ylim([0,inf]);

%% Boeing 787 Dreamliner %%

% From standard atmosphere tables %
dream_OA_rho = 0.00064629; %slug/ft^3

% Given Data %
dream_OA = 38000; %ft 
dream_grossWeight = 500000; %lb
dream_fuelWeight = 125000; %lb
dream_span = 200; %ft
dream_wingArea = 3500; %ft^2
dream_aspectRatio = 10;
dream_oswaldEff = 0.8;
dream_CD_0 = 0.022;
dream_CL_max = 3.00;
dream_ThrustAvail = 2*60000; %lb
dream_minVelInt = 20; %ft/s
dream_topVinf = 1100; %ft/s


% Range of Velocities %

dream_Vinf = transpose(linspace(0,dream_topVinf+100,(dream_topVinf+100)/dream_minVelInt + 1));

% Sea Level %

SL_dream_CL = CL(dream_grossWeight, SL_rho, dream_Vinf, dream_wingArea);
SL_dream_CD = CD(dream_CD_0, SL_dream_CL, dream_oswaldEff, dream_aspectRatio);
SL_dream_LiftDragRatio = LDR(SL_dream_CL, SL_dream_CD, dream_CL_max);
SL_dream_TR = TR(dream_grossWeight, SL_dream_LiftDragRatio);
SL_dream_PR = SL_dream_TR .* dream_Vinf;

SL_dream_PR (SL_dream_PR == 0) = NaN;

SL_dream_RC = 60*(dream_ThrustAvail .* dream_Vinf - SL_dream_PR) / dream_grossWeight;

% Convert power required to horse power %

SL_dream_PR_hp = SL_dream_PR / 550;

% Plot Sea Level Data %

SL_dream_TR (SL_dream_TR == 0) = NaN;

figure
subplot(2,1,1)
plot(dream_Vinf, SL_dream_TR);
hold on
plot([900 dream_Vinf(end)], [dream_ThrustAvail dream_ThrustAvail]);
hold off
axis([0,1200,0,160000]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Thrust (lb)');
legend('Thrust Required', 'Thrust Available','Location','northwest');
title('Dreamliner - Thrust vs. Freestream Velocity (Sea Level)');
ax = gca;
ax.XMinorGrid = 'on';

SL_dream_LiftDragRatio (SL_dream_LiftDragRatio == 0) = NaN;

subplot(2,1,2)
plot(dream_Vinf, SL_dream_LiftDragRatio);
axis([0,1200,0,20]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Lift/Drag Ratio');
title('Dreamliner - Lift/Drag Ratio vs. Freestream Velocity (Sea Level)');

figure
plot(dream_Vinf, SL_dream_RC);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Rate of Climb (ft/min)');
title('Dreamliner - Rate of Climb vs. Freestream Velocity (Sea Level)');
axis([0,1200,0,6500]);

% 38000 feet %

OA_dream_CL = CL(dream_grossWeight, dream_OA_rho, dream_Vinf, dream_wingArea);
OA_dream_CD = CD(dream_CD_0, OA_dream_CL, dream_oswaldEff, dream_aspectRatio);
OA_dream_LiftDragRatio = LDR(OA_dream_CL, OA_dream_CD, dream_CL_max);
OA_dream_TR = TR(dream_grossWeight, OA_dream_LiftDragRatio);
OA_dream_PR = SL_dream_PR * sqrt(dream_OA_rho/SL_rho);

OA_dream_RC = 60*((dream_ThrustAvail*(dream_OA_rho/SL_rho)) .* dream_Vinf - OA_dream_PR) / dream_grossWeight;

% Convert power required to horse power %

SL_dream_PR_hp = SL_dream_PR / 550;

% Plot OA Data %

OA_dream_TR (OA_dream_TR == 0) = NaN;


figure
subplot(2,1,1)
plot(dream_Vinf, OA_dream_TR);
hold on
plot([500 1050], [(dream_ThrustAvail*(dream_OA_rho/SL_rho)) (dream_ThrustAvail*(dream_OA_rho/SL_rho))]);
hold off
axis([0,1200,25000,60000]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Thrust (lb)');
legend('Thrust Required', 'Thrust Available','Location','northwest');
title('Dreamliner - Thrust vs. Velocity (38,000 ft)');
ax = gca;
ax.XMinorGrid = 'on';

OA_dream_LiftDragRatio (OA_dream_LiftDragRatio == 0) = NaN;

subplot(2,1,2)
plot(dream_Vinf, OA_dream_LiftDragRatio);
axis([400,1200,0,20]);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Lift/Drag Ratio');
title('Dreamliner - Lift/Drag vs. Velocity (38,000 ft)');

figure
plot(dream_Vinf, OA_dream_RC);
grid on
xlabel('Freestream Velocity (ft/s)');
ylabel('Rate of Climb (ft/min)');
title('Dreamliner - Rate of Climb vs. Velocity (38,000 ft)');
axis([0,1200,0,1000]);

%% Calculations %%

[SL_pred_RC_max, SL_pred_RC_max_idx] = max(SL_pred_RC)
SL_pred_Vel_RC_max = pred_Vinf(SL_pred_RC_max_idx)
[pred_CL_CD_max, pred_CL_CD_max_idx] = max(SL_pred_LiftDragRatio)
pred_maxGlideDist = pred_CL_CD_max*pred_OA / 5280
pred_equiGlideVel = sqrt(2*cos(atan(1/pred_CL_CD_max))*(pred_grossWeight - pred_fuelWeight)/(pred_wingArea*.0014962*SL_pred_CL(pred_CL_CD_max_idx)))

[SL_dream_RC_max, SL_dream_RC_max_idx] = max(SL_dream_RC)
SL_dream_Vel_RC_max = dream_Vinf(SL_dream_RC_max_idx)
[dream_CL_CD_max, dream_CL_CD_max_idx] = max(SL_dream_LiftDragRatio)
dream_maxGlideDist = dream_CL_CD_max*dream_OA / 5280
dream_equiGlideVel = sqrt(2*cos(atan(1/pred_CL_CD_max))*(dream_grossWeight - dream_fuelWeight)/(dream_wingArea*.0014962*SL_dream_CL(dream_CL_CD_max_idx)))

