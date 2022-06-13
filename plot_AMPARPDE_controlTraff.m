%%%plot control A bound for all idealized spines
%% 

clear
close all
clc

%%All stuff for Fig 2!!!

pathname = fileparts('resultsAutoPrint-ControlTraff/');

%Load both shapes at 3 different sizes; thin and mushroom
%ABound at 2 locations
%All are 300s with steps 0.1
thin05Con = load('controlCases/Abound-time23-thin05-both-control.txt');
thin1Con = load('controlCases/Abound-time23-thin1-both-control.txt');
thin15Con = load('controlCases/Abound-time23-thin15-both-control.txt');

mush05Con = load('controlCases/Abound-time24-mush05-both-control.txt');
mush1Con = load('controlCases/Abound-time24-mush1-both-control.txt');
mush15Con = load('controlCases/Abound-time24-mush15-both-control.txt');

% Indexes - bistable then monostable; location 2 and then 3/4
% 1,2 - bistable (top PSD, side PSD)
% 3,4 - monostable (top PSD, side PSD)

time = 300;
stepSize = 0.1;
steps = time/stepSize + 1;
t = [0:0.1:300];

marker = ['+', 'o','^','<','>','x'];
colorsBig = {[102 255 255]/255; [0 255 255]/255; [102 255 204]/255; [51 255 204]/255; [0 255 204]/255; [0 204 153]/255;  .../ %teal 6
          [0 255 255]/255; [0 204 255]/255; [0 153 255]/255; [0 102 255]/255; [0 51 255]/255; [0 51 204]/255;  .../ %blue
          [153 255 102]/255; [102 255 51]/255; [51 255 0]/255; [51 204 51]/255; [0 153 0]/255; [0 102 0]/255;  .../ %green
          [255 51 51]/255; [255 0 51]/255; [255 0 0]/255; [204 0 0]/255; [153 0 0]/255; [102 0 0]/255;  .../ %red
          [255 204 255]/255; [255 153 255]/255; [255 102 255]/255; [255 51 255]/255; [204 51 204]/255; [153 51 153]/255;  .../ %pink/purple
          [255 255 153]/255; [255 255 102]/255; [255 255 51]/255; [255 255 0]/255; [255 204 51]/255; [255 204 0]/255  };   %yellow?

      %initial conditions for Abound
ICAB = [1077.45 1085 1091.9 1067 1076.2 1082.45]; %#/um2

styles = {"-",":","-.","-",":","-.","-",":","-."};
colors = {[0.301 0.745 0.933];[0.85 0.325 0.098];[0.466 0.674 0.188];[0 0.447 0.741];[0.635 0.078 0.184];[0.466 0.674 0.188]/2;[0 0.447 0.741]/1.5;[0.635 0.078 0.184]/1.5;[0.466 0.674 0.188]/3}; %blue, red, green
newcolors=[[0.301 0.745 0.933];[0.85 0.325 0.098];[0.466 0.674 0.188];[0 0.447 0.741];[0.635 0.078 0.184];[0.466 0.674 0.188]/2;[0 0.447 0.741]/1.5;[0.635 0.078 0.184]/1.5;[0.466 0.674 0.188]/3];

%pulling out the steady state values for all control
SSMatrix = zeros(6,4); %thin 05, 1, 15, mush 05, 1, 15; then bistable PSD top, side, then mono top side
SSDiffMatrix = zeros(6,4); %thin 05, 1, 15, mush 05, 1, 15; then bistable PSD top, side, then mono top side
for i = [1 2 3 4]%[1 5 9 13]
    SSMatrix(1,i) = thin05Con((steps*i),2);
    SSMatrix(2,i) = thin1Con((steps*i),2);
    SSMatrix(3,i) = thin15Con((steps*i),2);
    SSMatrix(4,i) = mush05Con((steps*i),2);
    SSMatrix(5,i) = mush1Con((steps*i),2);
    SSMatrix(6,i) = mush15Con((steps*i),2);
    
    SSDiffMatrix(1,i) = thin05Con((steps*i),2)-ICAB(1);
    SSDiffMatrix(2,i) = thin1Con((steps*i),2)-ICAB(2);
    SSDiffMatrix(3,i) = thin15Con((steps*i),2)-ICAB(3);
    SSDiffMatrix(4,i) = mush05Con((steps*i),2)-ICAB(4);
    SSDiffMatrix(5,i) = mush1Con((steps*i),2)-ICAB(5);
    SSDiffMatrix(6,i) = mush15Con((steps*i),2)-ICAB(6);
end

%geometry info - 05, 5, 15, thin then mush
%all vol
vols = [2.0327e-20 4.0655e-20 6.0982e-20 1.3706e-19 2.7413e-19 4.1119e-19]*1e18; %m3 then um3
%all SA
SAs = [4.3873e-13 6.9644e-13 9.1259e-13 1.6364e-12 2.5976e-12 3.4038e-12]*1e12; %m2 then um2
%all PSD
PSDs = [2.5332e-14 4.0212e-14 5.2693e-14 9.0549e-14 1.4374e-13 1.8835e-13]*1e12; %m2 then um2



