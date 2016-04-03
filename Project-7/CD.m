function [ drag_coefficient ] = CD( CD_0, CL, e, AR )
%Calculate Drag Coefficient based on provided parameters
drag_coefficient = zeros(size(CL,1),1);

    for i=1:size(CL,1)
        drag_coefficient(i) = CD_0 + (CL(i)^2)/(pi*e*AR);
    end

end

