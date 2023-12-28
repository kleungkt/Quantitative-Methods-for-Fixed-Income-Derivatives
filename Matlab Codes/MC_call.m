
%   This code is for Monte Carlo simulation of call options

    r=0.0065; sig=0.47;
    S0=160; T=1; %T=1/12;
    dK=5;
    K=160; %110:dK:210;
    DCF=exp(-r*T);
    F0=S0/DCF;
    
    n=100:100:20000;
    np=length(n);
    
    ave=zeros(np,1);
    for j=1:np
        z=randn(n(j),1);
        F=F0*exp(-0.5*sig^2*T)*exp(sig*sqrt(T)*z);
    
        for i=1:n(j)
            ave(j)=ave(j)+max(F(i)-K,0);
        end
        ave(j)=ave(j)/n(j);
    end
    plot(n,ave); hold
    xx=[n(1),n(np)]; yy=[CP(1),CP(1)];
    plot(xx,yy);
    hold
    
    
    