classdef Util
    
    methods(Static)        
        function plot_Y(Y_learn, Y_learn_hat, Y_test, Y_test_hat)
            plot(Y_learn, Y_learn_hat, '.k', "markersize", 10,
                 Y_test, Y_test_hat, '.r', "markersize", 10)
            maks = max(max(max(Y_learn),max(Y_learn_hat)),max(max(Y_test),max(Y_test_hat)));
            axis([0 maks 0 maks]);
        end
        
        function [ Q_learn_v, Q_test_v ] = main()
            mpg_data = dlmread('data/mpg.data');
            mpg_data_x = mpg_data(:,2:8);
            mpg_data_y = mpg_data(:,1);
            ts_obj = TS(mpg_data_x, mpg_data_y, 10, 2, 20);
            
            Q_learn_v = zeros(18,1);
            Q_test_v  = zeros(18,1);
            for j = 3:20
                ts_obj.c = j;
                j
                Q_learn = 0;
                Q_test = 0;
                for i = 1:10
                    i
                    ts_obj.divide_data(.7), [~,~,Q_learn_,Q_test_]=ts_obj.run();
                    Q_learn = Q_learn + Q_learn_;
                    Q_test = Q_test + Q_test_;
                end
                Q_learn_v(j-2,1) = Q_learn/10
                Q_test_v(j-2,1) = Q_test/10
            end
        end
        
        function plot()
            mpg_data = dlmread('data/mpg.data');
            mpg_data_x = mpg_data(:,2:8);
            mpg_data_y = mpg_data(:,1);
            ts_obj = TS(mpg_data_x, mpg_data_y, 5, 2, 20);
            ts_obj.divide_data(.7);
            [a_opt,V,Q_learn,Q_test]=ts_obj.run();
            Q_learn, Q_test
            
            U_learn = FCM.gen_U(V, ts_obj.X_learn, 2, DistL2(ts_obj.X_learn));
            U_test = FCM.gen_U(V, ts_obj.X_test, 2, DistL2(ts_obj.X_learn));
            Y_learn_hat = TS.test(ts_obj.X_learn, U_learn, a_opt);
            Y_test_hat = TS.test(ts_obj.X_test, U_test, a_opt);
            Util.plot_Y(ts_obj.Y_learn, Y_learn_hat, ts_obj.Y_test, Y_test_hat)
        end
    end
    
end

