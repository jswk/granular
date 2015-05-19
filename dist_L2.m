function [ D ] = dist_L2( V, v, sigmas )
D = zeros(size(V,1),1);
for i = 1:size(V,1)
    D(i) = sum(((V(i,:) - v)./sigmas).^2);
end
end

