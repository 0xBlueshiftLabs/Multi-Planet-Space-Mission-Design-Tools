clear all 
close all

% 'Pork Chop' plotter

% constants
mu = 1.32712440018e11; % [km^3/s^2]
dayInSec = 24*60*60;

% INPUTS

planetID1 = 3;
planetID2 = 4;

t1min = (J0(2020, 4, 1) - J0(2000,1,1))*dayInSec;
t1max = (J0(2020, 12, 7) - J0(2000,1,1))*dayInSec;
t2min = (J0(2020, 8, 5) - J0(2000,1,1))*dayInSec;
t2max = (J0(2022, 2, 5) - J0(2000,1,1))*dayInSec;

steps = 1000 ; % increasing increases computation time exponentially
deltaVlimit = 16; %[km/s] % 16 used in that paper

%maxtf = 250*dayInSec; % [s]


% MAIN CODE

% initialises matrices
x = zeros(1,steps);
y = zeros(1,steps);
z = zeros(1,steps);

counter = 1;



for t1 = t1min:((abs(t1max-t1min))/(steps-1)):t1max
    
    R1 = position(planetID1,t1);
    coe = coe_from_position(planetID1,t1);
    [r1, vPlanet1] = sv_from_coe(coe);
    
    for t2 = t2min:((abs(t2max-t2min))/(steps-1)):t2max
        
        R2 = position(planetID2,t2);
        coe = coe_from_position(planetID2,t2);
        [r2, vPlanet2] = sv_from_coe(coe);
        
        tf = abs(t2-t1)/(dayInSec);
        [V1, V2, extremal_distances, exitflag] = lambert(R1, R2, tf, 0, mu);
        
        if exitflag == -1 % if lambert fails
            deltaV =  deltaVlimit+1; % ensures it is not displayed
            x(counter) = t1;
            y(counter) = t2;
            z(counter) = deltaV;
            counter = counter+1;             
            
        else
            deltaV = (abs(norm(vPlanet1-V1)))+(abs(norm(vPlanet2-V2))); % [km/s]
            x(counter) = t1;
            y(counter) = t2;
            z(counter) = deltaV;
            counter = counter+1;
            
        end
        
    end
    
end

% finds lowest value of z
[M,I] = min(z);
minV = M
launcht = x(I) % [s]
arrivet = y(I) % [s]
minFueltf = abs(arrivet-launcht); % [s]

% comb out impossible deltaV's
for i=1:steps^2
    if z(i)>=deltaVlimit
        z(i)=NaN;
    else
    end
end

xv = linspace(min(x), max(x), steps);
yv = linspace(min(y), max(y), steps);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% comb out max tf
% for i=1:steps^2
%     for j=1:steps^2
%         if (abs(y(j)-x(i)))>maxtf
%             Z(i,j)=NaN;
%         else
%         end
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% contour plot
% figure(3)
% contour(X,Y,Z,20)
% hold on
% plot(x(I),y(I),'color','m','marker','*')
% xlabel('Departure [s]')
% ylabel('Arrival [s]')
% zlabel('deltaV [km/s]')
% hold off
% colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2D colourmap plot
figure(1)
pcolor(X,Y,Z) % effectivly a 2D surf
shading interp

% sets axes to dates
xticks(t1min:25*dayInSec:t1max);
datesX = {datestr(737882+(0*25),'dd-mmm-yy'),datestr(737882+(1*25),'dd-mmm-yy'),datestr(737882+(2*25),'dd-mmm-yy'),datestr(737882+(3*25),'dd-mmm-yy'),datestr(737882+(4*25),'dd-mmm-yy'),datestr(737882+(5*25),'dd-mmm-yy'),datestr(737882+(6*25),'dd-mmm-yy'),datestr(737882+(7*25),'dd-mmm-yy'),datestr(737882+(8*25),'dd-mmm-yy'),datestr(737882+(9*25),'dd-mmm-yy'),datestr(737882+(10*25),'dd-mmm-yy')};
xticklabels(datesX)
xtickangle(45)

yticks(t2min:50*dayInSec:t2max);
datesY = {'',datestr(738008+(1*50),'dd-mmm-yy'),datestr(738008+(2*50),'dd-mmm-yy'),datestr(738008+(3*50),'dd-mmm-yy'),datestr(738008+(4*50),'dd-mmm-yy'),datestr(738008+(5*50),'dd-mmm-yy'),datestr(738008+(6*50),'dd-mmm-yy'),datestr(738008+(7*50),'dd-mmm-yy'),datestr(7380082+(8*50),'dd-mmm-yy'),datestr(738008+(9*50),'dd-mmm-yy'),datestr(738008+(10*50),'dd-mmm-yy'),datestr(738008+(11*50),'dd-mmm-yy')};
yticklabels(datesY)
ytickangle(0)

% datestr(737855) is opposite of datenum('2020,3,5')
% datenum('2000,0,0') = 730485

hold on


% labels axes
xlabel('Departure Date')
ylabel('Arrival Date')
%title({'Variation in \DeltaV for Type-1 Earth-Mars Trajectories'})
c = colorbar;
c.Label.String = '\DeltaV  [km/s]';

