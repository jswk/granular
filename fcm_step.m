function [ U, V ] = fcm_step( X, sigmas, U, m, dist )
V = gen_V(X, U, m);
U = gen_U(X, V, dist, m, sigmas);
end

