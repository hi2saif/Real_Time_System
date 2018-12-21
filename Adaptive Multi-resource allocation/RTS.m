clear
M=10; %total number of virtual machines
B=10; %total number of bandwidth units
Arrival_rate=12;
T=2;   % maximum number of cloudlet VM's that can be allocated to one service 
W=2;   % maximum number of bandwidth units that can be allocated to one service
income_to_accept = 6;
penalty_to_reject = 3;
cost_time = 1;
cost_bandwidth= 1;
cost_resource = 1;
X = [0 0;0 0 ];         % indicates the number of different type of service at cloudlet
Y = [0 0];              % indicates the number of different type of service at dist cloud
U = [3 4;5 6];          % departure rate of diff type of service at cloudlet 
V = [3.5 5.5];          % departure rate of diff type of service at dist cloud


% for x11 
for p = 0:10
    X = [p 0;0 0 ];
    sumB=0;
    for j =1:T
        for i=1:W
            sumB = sumB+(i*X(i,j));
        end
    end
    for i =1:W
        sumB = sumB+(i*Y(i));
    end
    remainBW = B-sumB;
    sumVM=0;
    for j =1:T
        for i=1:W
            sumVM = sumVM+(j*X(i,j));
        end
    end
    remainVM = M-sumVM;
    
    event_rate = event_rate_func(T,W,Arrival_rate,1,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a11 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a12 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,1,2) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a21 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,2,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a22 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,2,2) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    event_rate = event_rate_func(T,W,Arrival_rate,2,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a1 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,2,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a2 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,2,2,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    event_rate = event_rate_func(T,W,Arrival_rate,0,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a0 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,0,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    probablity_a11 = reward_a11 / ( reward_a11+reward_a12 + reward_a21 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a12 = reward_a12 / ( reward_a12+reward_a11 + reward_a21 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a21 = reward_a21 / ( reward_a21+reward_a11 + reward_a12 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a22 = reward_a22 / ( reward_a22+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a2 +reward_a0);
    probablity_a1 = reward_a1 / ( reward_a1+reward_a11 + reward_a21 + reward_a12 + reward_a22 + reward_a2 +reward_a0);
    probablity_a2 = reward_a2 / ( reward_a2+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a22 +reward_a0);
    probablity_a0 = reward_a0 / ( reward_a0+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a22 +reward_a2);
    r=X;
    r(1,1) = r(1,1)+1;
    prob_a11 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(1,2) = r(1,2)+1;
    prob_a12 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(2,1) = r(2,1)+1;
    prob_a21 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(2,2) = r(2,2)+1;
    prob_a22 = transition_prob(Arrival_rate,U,V,r,Y)
    r=Y;
    r(1) = r(1)+1;
    prob_a1 = transition_prob(Arrival_rate,U,V,X,r)
    r=Y;
    r(2) = r(2)+1;
    prob_a2 = transition_prob(Arrival_rate,U,V,X,r)
    
    sum_of_all = prob_a11+prob_a12+prob_a21+prob_a22+prob_a1+prob_a2;
    prob1_a11 = prob_a11/sum_of_all;
    prob1_a12 = prob_a12/sum_of_all;
    prob1_a21 = prob_a21/sum_of_all;
    prob1_a22 = prob_a22/sum_of_all;
    prob1_a1 = prob_a1/sum_of_all;
    prob1_a2 = prob_a2/sum_of_all;
    if p==0
        mp0 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==1
        mp1 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==2
        mp2 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==3
        mp3 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==4
        mp4 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==5
        mp5 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==6
        mp6 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==7
        mp7 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==8
        mp8 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==9
        mp9 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==10
        mp10 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    %prob_a11 = transition_prob
end
y = [mp0;mp1;mp2;mp3;mp4;mp5;mp6;mp7;mp8;mp9]

figure(1)
bar(y,'stacked')


% for x12 
for p = 0:5
    X = [0 p;0 0 ];
    sumB=0;
    for j =1:T
        for i=1:W
            sumB = sumB+(i*X(i,j));
        end
    end
    for i =1:W
        sumB = sumB+(i*Y(i));
    end
    remainBW = B-sumB;
    sumVM=0;
    for j =1:T
        for i=1:W
            sumVM = sumVM+(j*X(i,j));
        end
    end
    remainVM = M-sumVM;
    
    event_rate = event_rate_func(T,W,Arrival_rate,1,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a11 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a12 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,1,2) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a21 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,2,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a22 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,2,2) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    event_rate = event_rate_func(T,W,Arrival_rate,2,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a1 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,2,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a2 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,2,2,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    event_rate = event_rate_func(T,W,Arrival_rate,0,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a0 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,0,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    probablity_a11 = reward_a11 / ( reward_a11+reward_a12 + reward_a21 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a12 = reward_a12 / ( reward_a12+reward_a11 + reward_a21 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a21 = reward_a21 / ( reward_a21+reward_a11 + reward_a12 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a22 = reward_a22 / ( reward_a22+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a2 +reward_a0);
    probablity_a1 = reward_a1 / ( reward_a1+reward_a11 + reward_a21 + reward_a12 + reward_a22 + reward_a2 +reward_a0);
    probablity_a2 = reward_a2 / ( reward_a2+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a22 +reward_a0);
    probablity_a0 = reward_a0 / ( reward_a0+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a22 +reward_a2);
    r=X;
    r(1,1) = r(1,1)+1;
    prob_a11 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(1,2) = r(1,2)+1;
    prob_a12 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(2,1) = r(2,1)+1;
    prob_a21 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(2,2) = r(2,2)+1;
    prob_a22 = transition_prob(Arrival_rate,U,V,r,Y)
    r=Y;
    r(1) = r(1)+1;
    prob_a1 = transition_prob(Arrival_rate,U,V,X,r)
    r=Y;
    r(2) = r(2)+1;
    prob_a2 = transition_prob(Arrival_rate,U,V,X,r)
    
    sum_of_all = prob_a11+prob_a12+prob_a21+prob_a22+prob_a1+prob_a2;
    prob1_a11 = prob_a11/sum_of_all;
    prob1_a12 = prob_a12/sum_of_all;
    prob1_a21 = prob_a21/sum_of_all;
    prob1_a22 = prob_a22/sum_of_all;
    prob1_a1 = prob_a1/sum_of_all;
    prob1_a2 = prob_a2/sum_of_all;
    if p==0
        mp0 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==1
        mp1 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==2
        mp2 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==3
        mp3 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==4
        mp4 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==5
        mp5 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    %prob_a11 = transition_prob
end
y1 = [mp0;mp1;mp2;mp3;mp4;mp5]

figure(2)
bar(y1,'stacked')

% for x21 
for p = 0:5
    X = [0 p;0 0 ];
    sumB=0;
    for j =1:T
        for i=1:W
            sumB = sumB+(i*X(i,j));
        end
    end
    for i =1:W
        sumB = sumB+(i*Y(i));
    end
    remainBW = B-sumB;
    sumVM=0;
    for j =1:T
        for i=1:W
            sumVM = sumVM+(j*X(i,j));
        end
    end
    remainVM = M-sumVM;
    
    event_rate = event_rate_func(T,W,Arrival_rate,1,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a11 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a12 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,1,2) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a21 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,2,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a22 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,1,2,2) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    event_rate = event_rate_func(T,W,Arrival_rate,2,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a1 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,2,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    reward_a2 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,2,2,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    event_rate = event_rate_func(T,W,Arrival_rate,0,X,Y,V,U);
    sojourn_time = 1/event_rate;
    reward_a0 = lump_reward(income_to_accept,penalty_to_reject,cost_time,U,V,0,1,1) - (sojourn_time*system_cost(cost_bandwidth,cost_resource,T,W,X,Y));
    probablity_a11 = reward_a11 / ( reward_a11+reward_a12 + reward_a21 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a12 = reward_a12 / ( reward_a12+reward_a11 + reward_a21 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a21 = reward_a21 / ( reward_a21+reward_a11 + reward_a12 + reward_a22 + reward_a1 + reward_a2 +reward_a0);
    probablity_a22 = reward_a22 / ( reward_a22+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a2 +reward_a0);
    probablity_a1 = reward_a1 / ( reward_a1+reward_a11 + reward_a21 + reward_a12 + reward_a22 + reward_a2 +reward_a0);
    probablity_a2 = reward_a2 / ( reward_a2+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a22 +reward_a0);
    probablity_a0 = reward_a0 / ( reward_a0+reward_a11 + reward_a21 + reward_a12 + reward_a1 + reward_a22 +reward_a2);
    r=X;
    r(1,1) = r(1,1)+1;
    prob_a11 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(1,2) = r(1,2)+1;
    prob_a12 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(2,1) = r(2,1)+1;
    prob_a21 = transition_prob(Arrival_rate,U,V,r,Y)
    r=X;
    r(2,2) = r(2,2)+1;
    prob_a22 = transition_prob(Arrival_rate,U,V,r,Y)
    r=Y;
    r(1) = r(1)+1;
    prob_a1 = transition_prob(Arrival_rate,U,V,X,r)
    r=Y;
    r(2) = r(2)+1;
    prob_a2 = transition_prob(Arrival_rate,U,V,X,r)
    
    sum_of_all = prob_a11+prob_a12+prob_a21+prob_a22+prob_a1+prob_a2;
    prob1_a11 = prob_a11/sum_of_all;
    prob1_a12 = prob_a12/sum_of_all;
    prob1_a21 = prob_a21/sum_of_all;
    prob1_a22 = prob_a22/sum_of_all;
    prob1_a1 = prob_a1/sum_of_all;
    prob1_a2 = prob_a2/sum_of_all;
    if p==0
        mp0 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==1
        mp1 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==2
        mp2 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==3
        mp3 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==4
        mp4 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    if p==5
        mp5 = [prob1_a11 prob1_a12 prob1_a21 prob1_a22 prob1_a1 prob1_a2];
    end
    %prob_a11 = transition_prob
end
y2 = [mp0;mp1;mp2;mp3;mp4;mp5]

figure(3)
bar(y2,'stacked')
