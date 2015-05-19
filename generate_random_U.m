function [ U ] = generate_random_U( data, clusters )
U = rand(clusters,data);
U = bsxfun(@rdivide, U, sum(U));
end

