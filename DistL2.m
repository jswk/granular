classdef DistL2
    
    properties
        sigmas
    end
    
    methods
        function obj = DistL2(data)
            obj.sigmas = DistL2.calc_sigmas(data);
        end
        
        function D = apply( obj, V, v )
            D = zeros(size(V,1),1);
            for i = 1:size(V,1)
                D(i) = sum(((V(i,:) - v)./obj.sigmas).^2);
            end
        end
    end
    
    methods(Static)
        function sigmas = calc_sigmas( data )
            sigmas = std(data);
        end
    end
    
end

