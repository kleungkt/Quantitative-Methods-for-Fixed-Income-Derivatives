
    c=0.00; K=970;
    r0=0.05; r1=0.0515; mu=0.01; sig=0.01; dt=0.5; rdt=sqrt(dt);
    lam=0;
    
    r01=r0+(mu+lam)*dt-sig*rdt;
    r11=r0+(mu+lam)*dt+sig*rdt;

    P00=950.42;
    P11=1000/(1+r11*dt)
    P01=1000/(1+r01*dt)
    q00=(P11-P00*(1+r0*dt))/(P11-P01)
    
    f11=max(0,P11-K)
    f01=max(0,P01-K)
    f00=(q00*f01+(1-q00)*f11)/(1+r0*dt)
    delta=(f11-f01)/(P11-P01)