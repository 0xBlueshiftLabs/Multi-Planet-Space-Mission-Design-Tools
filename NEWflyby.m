
clear all
close all


% constants
mu = 1.32712440018e11; % [km^3/s^2]
dayInSec = 24*60*60;
mus = [2.2032e4 ; 3.24859e5 ; 4.0351e5 ; 4.282837e4 ; 1.26686534e8 ; 3.7931187e7 ; 5.79399e6 ; 6.836529e6 ; 8.71e2]; % [km^3/s^-2] - earth+moon mu used

% INPUTS
planetID1 = 3;
planetID2 = 4;
planetID3 = 5;

t1 = 0; % [s]
t2 = 120*dayInSec; % [s]
t3 = 1800*dayInSec; % [s]


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

rSOI = sphereof(planetID2,t2); % [km]
Renter = (rSOI)*((v2)/(norm(v2)))

coeFlyby1 = coe_from_sv(Renter,VinfIN,muPlanet) % need to change mu value and maybe use VhypIN instead
% [h e RA incl w TA a];

TA1 = coeFlyby1(6); % [rad]
a = coeFlyby1(7); % [km]
e = coeFlyby1(2);
P = a*(1-(e^2)); % [km]
n = sqrt(muPlanet/(a^3));

i = coeFlyby1(4) ; % orbit inlination [rad]
OmegaN = coeFlyby1(3) ; % [rad]
Wp = coeFlyby1(5) ; % = Wbar-OmegaN [rad]

% rotation matrices ORIGINALS
RzOmegaN = [cos(-OmegaN) sin(-OmegaN) 0 ; -sin(-OmegaN) cos(-OmegaN) 0 ; 0 0 1] ; 
Rxi = [1 0 0 ; 0 cos(-i) sin(-i) ; 0 -sin(-i) cos(-i)] ; 
RzWp = [cos(-Wp) sin(-Wp) 0 ; -sin(-Wp) cos(-Wp) 0 ; 0 0 1] ; 
rotation = RzOmegaN*Rxi*RzWp;
hold on

for TA = TA1:-0.01:-pi/3
    
    r = P/(1+(e*cos(TA))); % radial distance [km]
    x = r*cos(TA); % x distance [km]
    y = r*sin(TA); % y distance [km]
    z = 0; % z distance [km]
    pos = [x ; y ; z] ; % position matrix containing all unaligned position vecotrs for the orbit
    R  = (rotation*pos)';  % position matrix containing all aligned position vecotrs [km]
    plot3(R(1),R(2),R(3),'.','color','b')

end

plot3(0,0,0,'o')

[x,y,z] = sphere;
x = x*rSOI;
y = y*rSOI;
z = z*rSOI;
surf(x,y,z)
alpha 0.1
shading interp



%%% LEG 2 - t2 to t3 %%%
tf23 = abs(t3-t2)/(dayInSec); % time of flight from 2 to 3 [s]

R3 = position(planetID3,t3);

[V1, V2, extremal_distances, exitflag] = lambert(R2, R3, tf23, 0, mu);
v3 = V1;
v4 = V2;
VinfOUT = v3-vPlanet2; % depatrure velocity minus planet velocity