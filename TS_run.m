function [ a_opt, V, Q, Q_TS ] = TS_run( X, Y, c, m, max_step )
[V, U, Q, Q_m] = fcm_run(X, c, m, @dist_L2, max_step);
G = gen_G(X, V, U);
a_opt = get_a_opt(G, Y);
Yhat = TS_test(X, U, a_opt);
% RMSE
Q_TS = sqrt(sum((Y-Yhat).^2)/size(Y,1));
end

