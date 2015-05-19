function [ Q ] = calc_Q( data, U, V, dist, m )
c = size(V,1);
N = size(data,1);
t = size(V,2);

Q = 0;
for i = 1:c
    for k = 1:N
        Q = Q + U(i,k)^m * dist(data(k,:), V(i,:), ones(1, t));
    end
end


end

