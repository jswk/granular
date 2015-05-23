classdef TS < handle
    
    properties
        X
        Y
        X_learn
        Y_learn
        X_test
        Y_test
        c
        m
        max_step
    end
    
    methods
        function obj = TS( X, Y, c, m, max_step )
            obj.X = X;
            obj.Y = Y;
            obj.X_learn = X;
            obj.Y_learn = Y;
            obj.X_test = X;
            obj.Y_test = Y;
            
            obj.c = c;
            obj.m = m;
            obj.max_step = max_step;
        end
        
        function [ a_opt, V, Q_learn, Q_test ] = run( obj )
            dist = DistL2(obj.X_learn);
            fcm_obj = FCM(obj.X_learn, obj.c, obj.m, dist, obj.max_step);
            [V, U, ~, ~] = fcm_obj.run();
            G = TS.gen_G(obj.X_learn, V, U);
            a_opt = TS.get_a_opt(G, obj.Y_learn);
            
            Y_learn_hat = TS.test(obj.X_learn, U, a_opt);
            Q_learn = sqrt(sum((obj.Y_learn-Y_learn_hat).^2)/size(obj.Y_learn,1));
            
            U_test = FCM.gen_U(V, obj.X_test, obj.m, dist);
            Y_test_hat = TS.test(obj.X_test, U_test, a_opt);
            Q_test = sqrt(sum((obj.Y_test-Y_test_hat).^2)/size(obj.Y_test,1));
        end
        
        function divide_data( obj, div_rate )
            len = size(obj.X, 1);
            perm = randperm(len);
            [ Xlearn, Xtest ] = TS.divide_dataset(obj.X, div_rate, perm);
            [ Ylearn, Ytest ] = TS.divide_dataset(obj.Y, div_rate, perm);
            obj.X_learn = Xlearn;
            obj.X_test = Xtest;
            obj.Y_learn = Ylearn;
            obj.Y_test = Ytest;
        end
        
        function undivide_data(obj)
            obj.X_learn = obj.X;
            obj.X_test = obj.X;
            obj.Y_learn = obj.Y;
            obj.Y_test = obj.Y;
        end
    end
    
    methods(Static)
        function [ G ] = gen_G( X, V, U )
            N = size(X, 1);
            c = size(V, 1);
            d = size(X, 2);
            G = zeros(N, c*(d+1));
            for i = 1:N
                for j = 1:c
                    z = [1 X(i, :)];
                    A = U(j,i);
                    Az = A * z;
                    for k = 1:d+1
                        G(i,(j-1)*(d+1)+k) = Az(k);
                    end
                end
            end
        end

        function [ a ] = get_a_opt( G, Y )
            a = (G'*G)\(G'*Y);
        end
        
        function [ Yhat ] = test( X, U, a )
            N = size(X, 1);
            dim = size(X, 2);

            Yhat = zeros(N, 1);
            a_mat = vec2mat(a, dim+1);
            for i = 1:N
                z = [1 X(i,:)];
                Yhat(i) = U(:,i)' * a_mat * z';
            end

        end

        
        function [ X_learn, X_test ] = divide_dataset( X, div_rate, perm )
            len = size(X,1);
            len_learn = ceil(len*div_rate);
            len_test = len - len_learn;
            dim = size(X, 2);

            X_learn = zeros(len_learn, dim);
            X_test = zeros(len_test, dim);

            for i = 1:len
                if i <= len_learn
                    X_learn(i,:) = X(perm(i),:);
                else
                    X_test(i-len_learn,:) = X(perm(i),:);
                end
            end       
        end
    end
    
end

