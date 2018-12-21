function trans_probability = transition_prob(arrival_rate,U,V,X,Y)
    sum=0.0;
    sum = sum + arrival_rate + X(1,1)* U(1,1) + X(1,2)*U(1,2) + X(2,1)*U(2,1) + X(2,2) * U(2,2);
    sum = Y(1)* V(1) + Y(2)*V(2) + sum;
    trans_probability = arrival_rate/sum; 
end