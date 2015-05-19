function [ U_out, V ] = fcm_step( data, sigmas, U, m, dist )
clusters_count = size(U,1);
data_count = size(data,1);
dim_count = size(data,2);
V = zeros(clusters_count,dim_count);
for i = 1:clusters_count
    for t = 1:dim_count
        V(i,t) = sum(bsxfun(@times, U(i,:).^m, data(:, t)'));
        V(i,t) = V(i,t) / sum(U(i,:).^m);
    end
end
U_out = zeros(clusters_count, data_count);
for s = 1:clusters_count
    for t = 1:data_count
        d_st = dist(V(s,:),data(t,:), sigmas);
        sum_matrix = dist(V, data(t,:), sigmas);
        sum_j = (d_st./sum_matrix).^(2/(m-1));
        U_out(s,t) = 1 / sum(sum_j);
    end
end

end

