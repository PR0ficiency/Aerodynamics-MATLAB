function [ C_p ] = Cp_calc( Mach, Cp_0 )
C_p = zeros(size(Mach));

for i=1:length(Mach)
    
    C_p(i)=Cp_0/(sqrt(1-Mach(i)^2));

end

end

