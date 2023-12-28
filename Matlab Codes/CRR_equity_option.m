
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program implements the binomial model for option pricing         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Input parameters

    r=0.01; mu=0.1; sig=0.235;
    S0=240; K=240; T=0.5;
    n=6;
    N=2^n; dt=T/N;

%   Calculate parameters

    U=1+mu*dt+sig*sqrt(dt);
    D=1+mu*dt-sig*sqrt(dt);
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

    q=(mu-r)*sqrt(dt)/(2*sig)+0.5;
    for j=N:-1:1
        for i=1:j
            C(i,j)=DCF*(q*C(i,j+1)+(1-q)*C(i+1,j+1));
        end
    end

    C0=C(1,1)
    hedge=(C(2,2)-C(1,2))/(S(2,2)-S(1,2))
        
    