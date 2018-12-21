function value = event_rate_func(T,W,Arrival_rate,type_of_request,X,Y,V,U)
    value = Arrival_rate;
    if type_of_request == 0 %Request is rejected
        for j = 1:T
            for i = 1:W
                value = value + (X(i,j)*U(i,j));
            end
        end
        for k1 = 1:W
            value = value + (Y(k1)*V(k1));
        end
    end
    if type_of_request == 1   %Request is Accepted at cloudlet
        for j = 1:T
            for i = 1:W
                value = value + (X(i,j)*U(i,j));
            end
        end
        for k1 = 1:W
            value = value + (Y(k1)*V(k1));
        end
        value = value  + U(T,W);
    end
    if type_of_request == 2   %Request is Accepted at Distant cloud
        for j = 1:T
            for i = 1:W
                value = value + (X(i,j)*U(i,j));
            end
        end
        for k1 = 1:W
            value = value + (Y(k1)*V(k1));
        end
        value = value  + V(W);
    end
    if type_of_request == -1 %Service Departure from the cloudlet
        for j = 1:T
            for i = 1:W
                value = value + (X(i,j)*U(i,j));
            end
        end
        for k1 = 1:W
            value = value + (Y(k1)*V(k1));
        end
        value = value  - U(T,W);
    end
    if type_of_request == -2 %Service Departure from the distant cloud
        for j = 1:T
            for i = 1:W
                value = value + (X(i,j)*U(i,j));
            end
        end
        for k1 = 1:W
            value = value + (Y(k1)*V(k1));
        end
        value = value  - V(W);
    end
    
          
    