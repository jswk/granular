function [ V ] = gen_V( X, U, m )
clusters_count = size(U,1);
dim_count = size(X,2);
V = zeros(clusters_count,dim_count);
for i = 1:clusters_count
    for t = 1:dim_count
        V(i,t) = sum(bsxfun(@times, U(i,:).^m, X(:, t)'));
        V(i,t) = V(i,t) / sum(U(i,:).^m);
    end
end

end

