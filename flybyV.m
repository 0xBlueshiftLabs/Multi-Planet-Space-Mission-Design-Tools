% function to determine dVpatch (impulse required to patch 2 trajectories)

function dVpatch = flybyV(planetID1,planetID2,planetID3,t1,t2,t3)
% fly by

% constants
mu = 1.32712440018e11; % [km^3/s^2]
dayInSec = 24*60*60;
mus = [2.2032e4 ; 3.24859e5 ; 4.0351e5 ; 4.282837e4 ; 1.26686534e8 ; 3.7931187e7 ; 5.79399e6 ; 6.836529e6 ; 8.71e2]; % [km^3/s^-2] - earth+moon mu used

% INPUTS
% planetID1 = 3;
% planetID2 = 4;
% planetID3 = 5;
% 
% t1 = 0; % [s]
% t2 = 300*dayInSec; % [s]
% t3 = 1800*dayInSec; % [s]


%%%
muPlanet = mus(planetID2); % mu value for planet being flown by

%%% LEG 1 - t1 to t2 %%%
tf12 = abs(t2-t1)/(dayInSec); % time of flight from 1 to 2 [s]

R1 = position(planetID1,t1);
    
R2 = position(planetID2,t2);
coe2 = coe_from_position(planetID2,t2);
[r2, vPlanet2] = sv_from_coe(coe2);

[V1, V2, extremal_distances, exitflag] = lambert(R1, R2, tf12, 0, mu);
v1 = V1;
v2 = V2;
VinfIN = v2-vPlanet2; % arrival velocity minus planet velocity
vinfIN = norm(VinfIN); % magnitude

a1 = -(muPlanet/((norm(VinfIN))^2)); % [km]

%%% LEG 2 - t2 to t3 %%%
tf23 = abs(t3-t2)/(dayInSec); % time of flight from 2 to 3 [s]

R3 = position(planetID3,t3);

[V1, V2, extremal_distances, exitflag] = lambert(R2, R3, tf23, 0, mu);
v3 = V1;
v4 = V2;
VinfOUT = v3-vPlanet2; % depatrure velocity minus planet velocity
vinfOUT = norm(VinfOUT); % magnitude

a2 = -(muPlanet/((norm(VinfOUT))^2)); % [km]
 
%%% fly by calcs %%%
delta = acos((dot(VinfIN,VinfOUT))/((norm(VinfIN))*(norm(VinfOUT)))); % [rad]

% equation and it's derrivative
%f = ((a2/a1)*(e2-1)+1)*(sin(delta-asin(1/e2))-1);
%dfde2 = ((((a2/a1)*e2)-(a2/a1)+1)*((cos(delta-asin(1/e2)))/((e2^2)*sqrt(1-(1/(e2^2))))))+((a2/a1)*sin(delta-asin(1/e2)));

% Newton Rapshon method to find e2 to 4dp
%hold on
% initialising
error = 1;
itteration = 1;
e2old = 1.5; % initial guess

while error>(0.0001)
    e2new = e2old-((((a2/a1)*(e2old-1)+1)*(sin(delta-asin(1/e2old))-1))/(((((a2/a1)*e2old)-(a2/a1)+1)*((cos(delta-asin(1/e2old)))/((e2old^2)*sqrt(1-(1/(e2old^2))))))+((a2/a1)*sin(delta-asin(1/e2old)))));
    error = abs(e2new-e2old);
    %plot(itteration,e2new,'color','b','marker','.')
    e2old = e2new;
    itteration = itteration+1;
    if itteration > 50000
        e2 = NaN;
        %fprintf('e2 solution may have diverged\n')
        break
    end      
end

if itteration > 50000
    e2 = NaN;
else
    e2 = e2new; 
end
%hold off


e1 = ((a2/a1)*(e2-1))+1;
rp1 = a1*(1-e1);
rp2 = a2*(1-e2);

% checks rp values are similar
if abs(rp1-rp2)>0.0001
    fprintf('Error in rp values\n')
else
    rp = rp1
end

Raiming = rp*sqrt(1+(muPlanet/(rp*(vinfOUT^2))));


dVpatch = abs((sqrt((vinfIN^2)+((2*muPlanet)/(rp))))-(sqrt((vinfOUT^2)+((2*muPlanet)/(rp)))));




