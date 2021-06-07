function plot = orbit_plot(planetID1, planetID2, t1, t2, stepsize,colour,m) % plots specified section of an orbit


% colour:
%
% blue	   'b'	[0,0,1]
% black	   'k'	[0,0,0]
% red	   'r'	[1,0,0]
% green	   'g'	[0,1,0]
% yellow   'y'	[1,1,0]
% cyan	   'c'	[0,1,1]
% magenta  'm'	[1,0,1]
% white	   'w'	[1,1,1]


mu = 1.32712440018e11; % [km^3/s^2]
dayInSec = 24*60*60; % [s]

R1 = position(planetID1,t1);
R2 = position(planetID2,t2);
tf = (t2-t1)/(60*60*24);

[V1, V2, extremal_distances, exitflag] = lambert(R1, R2, tf, m, mu);
coe1 = coe_from_sv(R1,V1); % [h e RA incl w TA a]
TA1 = coe1(6); % [rad]
coe2 = coe_from_sv(R2,V2); % [h e RA incl w TA a]
TA2 = coe2(6); % [rad]
a = coe1(7); % [km]
e = coe1(2);
P = a*(1-(e^2)); % [km]
n = sqrt(mu/(a^3));

i = coe1(4) ; % orbit inlination [rad]
OmegaN = coe1(3) ; % [rad]
Wp = coe1(5) ; % = Wbar-OmegaN [rad]

% rotation matrices ORIGINALS
RzOmegaN = [cos(-OmegaN) sin(-OmegaN) 0 ; -sin(-OmegaN) cos(-OmegaN) 0 ; 0 0 1] ; 
Rxi = [1 0 0 ; 0 cos(-i) sin(-i) ; 0 -sin(-i) cos(-i)] ; 
RzWp = [cos(-Wp) sin(-Wp) 0 ; -sin(-Wp) cos(-Wp) 0 ; 0 0 1] ; 
rotation = RzOmegaN*Rxi*RzWp;
hold on

for TA = TA1:(TA2-TA1)/((t2-t1)/stepsize):TA2
    
    r = P/(1+(e*cos(TA))); % radial distance [km]
    x = r*cos(TA); % x distance [km]
    y = r*sin(TA); % y distance [km]
    z = 0; % z distance [km]
    pos = [x ; y ; z] ; % position matrix containing all unaligned position vecotrs for the orbit
    R  = (rotation*pos)';  % position matrix containing all aligned position vecotrs [km]
    plot3(R(1),R(2),R(3),'.','color',colour)

end
end