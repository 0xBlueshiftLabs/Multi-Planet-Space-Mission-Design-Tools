close all
clear all

%%% Creates animation of 2 planet's orbits as well as the trajectory of a spacecraft travelling between them %%%

dayInSec = 24*60*60; % days to seconds conversion

% INPUTS %
planetID1 = 3;
planetID2 = 4;
t1 = (J0(2001,4,7)-J0(2000,1,1))*dayInSec; % [s] March 14th 2016
t2 = (J0(2001,10,24)-J0(2000,1,1))*dayInSec; % [s] October 19th 2016
stepsize = (1*dayInSec); % [s]
fileName = '2001 Mars Odyssey';

earth = animatedline('LineWidth',1,'color','b');
mars = animatedline('LineWidth',1,'color','r');
craft = animatedline('LineWidth',1,'color','g');

set(gca,'Xlim',[-3e8 2e8],'Ylim',[-2.5e8 2e8],'Zlim',[-15e6 15e6]);
set(gca,'Color','k'); % makes back ground dark
view(45,45);
hold on

% gif creation stuff
myWriter = VideoWriter(fileName);
myWriter.Quality = 100;
myWriter.FrameRate = 20;

% finds and sets initial TA value for subsequent for loop
[TA1 TA2] = initialnfinalTA(planetID1,planetID2,t1,t2);
TA = TA1;


plot3(0,0,0,'.','color','y','MarkerSize',50) % plots sun
xlabel('x')
ylabel('y')
zlabel('z')
grid on
ax = gca;
ax.GridColor = 'w'; % sets grid colour

counter = 1;

for t = t1:stepsize:t2
    
    % plots earth position
    e = position(planetID1,t);
    addpoints(earth,e(1),e(2),e(3));
    ehead = scatter3(e(1),e(2),e(3),100,'filled','MarkerFaceColor','b');
    drawnow
    
    % plots mars position
    m = position(planetID2,t);
    addpoints(mars,m(1),m(2),m(3));
    mhead = scatter3(m(1),m(2),m(3),100,'filled','MarkerFaceColor','r');
    drawnow
    
    % plots space craft position 
    R = craftPosition(planetID1,planetID2,t1,t2,TA);
    addpoints(craft,R(1),R(2),R(3));
    crafthead = scatter3(R(1),R(2),R(3),'^','filled','MarkerFaceColor','g');
    drawnow
    
    TA = TA + ((TA2-TA1)/((t2-t1)/stepsize));
    
    %pause(0.0025);
    
    % gif save image line should probably go here
    view(45,45);
    movieVector(counter) = getframe;
    
    % deletes marker heads before the next plot
    delete(ehead);
    delete(mhead);
    delete(crafthead);
    counter = counter+1;
    
end

% Writes the video file
open(myWriter);
writeVideo(myWriter,movieVector);
close(myWriter);