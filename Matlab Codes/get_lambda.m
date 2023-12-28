
    function diff=get_lambda(lam0,P0,r,mu,sig,N,dt)
    
    rdt=sqrt(dt);
    for i=1:N-1
        r(i,N)=r(i,N-1)+(mu+lam0)*dt-sig*rdt;
    end
    r(N,N)=r(N-1,N-1)+(mu+lam0)*dt+sig*rdt;
    
    P=zeros(N+1,N+1);
    P(:,N+1)=100*ones(N+1,1);
    for j=N:-1:1
        for i=1:j
            P(i,j)=0.5*(P(i,j+1)+P(i+1,j+1))/(1+r(i,j)*dt);
        end
    end

    diff=P0(N)-P(1,1);
    
    return
    