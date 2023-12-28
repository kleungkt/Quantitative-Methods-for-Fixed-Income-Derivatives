%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is to calculate prices of bond option for various yields    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   zero-coupon yields

    r0=0.02:0.0005:0.05;
    
%   Model parameters

    mu=0.00; sig=0.005; 
    
%   Option and bond parameters

    c=5; TC=1; TB=10; K=100;
    
%   Parameters for the tree

    dt=0.5; rdt=sqrt(dt);
    N=TB/dt;                % index for bond's maturity
    M=TC/dt;                % index for option's maturity
    
    P0=zeros(N,1);
    lam=zeros(N,1);
    
    for j=1:N
        P0(j)=100/(1+dt*r0(j))^(j);
    end
    
    r=zeros(N,N);
    r(1,1)=r0(1); OPTIONS=[];
    for j=2:N
        jj=j; lam0=0.0;
        lam1=fzero('get_lambda',lam0,OPTIONS,P0,r,mu,sig,jj,dt);
        lam(j)=lam1;
        for i=1:j-1
            r(i,j)=r(i,j-1)+(mu+lam(j))*dt-sig*rdt;
        end
        r(j,j)=r(j-1,j-1)+(mu+lam(j))*dt+sig*rdt;
    end
    
        
    P=zeros(N+1,N+1);
    P(:,N+1)=100*ones(N+1,1);
    for j=N:-1:M+1
        for i=1:j
            P(i,j)=0.5*(P(i,j+1)+P(i+1,j+1)+c)/(1+r(i,j)*dt);
        end
    end
        
    C=zeros(M+1,M+1);                       % option value tree
    
    for i=1:M+1
        C(i,M+1)=max(P(i,M+1)-K,0);
    end
    
    for j=M:-1:1
        for i=1:j
            C(i,j)=0.5*(C(i,j+1)+C(i+1,j+1))/(1+r(i,j)*dt);
        end
    end
    C(1,1)
    