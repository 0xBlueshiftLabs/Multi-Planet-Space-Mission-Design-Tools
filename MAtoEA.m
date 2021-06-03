function EA = MAtoEA(e,MA) % mean anomaly to eccentric anomaly conversion
% MA to EA
% numerical method

if e == 0
    EA = MA ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
elseif e<1
    % elipse case
    
    if MA < pi
        EA = MA + e/2;
    else
        EA = MA - e/2;
    end

    Tolerance = 1e-8;
    Ratio = ones(size(MA));

    while all(abs(Ratio)>Tolerance)
        Ratio = (EA - e*sin(EA) - MA)./(1 - e*cos(EA));
        EA = EA - Ratio;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif e == 1
    e=e+(1e-20)
    MAtoEA(e,MA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
elseif e>1
    % hyperbolic case
    
    EA = MA;
    Tolerance = 1e-8;
    Ratio = ones(size(MA));

    while all(abs(Ratio)>Tolerance)
        Ratio = (e*sinh(EA) - EA - MA)./(e*cosh(EA) - 1);
        EA = EA - Ratio;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
end
end
    