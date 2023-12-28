
T=1;
N=2^8;
dt=T/N;
rdt=sqrt(dt);
x=zeros(N+1,1); f=x;
x(1)=-N*rdt;
for i=2:(N+1)
    x(i)=x(i-1)+2*rdt;
end
for i=1:(N+1)
    f(i)=exp(-x(i)*x(i)*0.5)/sqrt(2*pi);
end
%f=f*rdt*2;
%plot(x,f); 

for n=1:8
Nn=2^n;
dt=T/Nn;
rdt=sqrt(dt);
xn=zeros(Nn+1,1); fn=xn;
xn(1)=-Nn*rdt;
for i=2:(Nn+1)
    xn(i)=xn(i-1)+2*rdt;
end

fn(1)=1;
for i=1:Nn
    f0=fn;
    for j=2:i
        fn(j)=0.5*(f0(j-1)+f0(j));
    end
    fn(1)=0.5*f0(1);
    fn(i+1)=0.5*f0(i);
end
fn=fn/(2*rdt);
plot(xn,fn,'o-'); if n==1 hold; end
pause;
end
hold






