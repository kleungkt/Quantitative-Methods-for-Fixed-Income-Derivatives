%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is to calculate prices of bond option for various yields    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    format long;
    
    y=0.02:0.005:0.08;
    n=length(y);
    O=zeros(n,1);
    
    for k=1:n
        
%   zero-coupon yields

        r0=y(k)*ones(60,1); %:0.0005:0.05;
    
%   Model parameters

        th=0.001; sig=0.0075; 
    
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
        q=zeros(N,1);
        r(1,1)=r0(1); 
    
        for j=2:N
            for i=1:j-1
                r(i,j)=r(i,j-1)+th*dt-sig*rdt;
            end
            r(j,j)=r(j-1,j-1)+th*dt+sig*rdt;
        end
    
        for j=2:N
            jj=j; q0=0.5;
            q1=get_q1(P0,r,q,jj,dt);
            q(j-1)=q1;
        end
    
        B=zeros(N+1,N+1);
        B(:,N+1)=100*ones(N+1,1);
        for j=N:-1:M+1
            for i=1:j
                B(i,j)=(q(j)*B(i,j+1)+(1-q(j))*B(i+1,j+1)+c*dt)/(1+r(i,j)*dt);
            end
        end
        
        C=zeros(M+1,M+1);                       % option value tree
    
        for i=1:M+1
            C(i,M+1)=max(B(i,M+1)-K,0);
        end
    
        for j=M:-1:1
            for i=1:j
                C(i,j)=(q(j)*C(i,j+1)+(1-q(j))*C(i+1,j+1))/(1+r(i,j)*dt);
            end
        end
        O(k)=C(1,1);
    end
    plot(y,O,'*');
    
        