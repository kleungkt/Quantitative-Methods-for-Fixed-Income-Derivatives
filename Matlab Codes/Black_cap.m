%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is to calculate prices of swaptions with the Black's formula%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    format long
    
%   Forward-rate curve

    f=0.01:0.0005:0.0595;
    
%   Model parameters

    sig=0.30; 
    
%   Option and bond parameters

    T=10;
    
%   Parameters for the tree

    dt=0.25;
    N=T/dt;                % index for bond's maturity
   
%   calculate the swap rate

    P0=zeros(N,1);
    P0(1)=1/(1+dt*f(1));
    for j=2:N
        P0(j)=P0(j-1)/(1+dt*f(j));
    end 
    
%   calculate the ATM swap rate 

    sum=0;
    for j=1:N/2
        sum=sum+2*dt*P0(2*j);
    end 
    k=(1-P0(N))/sum;
    
%   calculate cap price
    
    BCap=0;
    for j=1:N
        ff=f(j);
        Tj=(j-1)*dt;
        BCap=BCap+P0(j)*dt*call(ff,k,Tj,sig);
    end
    
    BCap*1000000
    
%    plot(y,Cy)
    