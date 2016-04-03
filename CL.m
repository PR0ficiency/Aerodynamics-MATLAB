function [ lift_coefficient ] = CL( weight, rho_inf, v_inf, area)
% Calculate the lift_coefficient based on provided parameters

% preallocate size %
lift_coefficient = zeros(size(v_inf,1),1);

for i=1:size(lift_coefficient,1)
    lift_coefficient(i) = weight/(0.5*rho_inf*(v_inf(i)^2)*area);
end

end

