%   Black call option drive

    r=0.0065; sig=0.47;
    S0=170; T=1; %T=1/12;
    dK=5;
    K=170; %110:dK:210; 
    CP=zeros(size(K));
    DCF=exp(-r*T);
    F=S0/DCF;
    for i=1:length(K)
        Ki=K(i);
        CP(i)=call(F,Ki,T,sig);
    end
    CP
    %plot(K,CP);