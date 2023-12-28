%   bond tree
    
    format long
    N=20; c=5;
    P=zeros(N+1,N+1);
    P(:,N+1)=100*ones(N+1,1);
    for j=N:-1:1
        for i=1:j
            P(i,j)=(q(j)*P(i,j+1)+(1-q(j))*P(i+1,j+1)+c/2)/(1+r(i,j)*dt);
        end
    end
    
%     for i=1:3
%          P(i,3)=P(i,3)-c*dt;            % clean price
%     end
    
    P(:,3)
    