function reward = lump_reward(income,penalty,cost,U,V,type_of_request,i,j)
    if type_of_request == -1 %Request Departure
        reward = 0;
    end
    if type_of_request == 0 %Request Rejected
        reward = -1*penalty;
    end
    if type_of_request == 1  %Request is accepted at cloudlet
        reward = income - (cost/(U(i,j)));
    end
    if type_of_request == 2  %Request is accepted at distant cloud
        reward = income - (cost/(V(i)));
    end
end    
    
    