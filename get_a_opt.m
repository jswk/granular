function [ a ] = get_a_opt( G, Y )
a = (G'*G)\(G'*Y);
end