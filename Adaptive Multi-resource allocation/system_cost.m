function cost = system_cost(bandwidth,resource,T,W,X,Y)
    temp = 0;
    temp2 =0;
    for j = 1:T
        for i = 1:W
            temp =temp + (i*X(i,j));
        end
    end
    for k1 = 1:W
        temp = temp + (i*Y(i));
    end
    temp = temp*bandwidth;
    for j1 = 1:T
        for i1 = 1:W
            temp2 =temp2 + (j1*X(i1,j1));
        end
    end
    temp2 = temp2 * resource;
    cost = temp2 + temp;
end