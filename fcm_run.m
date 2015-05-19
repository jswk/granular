function [ V, U, Q ] = fcm_run( data, c, m, dist )
U = generate_random_U(size(data,1), c);
sigmas = calc_sigmas(data);
for i = 1:100
    [U, V] = fcm_step(data, sigmas, U, m, dist);
    Q = calc_Q(data, U, V, dist, m);
end
end


