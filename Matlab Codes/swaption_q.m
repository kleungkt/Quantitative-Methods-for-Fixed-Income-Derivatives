%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is to calculate prices of swaptions                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    format long
    
%   Forward-rate curve

    f=0.01:0.0005:0.0395;
    
%   Model parameters

    th=0.005; sig=0.01; 
    
%   Option and bond parameters

    TC=2; TB=10; K=100;
    
%   Parameters for the tree

    dt=0.5; rdt=sqrt(dt);
    N=TB/dt;                % index for bond's maturity
    M=TC/dt;                % index for option's maturity
   
%   Calculate the discount curve

    P0=zeros(N,1);
    P0(1)=100/(1+dt*f(1));
    for j=2:N
        P0(j)=P0(j-1)/(1+dt*f(j));
    end
    
%   Calculate the swap rate
    
    sum=0;
    for j=M+1:N
        sum=sum+P0(j);
    end
    c=2*(P0(M)-P0(N))/sum;
    c=c*100;
    
%   Build tree

    q=zeros(N,1);
    r=zeros(N,N);
    r(1,1)=f(1);
    
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

 %  Calculate bond price at option's maturity
 
    P=zeros(N+1,N+1);
    P(:,N+1)=100*ones(N+1,1);
    for j=N:-1:M+1
         for i=1:j
             P(i,j)=(q(j)*P(i,j+1)+(1-q(j))*P(i+1,j+1)+c*dt)/(1+r(i,j)*dt);
         end
    end

 %  Calculate option's value
 
    C=zeros(M+1,M+1);
    
    for i=1:M+1
        C(i,M+1)=max(P(i,M+1)-K,0);
    end
    
    for j=M:-1:1
        for i=1:j
            C(i,j)=(q(j)*C(i,j+1)+(1-q(j))*C(i+1,j+1))/(1+r(i,j)*dt);
        end
    end
    
    C(1,1)
    

    