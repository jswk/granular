function [ X_learn, Y_learn, X_test, Y_test ] = divide_into_learn_and_test( X, Y, div_rate )
len = size(X,1);
len_learn = ceil(len*div_rate);
len_test = len - len_learn;
dim = size(X, 2);

X_learn = zeros(len_learn, dim);
Y_learn = zeros(len_learn, 1);
X_test = zeros(len_test, dim);
Y_test = zeros(len_test, 1);

perm = randperm(len);

for i = 1:len
    if i <= len_learn
        X_learn(i,:) = X(perm(i),:);
        Y_learn(i,1) = Y(perm(i),1);
    else
        X_test(i-len_learn,:) = X(perm(i),:);
        Y_test(i-len_learn,1) = Y(perm(i),1);
    end
end       

end

