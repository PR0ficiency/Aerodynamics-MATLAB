function [ LD_ratio ] = LDR( lift, drag, CL_max )
% Function returns LD_ratio for provided parameters. Checks for infinities

LD_ratio = zeros(size(lift,1),1);

for i=1:size(LD_ratio,1)
    if isinf(lift(i)) || isinf(drag(i)) || (lift(i) > CL_max)
        LD_ratio(i) = 0;
    else
        LD_ratio(i) = lift(i)/drag(i);
    end
end

end

