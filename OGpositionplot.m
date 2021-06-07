clear
close all

% plots positions of our solar system's planets throughout their orbits in 3D space

% jpl colums: a [au] , a [m] , e , i [deg] , L [deg] , Wbar [deg] , Omega [deg]
% bodies = ["Mercury","Venus","Earth bary","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"] ;

jpl = xlsread('jpldata.xlsx') ;

mu = 1.32712440018e20 ; % heliocentric mew --- standard gravitational parameter = GM [m^3 s^-2]
au2km = 149597870700/1000 ;

step = 72 ; % time steps 

% Generates cartesian position (x,yz) as a function of time since perhelion

for planet = 1:9 % which planets to simulate
    
    colour = rand(1,3) ;
    
    a = jpl(planet,1)*au2km ; % semi-major axis [m]
    e = jpl(planet,2) ; % eccentricty
    P = a*(1-e^2) ; % semi-latus rectum
    n = sqrt(mu/(a^3)) ; % mean motion
    T = (2*pi)/n ; % orbital period [s]
    
    x = zeros(1,step+1) ; % initialises matrix with size 1 by step
    y = zeros(1,step+1) ; % initialises matrix with size 1 by step
    z = zeros(1,step+1) ; % initialises matrix with size 1 by step
    
    counter = 1 ;
    planet
    
    for t = 0:T/step:T
    
        MA = n*t; % mean anomoly
        EA = MAtoEA(e,MA); % eccentric anomoly
        TA = EAtoTA(e,EA); % true anomoly
        
        r = P/(1+(e*cos(TA))); 
        x(counter) = r*cos(TA);
        y(counter) = r*sin(TA);
        counter = counter+1 ;

        %progress = 100*(t/T)
        %fprintf('Progress: %d \n', progress);
  
    end
    
    i = jpl(planet,3) ; % [deg]
    OmegaN = jpl(planet,6) ; % [deg]
    Wp = (jpl(planet,5))-OmegaN ; % = Wbar-OmegaN [deg]
    
    RzOmegaN = [cosd(OmegaN) -sind(OmegaN) 0 ; sind(OmegaN) cosd(OmegaN) 0 ; 0 0 1] ;
    Rxi = [1 0 0 ; 0 cosd(i) -sind(i) ; 0 sind(i) cosd(i)] ;
    RzWp = [cosd(Wp) -sind(Wp) 0 ; sind(Wp) cosd(Wp) 0 ; 0 0 1] ;
    
    pos = [x ; y ; z] ;
    aligned  = pos'*RzOmegaN*Rxi*RzWp ;
    
    for coord = 1:step+1
        
        xr = aligned(coord,1) ;
        yr = aligned(coord,2) ;
        zr = aligned(coord,3) ;
        
        plot3(xr,yr,zr,'color',colour,'marker','.')
        
        hold on
    
    end
    
end

plot(0,0,'yo')
set(gca,'Color','k')
hold off

