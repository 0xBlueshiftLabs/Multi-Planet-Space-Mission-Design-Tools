% Returns position vector of space craft given the True Anomaly (TA) as an input

function R = craftPosition(planetID1, planetID2, t1, t2, TA)

mu = 1.32712440018e11; % gravitational constant of heliocentric space flight [km^3/s^2]

R1 = position(planetID1,t1);
R2 = position(planetID2,t2);
tf = (t2-t1)/(60*60*24);

[V1, V2, extremal_distances, exitflag] = lambert(R1, R2, tf, 0, mu);

coe1 = coe_from_sv(R1,V1); % [h e RA incl w TA a]

coe2 = coe_from_sv(R2,V2); % [h e RA incl w TA a]

a = coe1(7); % [km]
e = coe1(2);
P = a*(1-(e^2)); % [km]

i = coe1(4) ; % orbit inlination [rad]
OmegaN = coe1(3) ; % [rad]
Wp = coe1(5) ; % = Wbar-OmegaN [rad]

% rotation matrices 
RzOmegaN = [cos(-OmegaN) sin(-OmegaN) 0 ; -sin(-OmegaN) cos(-OmegaN) 0 ; 0 0 1] ; 
Rxi = [1 0 0 ; 0 cos(-i) sin(-i) ; 0 -sin(-i) cos(-i)] ; 
RzWp = [cos(-Wp) sin(-Wp) 0 ; -sin(-Wp) cos(-Wp) 0 ; 0 0 1] ; 
rotation = RzOmegaN*Rxi*RzWp;

r = P/(1+(e*cos(TA))); % radial distance [km]
x = r*cos(TA); % x distance [km]
y = r*sin(TA); % y distance [km]
z = 0; % z distance [km]
pos = [x ; y ; z] ; % position matrix containing all unaligned position vecotrs for the orbit
R  = (rotation*pos)';  % position matrix containing all aligned position vecotrs [km]
