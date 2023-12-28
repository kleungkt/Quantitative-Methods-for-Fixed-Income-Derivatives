
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program implements the binomial model for option pricing         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Input parameters

    r=0.01; mu=0.02; sig=0.25;
    S0=110; K=110; T=1;
    n=10;
    N=2^n; dt=T/N;
    q=(mu-r)*sqrt(dt)/(2*sig)+0.5;
    
%   Calculate parameters

    U=1+r*dt+sig*sqrt(dt);
    D=1+r*dt-sig*sqrt(dt);
    DCF=1/(1+r*dt);

    N=round(T/dt);

%   Tree construction

    S=zeros(N+1,N+1);
    C=S;

    S(1,1)=S0;
    for j=2:N+1
        S(1,j)=S(1,j-1)*D;
        for i=2:j
            S(i,j)=S(i-1,j-1)*U;
        end
    end

%   Backward induction

    for i=1:(N+1)
        C(i,N+1)=max(S(i,N+1)-K,0);
    end

    for j=N:-1:1
        for i=1:j
            C(i,j)=DCF*(q*C(i,j+1)+(1-q)*C(i+1,j+1));
        end
    end

    C0=C(1,1)
    hedge=(C(2,2)-C(1,2))/(S(2,2)-S(1,2))
        
    