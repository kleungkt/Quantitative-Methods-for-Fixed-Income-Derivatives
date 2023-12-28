
clear;
T=1;
N=2^6;
dt=T/N;
rdt=sqrt(dt);

S0=1; r=0.05; mu=0.05; sig=0.3;
% x(1)=-N*rdt;
% for i=2:(N+1)
%     x(i)=x(i-1)+2*rdt;
% end
% for i=1:(N+1)
%     f(i)=exp(-x(i)*x(i)*0.5)/sqrt(2*pi);
%end
%f=f*rdt*2;
% xx=S0*exp((r-0.5*sig^2)*T)*exp(x);
% plot(xx,f); pause; %hold; 

Nn=2^6;
dt=T/Nn;
rdt=sqrt(dt);
xn=zeros(Nn+1,1); %fn=xn;
x=zeros(Nn+1,1); f=x;
U=1+mu*dt+sig*rdt;
D=1+mu*dt-sig*rdt;
%xn(1)=-Nn*rdt;
q=0.5*(1+(mu-r)*rdt/sig);
for i=0:Nn
    xn(i+1)=S0*D^(Nn-i)*U^i;
    x(i+1)=(log(xn(i+1)/S0)-(r-0.5*sig^2)*T)/(sig*sqrt(T));
%     f(i+1)=exp(-x(i+1)*x(i+1)*0.5)/sqrt(2*pi);
end
x=xn;

for n=1:6
%plot(x,f); hold;
xx=x(2^6+1); yy=0.5; plot(xx,yy); hold
Nn=2^n;
dt=T/Nn;
rdt=sqrt(dt);
xn=zeros(Nn+1,1); fn=xn;
%x=zeros(Nn+1,1); f=x;
U=1+mu*dt+sig*rdt;
D=1+mu*dt-sig*rdt;
%xn(1)=-Nn*rdt;
q=0.5*(1+(mu-r)*rdt/sig);
for i=0:Nn
    xn(i+1)=S0*D^(Nn-i)*U^i;
    %x(i+1)=(log(xn(i+1)/S0)-(r-0.5*sig^2)*T)/(sig*sqrt(T));
    %f(i+1)=exp(-x(i+1)*x(i+1)*0.5)/sqrt(2*pi);
end
%plot(xn,f); hold;

fn(1)=1;
for i=1:Nn
    f0=fn;
    for j=2:i
        fn(j)=q*f0(j-1)+(1-q)*f0(j);
    end
    fn(1)=q*f0(1);
    fn(i+1)=(1-q)*f0(i);
end
fn=fn/(2*rdt);
plot(xn,fn,'*'); %hold; 
%xx=xn(Nn+1); yy=0.5; plot(xx,yy); 
xlabel('stock price');
ylabel('probability');
hold
pause;
end
hold
plot(x,f); hold;






