%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is to calculate prices of swaptions with the Black's formula%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    format long
    
%   Forward-rate curve

    f=0.01:0.0005:0.0395;
    
%   Model parameters

    sig=0.30; 
    
%   Option and bond parameters

    TC=2; TB=10;
    
%   Parameters for the tree

    dt=0.5; 
    N=TB/dt;                % index for bond's maturity
    M=TC/dt;                % index for option's maturity
    
%    Cy=zeros(NC,1);
   
%   calculate the swap rate

    P0=zeros(N,1);
    P0(1)=1/((1+0.25*f(1))*(1+0.25*f(2)));
    for j=2:N
        P0(j)=P0(j-1)/((1+0.25*f(2*j-1))*(1+0.25*f(2*j)));
    end 
    
%   calculate the ATM swap rate 

    sum=0;
    for j=M+1:N
        sum=sum+dt*P0(j);
    end 
    k=(P0(M)-P0(N))/sum;
    
%   calculate swaption price
    
    BC=sum*call(k,k,TC,sig);
    
    BC*1000000
    
%    plot(y,Cy)
    