function [ U ] = gen_U( X, V, dist, m, sigmas )
clusters_count = size(V,1);
data_count = size(X,1);

U = zeros(clusters_count, data_count);
for s = 1:clusters_count
    for t = 1:data_count
        d_st = dist(V(s,:),X(t,:), sigmas);
        sum_matrix = dist(V, X(t,:), sigmas);
        sum_j = (d_st./sum_matrix).^(2/(m-1));
        U(s,t) = 1 / sum(sum_j);
    end
end

end