% plots crosshairs at optimal point
y1=get(gca,'ylim');
x1=get(gca,'xlim');
plot([launcht launcht],y1,'color','r');
plot(x1,[arrivet arrivet],'color','r');


%%%%%%%%%%%%%%%%%%
% other plots
% figure(4)
% surf(X,Y,Z);
% plot3(x,y,z)
% stem3(x,y,z)
%%%%%%%%%%%%%%%%%%%


% calculates difference between NASA prediction and the software's
departureDays = launcht/dayInSec;
NASAdeparture = (J0(2020, 7, 24.6) - J0(2000,1,1));
differenceInDeparture = departureDays-NASAdeparture
arrivetDays = arrivet/dayInSec;
NASAarrive = (J0(2021, 2, 18) - J0(2000,1,1));
differenceInArrival = arrivetDays-NASAarrive

% plots NASA launch window
tNASAdepartureMin = (J0(2020, 7, 18) - J0(2000,1,1))*dayInSec;
tNASAdepartureMax = (J0(2020, 8, 5) - J0(2000,1,1))*dayInSec;
% plot([tNASAdepartureMin tNASAdepartureMax],[NASAarrive*dayInSec NASAarrive*dayInSec],'color','m');
% hold off

%variation in deltaV for NASA window
figure(2)
R2 = position(planetID2,NASAarrive*dayInSec);
coe = coe_from_position(planetID2,NASAarrive*dayInSec);
[r2, vPlanet2] = sv_from_coe(coe);

hold on
deltaVs = [];
idc = 1;
for tlaunch = tNASAdepartureMin-(24*60*60) : 12*60*60 : tNASAdepartureMax-(24*60*60)
    
    R1 = position(planetID1,tlaunch);
    coe = coe_from_position(planetID1,tlaunch);
    [r1, vPlanet1] = sv_from_coe(coe);
    tf = abs(tlaunch-(NASAarrive*dayInSec))/(dayInSec);
    [V1, V2, extremal_distances, exitflag] = lambert(R1, R2, tf, 0, mu);
    deltaV = (abs(norm(vPlanet1-V1)))+(abs(norm(vPlanet2-V2))); % [km/s]
    plot(tlaunch, deltaV,'.','color','b')
    deltaVs(idc) = deltaV;
    idc =idc+1;
    % attempt at plotting my departure date
%     y1=get(gca,'ylim');
%     plot([launcht launcht],[6:7],'color','r');
    
end

[value,position] = min(deltaVs);
mindVNASALaunchWindow = value;

% sets axes to dates
xticks(tNASAdepartureMin-(24*60*60):24*60*60:tNASAdepartureMax-(24*60*60));
datesX = {datestr(737990+(0*1),'dd-mmm-yy'),datestr(737990+(1*1),'dd-mmm-yy'),datestr(737990+(2*1),'dd-mmm-yy'),datestr(737990+(3*1),'dd-mmm-yy'),datestr(737990+(4*1),'dd-mmm-yy'),datestr(737990+(5*1),'dd-mmm-yy'),datestr(737990+(6*1),'dd-mmm-yy'),datestr(737990+(7*1),'dd-mmm-yy'),datestr(737990+(8*1),'dd-mmm-yy'),datestr(737990+(9*1),'dd-mmm-yy'),datestr(737990+(10*1),'dd-mmm-yy'),datestr(737990+(11*1),'dd-mmm-yy'),datestr(737990+(12*1),'dd-mmm-yy'),datestr(737990+(13*1),'dd-mmm-yy'),datestr(737990+(14*1),'dd-mmm-yy'),datestr(737990+(15*1),'dd-mmm-yy'),datestr(737990+(16*1),'dd-mmm-yy'),datestr(737990+(17*1),'dd-mmm-yy'),datestr(737990+(18*1),'dd-mmm-yy')};
xticklabels(datesX)
xtickangle(45)
%title({'Variation in \DeltaV over NASAs proposed launch','window assuming an arrival date of 18-02-21'})
xlabel('Departure Date')
ylabel('\DeltaV  [km/s]')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% variation in deltaV for NASA window but my arrival date

% R2 = position(planetID2,arrivet);
% coe = coe_from_position(planetID2,arrivet);
% [r2, vPlanet2] = sv_from_coe(coe);


% for tlaunch = tNASAdepartureMin-(24*60*60*4) : 60*60 : tNASAdepartureMax
%     
%     R1 = position(planetID1,tlaunch);
%     coe = coe_from_position(planetID1,tlaunch);
%     [r1, vPlanet1] = sv_from_coe(coe);
%     tf = abs(tlaunch-(NASAarrive*dayInSec))/(dayInSec);
%     [V1, V2, extremal_distances, exitflag] = lambert(R1, R2, tf, 0, mu);
%     deltaV = (abs(norm(vPlanet1-V1)))+(abs(norm(vPlanet2-V2))); % [km/s]
%     plot(tlaunch, deltaV,'.','color','m')
%     
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hold off

