function coe = coe_from_position(planetID,t)

% only works for planets

%%% outputs coefficients of orbital elements (coe) as matrix when time since j2000, t [s], is given as an input and a planet is specified %%%

%%% INPUTS:
%%% planet ID 1-9 ["Mercury","Venus","Earth bary","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"]
%%% t - time since j2000 [s]

% jpl data colums: a [au] , e , i [deg] , L [deg] , Wbar [deg] , Omega [deg]
jpl = [0.38709927	0.20563593	7.00497902	252.2503235	77.45779628	48.33076593 ;
0.72333566	0.00677672	3.39467605	181.9790995	131.6024672	76.67984255 ;
1.00000261	0.01671123	-0.00001531	100.4645717	102.9376819	0 ;
1.52371034	0.0933941	1.84969142	-4.55343205	-23.94362959	49.55953891 ;
5.202887	0.04838624	1.30439695	34.39644051	14.72847983	100.4739091 ;
9.53667594	0.05386179	2.48599187	49.95424423	92.59887831	113.6624245 ;
19.18916464	0.04725744	0.77263783	313.2381045	170.9542763	74.01692503 ;
30.06992276	0.00859048	1.77004347	-55.12002969	44.96476227	131.7842257 ;
39.48211675	0.2488273	17.14001206	238.9290383	224.0689163 110.3039368];

au2km = 149597870700/1000 ; % astronomical unit to km conversion factor
mu = 1.32712440018e11; % heliocentric mu -- standard gravitational parameter [km^3/s^2]

deg2rad = pi/180; % degrees to radians conversion

a = (jpl(planetID,1))*au2km; % semi-major axis [km]
e = jpl(planetID,2); % eccentricty
P = a*(1-e^2) ; % semi-latus rectum [km]
n = sqrt(mu/(a^3)) ; % mean motion
T = (2*pi)/n ; % orbital period [s]

j2000MA = (jpl(planetID,4))-(jpl(planetID,5)); % L - Wbar at j2000 [deg]
MA = (j2000MA*(pi/180))+(n*t); % [rad]

EA = MAtoEA(e,MA); % eccentric anomoly % [rad]
TA = EAtoTA(e,EA); % true anomoly % [rad]
r = P/(1+(e*cos(TA))); % radial distance
x = r*cos(TA); % x distance
y = r*sin(TA); % y distance
z = 0;

i = jpl(planetID,3) ; % orbit inlination [deg]
OmegaN = jpl(planetID,6) ; % [deg]
Wp = (jpl(planetID,5))-OmegaN ; % = Wbar-OmegaN [deg]

% rotation matrices
RzOmegaN = [cosd(-OmegaN) sind(-OmegaN) 0 ; -sind(-OmegaN) cosd(-OmegaN) 0 ; 0 0 1] ; 
Rxi = [1 0 0 ; 0 cosd(-i) sind(-i) ; 0 -sind(-i) cosd(-i)] ; 
RzWp = [cosd(-Wp) sind(-Wp) 0 ; -sind(-Wp) cosd(-Wp) 0 ; 0 0 1] ; 

pos = [x ; y ; z] ; % position matrix containing all unaligned position vecotrs for the orbit

aligned  = RzOmegaN*Rxi*RzWp*pos;  % position matrix containing all aligned position vecotrs [m]
R = (aligned)'; % [km]

h = sqrt(mu*(a)*(1-(e^2))); % [km^2/s]


coe = [h e OmegaN*deg2rad i*deg2rad Wp*deg2rad TA]; % output

