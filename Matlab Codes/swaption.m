%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is to calculate prices of swaptions                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    format long
    
%   Forward-rate curve

    f=0.01:0.0005:0.0395;
    
%   Model parameters

    mu=0.00; sig=0.005; 
    
%   Option and bond parameters

    TC=2; TB=10; K=100;
    
%   Parameters for the tree

    dt=0.5; rdt=sqrt(dt);
    N=TB/dt;                % index for bond's maturity
    M=TC/dt;                % index for option's maturity
    NC=1;           % number of different yield curves
    
    Cy=zeros(NC,1);
   
%   calculate the swap rate

    P0=zeros(N,1);
    P0(1)=100/(1+dt*f(1));
    for j=2:N
        P0(j)=P0(j-1)/(1+dt*f(j));
    end
    
    sum=P0(M+1);
    for j=M+2:N
        sum=sum+P0(j);
    end 
    sum=sum*dt;
    c=(P0(M)-P0(N))/sum;
    c=c*100;
    
%   calculate bond option price
    
    for k=1:NC
    
        lam=zeros(N,1);
        r=zeros(N,N);
        r(1,1)=f(1); OPTIONS=[];
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
        P(:,N+1)=100*ones(N+1,1)+c*dt;
        for j=N:-1:3
            for i=1:j
                P(i,j)=0.5*(P(i,j+1)+P(i+1,j+1))/(1+r(i,j)*dt)+c*dt;
            end
        end
        for i=1:3
            P(i,3)=P(i,3)-c*dt;
        end
        
        C=zeros(M+1,M+1);
    
        for i=1:M+1
            C(i,M+1)=max(P(i,M+1)-K,0);
        end
    
        for j=M:-1:1
            for i=1:j
                C(i,j)=0.5*(C(i,j+1)+C(i+1,j+1))/(1+r(i,j)*dt);
            end
        end
        Cy(k)=C(1,1);
    end
    C(1,1)
%    plot(y,Cy)
    