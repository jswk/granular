function [ G ] = gen_G( data, V, U )
N = size(data, 1);
c = size(V, 1);
d = size(data, 2);
G = zeros(N, c*(d+1));
for i = 1:N
    for j = 1:c
        z = [1 data(i, :)];
        A = U(j,i);
        %g = U(j, :)';
        Az = A * z;
        for k = 1:d+1
            G(i,(j-1)*(d+1)+k) = Az(k);
        end
    end
end
end
