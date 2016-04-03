function [ Cp_cr ] = Cp_critical( Mach, gamma )

Cp_cr = zeros(size(Mach));

for i=1:length(Mach)
    
    Cp_cr(i)=(2/(gamma*(Mach(i)^2)))*((((2 + (gamma - 1)*(Mach(i))^2)/(gamma+1))^(gamma/(gamma-1)))-1);

end

