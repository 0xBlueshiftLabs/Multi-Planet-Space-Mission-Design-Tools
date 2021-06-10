close all
clear all

%["Mercury","Venus","Earth bary","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"]

dayInSec = 24*60*60;

%%% voyager 1 key dates %%%

% Lanuch - 20/08/77
tLaunch = (J0(1977,9,8)-J0(2000,1,1))*dayInSec;
% Jupiter - 09/07/79
tJA = (J0(1979,3,5)-J0(2000,1,1))*dayInSec;
tJupiter = (J0(1979,4,24)-J0(2000,1,1))*dayInSec;
% Saturn - 25/08/81
tSA = (J0(1980,11,12)-J0(2000,1,1))*dayInSec;
tSaturn = (J0(1991,1,1)-J0(2000,1,1))*dayInSec;
%

% planet orbital periods
Tearth = 365.25*dayInSec;
Tjupiter = 4332.59*dayInSec;
Tsaturn = 10759.22*dayInSec;


% plotting
hold on
plot3(0,0,0,'.','color','y','MarkerSize',20) % plots sun

% plots spacecraft trajectories
orbit_plot(3, 5, tLaunch, tJA, 10*dayInSec, 'g',0)
orbit_plot(5, 6, tJupiter, tSA, 10*dayInSec, 'g',0)



% plots planet trajectories
% planet_plot(planetID,t1,t2,stepsize,colour)
planet_plot(3, tLaunch, tLaunch+Tearth, 10*dayInSec, 'b')
planet_plot(5, tLaunch, tLaunch+Tjupiter, 20*dayInSec, 'r')
planet_plot(6, tLaunch, tLaunch+Tsaturn, 50*dayInSec, 'm')



set(gca,'Color','k'); % changes background colour
set(gca,'GridColor','w')

hold off

