classdef FCM
    
    properties
        data
        c
        m
        max_step
        dist
    end
    
    methods
        function obj = FCM(data, c, m, dist, max_step)
            obj.data = data;
            obj.c = c;
            obj.m = m;
            obj.dist = dist;
            obj.max_step = max_step;
        end
        
        function [ V, U, Q, Q_m ] = run(obj)
            U = FCM.random_U(size(obj.data,1), obj.c);
            step = 1;
            Q_m = [];
            stop = false;
            while not(stop);
                U_prev = U;
                [U, V] = obj.fcm_step(U);
                Q = FCM.calc_Q(U, V, obj.data, obj.m, obj.dist);
                Q_m(step) = Q;
                step = step + 1;
                diff_U = U - U_prev;
                %if max(diff_U(:).^2) < eps
                if step > obj.max_step
                    stop = true;
                end
            end
        end
        
        function [ U, V ] = fcm_step( obj, U )
            V = FCM.gen_V(U, obj.data, obj.m);
            U = FCM.gen_U(V, obj.data, obj.m, obj.dist);
        end
    end
    
    methods(Static)
        function U = random_U( N, c )
            U = rand(c,N);
            U = bsxfun(@rdivide, U, sum(U));
        end

        function [ V ] = gen_V( U, data, m )
            dim_count = size(data,2);
            c = size(U, 1);
            V = zeros(c, dim_count);
            for i = 1:c
                for t = 1:dim_count
                    V(i,t) = sum(bsxfun(@times, U(i,:).^m, data(:, t)'));
                    V(i,t) = V(i,t) / sum(U(i,:).^m);
                end
            end
        end

        function [ U ] = gen_U( V, data, m, dist )
            N = size(data,1);
            c = size(V, 1);

            U = zeros(c, N);
            for s = 1:c
                for t = 1:N
                    d_st = dist.apply(V(s,:), data(t,:));
                    sum_matrix = dist.apply(V, data(t,:));
                    sum_j = (d_st./sum_matrix).^(2/(m-1));
                    U(s,t) = 1 / sum(sum_j);
                end
            end
            U = bsxfun(@rdivide, U, sum(U));
        end
        
        function [ Q ] = calc_Q( U, V, data, m, dist )
            N = size(data,1);
            c = size(U, 1);

            Q = 0;
            for i = 1:c
                for k = 1:N
                    Q = Q + U(i,k)^m * dist.apply(data(k,:), V(i,:));
                end
            end
        end
    end
    
end