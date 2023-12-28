    
    N=20;
    r0=0.05*ones(N,1); th=0.005; sig=0.01; dt=0.5; rdt=sqrt(dt);
    r=zeros(N,N);
    q=zeros(N,1);
    
%   Example 1

    disc_curve_29_06; % it is not a flat price curve
    P0=P(:,2); % price of zcb is set to 100
    r(1,1)=2*(1/P0(1)-1);
    
%   Example 2
    P0=zeros(N,1);
    for j=1:N
        P0(j)=1/(1+dt*r0(j))^(j);
    end
    r(1,1)=r0(1); 
    
    for j=2:N
        for i=1:j-1
            r(i,j)=r(i,j-1)+th*dt-sig*rdt;
        end
        r(j,j)=r(j-1,j-1)+th*dt+sig*rdt;
    end
    
    OPTIONS=[];
    for j=2:N
        jj=j; q0=0.5;
        q1=get_q1(P0,r,q,jj,dt);%get all branching prob
        q(j-1)=q1;
    end

    plot(1:N-1,q(1:N-1),'*');
    xlabel('j');
    ylabel('q_j');
    title('Risk-neutral probabilities');
    
    
        