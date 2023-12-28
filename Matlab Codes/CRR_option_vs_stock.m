
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program implements the binomial model for option pricing         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Input parameters

    r=0.0015; mu=0.01; sig=0.47;
    K=118; T=1;
    N=52; dt=T/N; NK=10; dK=K/NK;
    gap=5; K1=K+gap*dK; K2=K-gap*dK; 

%   Calculate parameters

    rdt=sqrt(dt);
    DCF=1/(1+r*dt);
    u=(1+mu*dt+sig*rdt); d=(1+mu*dt-sig*rdt);
    q=((mu-r)*dt+sig*rdt)/(2*sig*rdt);
    N=round(T/dt);

%   Tree construction

    S=zeros(N+1,N+1);
    S(1,1)=1;
    for i=2:N+1
        S(1,i)=S(1,i-1)*d;
        for j=2:i
            S(j,i)=S(j-1,i-1)*u;
        end
    end

%   Payoff function

    S0=0:dK:2*K1; CP=zeros(size(S0)); del=CP;
    for n=1:length(S0)
        C=S;
        for j=1:(N+1)
%            C(j,N+1)=max(S0(n)*S(j,N+1)-K,0);                       % call 
            C(j,N+1)=max(K-S0(n)*S(j,N+1),0);                      % put
%            C(j,N+1)=max(S0(n)*S(j,N+1)-K1,0)+max(K2-S0(n)*S(j,N+1),0); % straddle
        end
        
%   Backward induction

        for i=N:-1:1
            for j=1:i
                C(j,i)=DCF*(q*C(j,i+1)+(1-q)*C(j+1,i+1));
            end
        end

        CP(n)=C(1,1);
        del(n)=(C(2,2)-C(1,2))/(S(2,2)-S(1,2))/S0(n);
    end
    
    plot(S0,CP,'r');
    hold;
    payoff=zeros(size(CP));
    for n=1:length(S0)
%        payoff(n)=max(S0(n)-K,0);                   % call
        payoff(n)=max(K-S0(n),0);                   % put
%        payoff(n)=max(S0(n)-K1,0)+max(K2-S0(n),0);    % straddle
    end
    plot(S0,payoff);
    hold
    
    