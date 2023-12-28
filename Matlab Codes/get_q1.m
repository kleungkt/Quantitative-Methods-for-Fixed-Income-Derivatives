
    function q1=get_q1(P0,r,q,N,dt)
    
    P=zeros(N,N);
    P1=P;
    P2=P;
    
    for i=1:N
        P(i,N)=100/(1+r(i,N)*dt);
    end
    
    for i=1:(N-1)
        P1(i,N-1)=P(i+1,N)/(1+r(i,N-1)*dt);
    end
        
    for j=(N-2):-1:1
        for i=1:j
            P1(i,j)=(q(j)*P1(i,j+1)+(1-q(j))*P1(i+1,j+1))/(1+r(i,j)*dt);
        end
    end

    for i=1:(N-1)
        P2(i,N-1)=(P(i,N)-P(i+1,N))/(1+r(i,N-1)*dt);
    end
        
    for j=(N-2):-1:1
        for i=1:j
            P2(i,j)=(q(j)*P2(i,j+1)+(1-q(j))*P2(i+1,j+1))/(1+r(i,j)*dt);
        end
    end
    
    q1=(P0(N)-P1(1,1))/P2(1,1);
    
    return
    