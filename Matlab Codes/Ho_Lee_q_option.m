%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is to calculate prices of bond option for various yields    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    format long;
    
%   zero-coupon yields

    r0=0.05*ones(60,1);     % disc_curve_29_06;

%   Model parameters

    th=0.005; sig=0.01; 
    
%   Option and bond parameters

    c=5; TC=1; TB=10; K=100;
    
%   Parameters for the tree

    dt=0.5; rdt=sqrt(dt);
    N=TB/dt;                % index for bond's maturity
    M=TC/dt;                % index for option's maturity

%   Calculate the discount curve

    P0=zeros(N,1);  
    for j=1:N
        P0(j)=100/(1+dt*r0(j))^(j);
    end
    
%   Build the interest rate tree
    
    r=zeros(N,N);
    r(1,1)=2*(100/P0(1)-1);       
    for j=2:N
        for i=1:j-1
            r(i,j)=r(i,j-1)+th*dt-sig*rdt;
        end
        r(j,j)=r(j-1,j-1)+th*dt+sig*rdt;
    end

%   Determine q by fitting to the discount curve

    q=zeros(N,1);
    for j=2:N
        jj=j; q0=0.5;
        q1=get_q1(P0,r,q,jj,dt);
        q(j-1)=q1;
    end

%   Calculate the bond prices at the option's maturity

    B=zeros(N+1,N+1);
    B(:,N+1)=100*ones(N+1,1);
    for j=N:-1:1
        for i=1:j
            B(i,j)=(q(j)*B(i,j+1)+(1-q(j))*B(i+1,j+1)+c*dt)/(1+r(i,j)*dt);
        end
    end
    
%   Calculate the option payoff 

    C=zeros(M+1,M+1);                       % option value tree
    for i=1:M+1
        C(i,M+1)=max(B(i,M+1)-K,0);
    end

%   Backward induction for option price

    for j=M:-1:1
        for i=1:j
            C(i,j)=(q(j)*C(i,j+1)+(1-q(j))*C(i+1,j+1))/(1+r(i,j)*dt);
        end
    end

%   Output option value and delta 

    C(1,1)
    alpha=(C(2,2)-C(1,2))/(B(2,2)-B(1,2))
    