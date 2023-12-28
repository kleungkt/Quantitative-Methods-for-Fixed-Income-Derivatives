%   To produce a Brownian path
    
    n=10; 
    N=2^n; T=1; dt=T/N; rdt=sqrt(dt);
    S=zeros(N+1,1);
    S(1)=0.0;
    for i=1:N
        S(i+1)=S(i)+rdt*randn;
    end
    t=0:dt:T;
    plot(t,S);
    xlabel('time');
    ylabel('Brownian motion');
    