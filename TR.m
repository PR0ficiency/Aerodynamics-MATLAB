function [ thrust_required ] = TR( weight, LD_ratio )
% Calculates Thrust Required based on provided parameters

thrust_required = zeros(size(LD_ratio));

for i=1:size(LD_ratio)
    if LD_ratio(i) == 0
        thrust_required(i) = 0;
    else
        thrust_required(i) = weight / LD_ratio(i);
    end
end

end

