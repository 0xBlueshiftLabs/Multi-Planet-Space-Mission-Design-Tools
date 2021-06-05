% Plots graph of dVpatch vs arrival time at 3rd planet

clear all
close all

% constants
dayInSec = 24*60*60;

% INPUTS
t1 = (J0(1977,8,20)-J0(2000,1,1))*dayInSec;
t2 = (J0(2021,2,18)-J0(2000,1,1))*dayInSec;

t3min = (J0(2021,2,18)-J0(2000,1,1))*dayInSec;
t3max = (J0(2051,8,23)-J0(2000,1,1))*dayInSec;


% initialisations for the loop
dVold = 100; 
dVs = [];
counter = 1;
hold on
for t3 = t3min : 10*dayInSec : t3max
    
    dVpatch = flybyV(3,4,5,t1,t2,t3);
    timeFromFlybyD = (t3-t2)/dayInSec;
    plot(timeFromFlybyD,dVpatch,'color','b','marker','.')
    
    % stores each t3 and dVpatch value to find the minima after the loop
    dVs(counter) = dVpatch;
    t3s(counter) = t3;
    
    counter = counter+1;
    
end
hold off

% axes labels
xlabel('Arrival time at destination planet [days since flyby]')
ylabel('\DeltaV required to patch trajectories [km/s]')

[M,I] = min(dVs);
minV = M
optimumt3 = t3s(I)

tf23 = abs((optimumt3)-t2)/dayInSec % [days]