% newcolors = [0 0.4470 0.7410; 0 .5 .5];
styleLine = ['-','--',':'];
%control volumes
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter = 1;
for i = [1 3]%[1 5 9 13]
    plot(thin1Con((steps*(i-1)+1):(steps*i),1), thin1Con(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine - top of PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(2) 1650*PSDs(2)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-thin1-both-topPSD-control.png');
saveas(gcf, pngfile);

%%%
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter=1;
for i = [1 3]%[1 5 9 13]
    plot(mush1Con((steps*(i-1)+1):(steps*i),1), mush1Con(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Mush Spine - top of PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1500])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(5) 1500*PSDs(5)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder({'r','b','c'})
legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-mush1-both-topPSD-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vs Vol %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs Vol - as density
%%%%plot SS vs vol
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols, SSMatrix(:,1),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols, SSMatrix(:,3),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol (\mum^3)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVol-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs vol
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols, SSDiffMatrix(:,1),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols, SSDiffMatrix(:,3),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#/\mum^2)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsVol-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs vol
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols, 100*SSDiffMatrix(:,1)./SSMatrix(:,1),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols, 100*SSDiffMatrix(:,3)./SSMatrix(:,3),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('Percent Change (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSPercentvsVol-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs Vol - as #
%%%%plot SS vs vol
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols, SSMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols, SSMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVol-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs vol
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols, SSDiffMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols, SSDiffMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsVol-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vs SA %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs SA - as density
%%%%plot SS vs SA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(SAs, SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(SAs, SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Surface Area (\mum^2)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsSA-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs SA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(SAs, SSDiffMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(SAs, SSDiffMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#/\mum^2)')
xlabel('Surface Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsSA-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs SA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(SAs, 100*SSDiffMatrix(:,1)./SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(SAs, 100*SSDiffMatrix(:,3)./SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Percent Change (%)')
xlabel('Surface Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSPercentvsSA-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs SA - as #
%%%%plot SS vs SA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(SAs, SSMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(SAs, SSMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#)')
xlabel('Surface Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsSA-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs SA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(SAs, SSDiffMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(SAs, SSDiffMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#)')
xlabel('Surface Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsSA-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vs Vol to SA %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs VSA - as density
%%%%plot SS vs VSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./SAs, SSMatrix(:,1),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./SAs, SSMatrix(:,3),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol to SA ratio (\mum)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVSA-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs VSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./SAs, SSDiffMatrix(:,1),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./SAs, SSDiffMatrix(:,3),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#/\mum^2)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsVSA-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs VSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./SAs, 100*SSDiffMatrix(:,1)./SSMatrix(:,1),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./SAs, 100*SSDiffMatrix(:,3)./SSMatrix(:,3),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('Percent Change (%)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSPercentvsVSA-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs VSA - as #
%%%%plot SS vs VSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./SAs, SSMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./SAs, SSMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVSA-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs VSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./SAs, SSDiffMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 12);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./SAs, SSDiffMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 12);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsVSA-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vs PSD %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs PSD - as density
%%%%plot SS vs PSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs, SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs, SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('PSD Area (\mum^2)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsPSD-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs PSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs, SSDiffMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs, SSDiffMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#/\mum^2)')
xlabel('PSD Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsPSD-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs PSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs, 100*SSDiffMatrix(:,1)./SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs, 100*SSDiffMatrix(:,3)./SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Percent Change (%)')
xlabel('PSD Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSPercentvsPSD-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs PSD - as #
%%%%plot SS vs PSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs, SSMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs, SSMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#)')
xlabel('PSD Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsPSD-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs PSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs, SSDiffMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs, SSDiffMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#)')
xlabel('PSD Area (\mum^2)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsPSD-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vs VPSD %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs VPSD - as density
%%%%plot SS vs VPSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./PSDs, SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./PSDs, SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol to PSD Area ratio (\mum)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVPSD-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs VPSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./PSDs, SSDiffMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./PSDs, SSDiffMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#/\mum^2)')
xlabel('Vol to PSD Area ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsVPSD-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs VPSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./PSDs, 100*SSDiffMatrix(:,1)./SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./PSDs, 100*SSDiffMatrix(:,3)./SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Percent Change (%)')
xlabel('Vol to PSD Area ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSPercentvsVPSD-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs VPSD - as #
%%%%plot SS vs VPSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./PSDs, SSMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./PSDs, SSMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#)')
xlabel('Vol to PSD Area ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVPSD-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs VPSD
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols./PSDs, SSDiffMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(vols./PSDs, SSDiffMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#)')
xlabel('Vol to PSD Area ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsVPSD-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vs PSDSA %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs PSDSA - as density
%%%%plot SS vs PSDSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs./SAs, SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs./SAs, SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('PSD Area to Surface Area ratio');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsPSDSA-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs PSDSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs./SAs, SSDiffMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs./SAs, SSDiffMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#/\mum^2)')
xlabel('PSD Area to Surface Area ratio');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsPSDSA-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs PSDSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs./SAs, 100*SSDiffMatrix(:,1)./SSMatrix(:,1),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs./SAs, 100*SSDiffMatrix(:,3)./SSMatrix(:,3),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Percent Change (%)')
xlabel('PSD Area to Surface Area ratio');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSPercentvsPSDSA-both-control.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%SS, SS Diff, SS Diff % all vs PSDSA - as #
%%%%plot SS vs PSDSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs./SAs, SSMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs./SAs, SSMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('Bound AMPAR (#)')
xlabel('PSD Area to Surface Area ratio');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsPSDSA-totNum-both-control.png');
saveas(gcf, pngfile);

%%%%plot SS vs PSDSA
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(PSDs./SAs, SSDiffMatrix(:,1).*PSDs(:),marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
hold on
plot(PSDs./SAs, SSDiffMatrix(:,3).*PSDs(:),marker(2), 'MarkerSize', 9);
title('Steady state Bound AMPAR')
ylabel('\Delta from steady state (#)')
xlabel('PSD Area to Surface Area ratio');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABDiffSSvsPSDSA-totNum-both-control.png');
saveas(gcf, pngfile);


%%%%plot IC of A bound vs vol
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%yyaxis left
colororder(newcolors)
plot(vols, ICAB,marker(1), 'MarkerSize', 9);%'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
title('IC Bound AMPAR')
ylabel('IC Bound AMPAR (#/\mum^2)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ICABvsVol-both-control.png');
saveas(gcf, pngfile);
