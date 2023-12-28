
       	function x=call(F,K,T,sig)
       	if T*sig == 0
            x=max(F-K,0); 
            return;
        end
        d1=log(F/K)+0.5*(sig^2)*T;
        d1=d1/(sig*sqrt(T));
        d2=d1-sig*sqrt(T);
        nd1=0.5*(1+erf(d1/sqrt(2)));
        nd2=0.5*(1+erf(d2/sqrt(2)));
        x=F*nd1-K*nd2;
        return;
