function [ a_opt, Yhat, Qhat ] = TS_run( X, Y, c, m, max_step )
[V, U, Q, Q_m] = fcm_run(X, c, m, @dist_L2, max_step);
G = gen_G(X, V, U);
a_opt = get_a_opt(G, Y);
Yhat = TS_test(X, U, a_opt);
Qhat = sqrt(sum((Y-Yhat).^2)/size(Y,1));

end

