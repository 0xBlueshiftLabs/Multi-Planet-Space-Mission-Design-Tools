function TA = EAtoTA(e,EA) % eccentric anomaly to true anomoly conversion 

if e == 0
    % circular case
    TA = EA ;
elseif e<1
    % eliptic case
    tangent = sqrt((1+e)/(1-e))*tan(EA/2);
    TA = 2*atan(tangent);
elseif e == 1
    e=e+(1e-20)
    EAtoTA(e,MA)
elseif e>1
    % hyperbolic case
    tangent = sqrt((e+1)/(e-1))*tanh(EA/2);
    TA = 2*atan(tangent);
end

end





