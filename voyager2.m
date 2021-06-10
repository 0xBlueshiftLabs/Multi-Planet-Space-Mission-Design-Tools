close all
clear all

%["Mercury","Venus","Earth bary","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"]

dayInSec = 24*60*60;

%%% voyager 2 key dates %%%

% Lanuch - 20/08/77
tLaunch = (J0(1977,8,23)-J0(2000,1,1))*dayInSec;
% Jupiter - 09/07/79
tJA = (J0(1979,7,9)-J0(2000,1,1))*dayInSec;
tJupiter = (J0(1979,9,15)-J0(2000,1,1))*dayInSec;
% Saturn - 25/08/81
tSA = (J0(1981,8,26)-J0(2000,1,1))*dayInSec;
tSaturn = (J0(1981,10,17)-J0(2000,1,1))*dayInSec;
% Uranus - 24/01/86
tUA = (J0(1986,1,24)-J0(2000,1,1))*dayInSec;
tUranus = (J0(1987,6,9)-J0(2000,1,1))*dayInSec;
% Neptune - 25/08/89
tNA = (J0(1989,8,25)-J0(2000,1,1))*dayInSec;


% planet orbital periods
Tearth = 365.25*dayInSec;
Tjupiter = 4332.59*dayInSec;
Tsaturn = 10759.22*dayInSec;
Turanus = 30688.5*dayInSec;
Tneptune = 60182*dayInSec;

% plotting
hold on
plot3(0,0,0,'.','color','y','MarkerSize',20) % plots sun

% plots spacecraft trajectories
orbit_plot(3, 5, tLaunch, tJA, 10*dayInSec, 'g',0)
% orbit_plot(5, 6, tJupiter, tSA, 10*dayInSec, 'g',0)
% orbit_plot(6, 7, tSaturn, tUA, 10*dayInSec, 'g',0)
% orbit_plot(7, 8, tUranus, tNA, 10*dayInSec, 'g',0)

% plots planet trajectories
% planet_plot(planetID,t1,t2,stepsize,colour)
planet_plot(3, tLaunch, tLaunch+Tearth, 10*dayInSec, 'b')
planet_plot(5, tLaunch, tLaunch+Tjupiter, 20*dayInSec, 'r')
% planet_plot(6, tLaunch, tLaunch+Tsaturn, 50*dayInSec, 'm')
% planet_plot(7, tLaunch, tLaunch+Turanus, 100*dayInSec, 'c')
% planet_plot(8, tLaunch, tLaunch+Tneptune, 150*dayInSec, 'w')

% NL = position(8,tLaunch);
% plot3(NL(1),NL(3),NL(3),'o')
% NA = position(8,tNeptune);
% plot3(NA(1),NA(3),NA(3),'o')

grid on
set(gca,'Color','k'); % changes background colour
set(gca,'GridColor','w')
ax = gca;
ax.GridColor = 'w';
hold off

