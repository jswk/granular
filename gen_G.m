function [ G ] = gen_G( data, V, U )
N = size(data, 1);
c = size(V, 1);
G = zeros(N, c, N+1);
for i = 1:N
    for j = 1:c
        z = [1 data(i, :)];
        g = U(j, :)';
        G(i,j) = g * z;
    end
end
end
