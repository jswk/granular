function [ V, U, Q, Q_m ] = fcm_run( data, c, m, dist, max_step )
U = generate_random_U(size(data,1), c);
sigmas = calc_sigmas(data);
step = 1;
Q_m = [];
stop = false;
while not(stop);
    U_prev = U;
    [U, V] = fcm_step(data, sigmas, U, m, dist);
    Q = calc_Q(data, U, V, dist, m);
    Q_m(step) = Q;
    step = step + 1;
    diff_U = U - U_prev;
    %if max(diff_U(:).^2) < eps
    if step > max_step
        stop = true;
    end
end
end
