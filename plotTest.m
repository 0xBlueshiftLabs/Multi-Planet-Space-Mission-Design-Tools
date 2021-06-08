clear all
close all

% Functions required: 
% orbit_plot, planet_plot, position, lambert, coe_from_sv, MAtoEA, EAtoTA


% CONSTANTS
day = 24*60*60; %[s]

% INPUTS
planetID1 = 4;
planetID2 = 5;
t1 = 0; % [s]
t2 = 4*365.25*24*60*60; % [s]
steps = 50;
stepsize = 50*day; % [s]

hold on

% plots spacecraft orbit
plot3(0,0,0,'o','color','y')
orbit_plot(planetID1, planetID2, t1, t2 , stepsize,'g')

% plots planet 1's orbit
planet_plot(planetID1, t1, t2, stepsize,'b')
mar = position(planetID1,t1);
plot3(mar(1),mar(2),mar(3),'o')

% plots planet 2's orbit
planet_plot(planetID2, t1, t2, stepsize,'r')
jup = position(planetID2,t1);
plot3(jup(1),jup(2),jup(3),'o')

set(gca,'Color','k') % sets background colour
hold off
