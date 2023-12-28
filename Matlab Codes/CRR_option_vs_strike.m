
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program implements the binomial model for option pricing         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Input parameters

    r=0.0065; mu=0.01; sig=0.47;
    S0=160; T=1/12;
    N=52; dt=T/N; dK=5;
    q=(mu-r)*sqrt(dt)/(2*sig)+0.5; 
    
%   Calculate parameters

    U=1+mu*dt+sig*sqrt(dt);
    D=1+mu*dt-sig*sqrt(dt);
    DCF=1/(1+r*dt);
    N=round(T/dt);

%   Tree construction

    S=zeros(N+1,N+1);
    S(1,1)=S0;
    for j=2:N+1
        S(1,j)=S(1,j-1)*D;
        for i=2:j
            S(i,j)=S(i-1,j-1)*U;
        end
    end

%   Payoff function

    K=110:dK:210; CP=zeros(size(K)); 
    for n=1:length(K)
        C=S;
        for i=1:(N+1)
            C(i,N+1)=max(S(i,N+1)-K(n),0);                       % call 
        end
        
%   Backward induction

        for j=N:-1:1
            for i=1:j
                C(i,j)=DCF*(q*C(i,j+1)+(1-q)*C(i+1,j+1));
            end
        end
        CP(n)=C(1,1);
    end
    
    plot(K,CP,'rd'); 
    
    