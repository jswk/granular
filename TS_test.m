function [ Yhat ] = TS_test( X, U, a )
N = size(X, 1);
dim = size(X, 2);

Yhat = zeros(N, 1);
a_mat = vec2mat(a, dim+1);
for i = 1:N
    z = [1 X(i,:)];
    Yhat(i) = U(:,i)' * a_mat * z';
end

end

