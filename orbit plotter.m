clear
close all


bodies = ["Mercury","Venus","Earth bary","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"] ;

colours = [1 1 1 ; 1 0 1 ; 0 0.7 1 ; 1 0 0 ; 0 1 0 ; 1 1 0 ; 0 1 1 ; 1.0000 0.4118 0.1608 ; 0.0588...
    1.0000 0.6000] ; % RGB colour codes used for orbit plots

jpl = xlsread('jpldata.xlsx') ; % imports data from JPL table
% jpl colums: a [au] , e , i [deg] , L [deg] , Wbar [deg] , Omega [deg]

autom = 149597870700 ; % astronomical unit to m conversion factor
mu = 1.32712440018e20 ; % heliocentric mu -- standard gravitational parameter = GM [m^3 s^-2]

step = 200 ; % time steps 

% Generates cartesian position (x,y,z) as a function of time since periapsis

for planet = 1:9 % which planets to simulate
    
    colour = colours(planet,:) ; % selects colour for particular orbit plot
    
    a = jpl(planet,1)*autom ; % semi-major axis [m]
    e = jpl(planet,2) ; % eccentricty
    P = a*(1-e^2) ; % semi-latus rectum
    n = sqrt(mu/(a^3)) ; % mean motion
    T = (2*pi)/n ; % orbital period [s]
    
    x = zeros(1,step+1) ; % initialises matrix with size 1 by step
    y = zeros(1,step+1) ; % initialises matrix with size 1 by step
    z = zeros(1,step+1) ; % initialises matrix with size 1 by step
    
    counter = 1 ;
    planet; % prints to screen the current planet the program is plotting
    
    for t = 0:T/step:T
    
        MA = ((jpl(planet,3))-(jpl(planet,4)))+(n*t); % mean anomoly
        EA = MAtoEA(e,MA); % eccentric anomoly
        TA = EAtoTA(e,EA); % true anomoly
        r = P/(1+(e*cos(TA))); % radial distance
        x(counter) = r*cos(TA); % x distance
        y(counter) = r*sin(TA); % y distance
        counter = counter+1 ;
    end
    
    i = jpl(planet,3) ; % orbit inlination [deg]
    OmegaN = jpl(planet,6) ; % [deg]
    Wp = (jpl(planet,5))-OmegaN ; % = Wbar-OmegaN [deg]
    
    % rotation matrices
    RzOmegaN = [cosd(-OmegaN) sind(-OmegaN) 0 ; -sind(-OmegaN) cosd(-OmegaN) 0 ; 0 0 1] ; 
    Rxi = [1 0 0 ; 0 cosd(-i) sind(-i) ; 0 -sind(-i) cosd(-i)] ; %
    RzWp = [cosd(-Wp) sind(-Wp) 0 ; -sind(-Wp) cosd(-Wp) 0 ; 0 0 1] ; 
    
    pos = [x ; y ; z] ; % position matrix containing all unaligned position vecotrs for the orbit
 
    aligned  = RzOmegaN*Rxi*RzWp*pos ; % position matrix containing all aligned position vecotrs 
    
    for coord = 1:step+1 % deconstructs aligned position matrix and plots induvidual components
       
        xr = aligned(1,coord) ;
        yr = aligned(2,coord) ;
        zr = aligned(3,coord) ;
        plot3(xr,yr,zr,'color',colour,'marker','.') % plots position vector
        hold on
    end  
end

plot3(0,0,0,'.','color','y','MarkerSize',30) % plots sun
set(gca,'Color','k') % sets graph background to black
grid on
ax = gca
ax.GridColor = 'w'

xlabel('Distance from sun in x direction [m]')
ylabel('Distance from sun in y direction [m]')
zlabel('Distance from sun in z direction [m]')
hold off

