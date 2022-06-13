%%%plot control A bound for all idealized spines
%% 

clear
close all
clc

%%All stuff for control cases, and trafficking variations

pathname = fileparts('resultsAutoPrint/');

thin05Con = load('controlAndTraffCases/Abound-time23-thin05-both-control.txt');
thin075Con = load('controlAndTraffCases/Abound-time23-thin075-both-control.txt');
thin1Con = load('controlAndTraffCases/Abound-time23-thin1-both-control.txt');
thin125Con = load('controlAndTraffCases/Abound-time23-thin125-both-control.txt');
thin15Con = load('controlAndTraffCases/Abound-time23-thin15-both-control.txt');



%Load both shapes at 3 different sizes; thin and mushroom
%ABound at 2 locations
%All are 300s with steps 0.1
thin05Var = load('controlAndTraffCases/temporal-time23-thin05-both-traffVars-abound.txt');
thin075Var = load('controlAndTraffCases/temporal-time23-thin075-both-traffVars-abound.txt');
thin1Var = load('controlAndTraffCases/temporal-time23-thin1-both-traffVars-abound.txt');
thin125Var = load('controlAndTraffCases/temporal-time23-thin125-both-traffVars-abound.txt');
thin15Var = load('controlAndTraffCases/temporal-time23-thin15-both-traffVars-abound.txt');

%Append thinCon to end of thinVar
thin05Var = [thin05Var; thin05Con];
thin075Var = [thin075Var; thin075Con];
thin1Var = [thin1Var; thin1Con];
thin125Var = [thin125Var; thin125Con];
thin15Var = [thin15Var; thin15Con];

%%%Mush
mush05Var = load('controlAndTraffCases/temporal-time24-mush05-both-ALLtraffCon-abound.txt');
mush075Var = load('controlAndTraffCases/temporal-time24-mush075-both-ALLtraffCon-abound.txt');
mush1Var = load('controlAndTraffCases/temporal-time24-mush1-both-ALLtraffCon-abound.txt');
mush125Var = load('controlAndTraffCases/temporal-time24-mush125-both-ALLtraffCon-abound.txt');
mush15Var = load('controlAndTraffCases/temporal-time24-mush15-both-ALLtraffCon-abound.txt');

% Indexes - bistable then monostable; location 2 and then 3/4
% 1,2,3,4 - bi (top PSD, side PSD); mono (top PSD, side PSD); no influx
% 5,6,7,8 - bi (top, side), mono (top, side); only diff (no influx/enex)
% 9,10,11,12 - bi, mono; no enex (with influx and diff)
% 13,14,15,16 - bi, mono; no diffusion (with influx and enex)
% 17, 18, 19, 20  - bi, mono; control case

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
ICAB = [1077.45 1082.025 1085 1088.5 1091.9 1067 1072.2 1076.2 1079.6 1082.45]; %#/um2

styles = {"-",":","-.","-+","-*"};
styles3 = {"-",":","-.","-",":","-.","-",":","-."};

colors = {[0 0.4470 0.7410];[0.8500 0.3250 0.0980];[0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560];[0.4660 0.6740 0.1880]}; %set of 5, blue, red, yellow, purple, green
newcolors = [[0 0.4470 0.7410];[0.8500 0.3250 0.0980];[0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560];[0.4660 0.6740 0.1880]];
%set of 3s colors = {[0.301 0.745 0.933];[0.85 0.325 0.098];[0.466 0.674 0.188];[0 0.447 0.741];[0.635 0.078 0.184];[0.466 0.674 0.188]/2;[0 0.447 0.741]/1.5;[0.635 0.078 0.184]/1.5;[0.466 0.674 0.188]/3}; %blue, red, green
%newcolors=[[0.301 0.745 0.933];[0.85 0.325 0.098];[0.466 0.674 0.188];[0 0.447 0.741];[0.635 0.078 0.184];[0.466 0.674 0.188]/2;[0 0.447 0.741]/1.5;[0.635 0.078 0.184]/1.5;[0.466 0.674 0.188]/3];

%pulling out the steady state values for all control
SSMatrix = zeros(10,5,4); %thin 05, 0.75, 1, 125, 15 mush 05, 0.75, 1, 125, 15; then 5 different conditions (no influx; no influx and no enex; no enex; no diff; control); bistable PSD top, side, then mono top side;
SSDiffMatrix = zeros(10,5,4); %thin 05, 0.75, 1, 125, 15, mush 05, 0.75, 1, 125, 15; then 5 different conditions (no influx; no influx and no enex; no enex; no diff; control) bistable PSD top, side, then mono top side;
for i = [1 2 3 4 5] %4 different cases
    for j = 1:4 % bistable PSD top, side, then mono top side;
        SSMatrix(1,i,j) = thin05Var((steps*(j+4*(i-1))),2);
    	SSMatrix(2,i,j) = thin075Var((steps*(j+4*(i-1))),2);
        SSMatrix(3,i,j) = thin1Var((steps*(j+4*(i-1))),2);
        SSMatrix(4,i,j) = thin125Var((steps*(j+4*(i-1))),2);
        SSMatrix(5,i,j) = thin15Var((steps*(j+4*(i-1))),2);
        SSMatrix(6,i,j) = mush05Var((steps*(j+4*(i-1))),2);
        SSMatrix(7,i,j) = mush075Var((steps*(j+4*(i-1))),2);
        SSMatrix(8,i,j) = mush1Var((steps*(j+4*(i-1))),2);
        SSMatrix(9,i,j) = mush125Var((steps*(j+4*(i-1))),2);
        SSMatrix(10,i,j) = mush15Var((steps*(j+4*(i-1))),2);

		SSDiffMatrix(1,i,j) = thin05Var((steps*(j+4*(i-1))),2)-ICAB(1);
    	SSDiffMatrix(2,i,j) = thin075Var((steps*(j+4*(i-1))),2)-ICAB(2);
        SSDiffMatrix(3,i,j) = thin1Var((steps*(j+4*(i-1))),2)-ICAB(3);
        SSDiffMatrix(4,i,j) = thin125Var((steps*(j+4*(i-1))),2)-ICAB(4);
        SSDiffMatrix(5,i,j) = thin15Var((steps*(j+4*(i-1))),2)-ICAB(5);
        SSDiffMatrix(6,i,j) = mush05Var((steps*(j+4*(i-1))),2)-ICAB(6);
        SSDiffMatrix(7,i,j) = mush075Var((steps*(j+4*(i-1))),2)-ICAB(7);
        SSDiffMatrix(8,i,j) = mush1Var((steps*(j+4*(i-1))),2)-ICAB(8);
        SSDiffMatrix(9,i,j) = mush125Var((steps*(j+4*(i-1))),2)-ICAB(9);
        SSDiffMatrix(10,i,j) = mush15Var((steps*(j+4*(i-1))),2)-ICAB(10);

        
    end
end


%geometry info - 05, 0.75, 1, 125, 15, thin then mush
%all vol
vols = [2.0327e-20 3.0863e-20 4.0655e-20 5.1438e-20 6.1726e-20 1.3869e-19 2.0803e-19 2.7738e-19 3.4672e-19 4.1607e-19]*1e18; %m3 then um3
%all SA
SAs = [4.3873e-13 5.7489e-13 6.9644e-13 8.0814e-13 9.1259e-13 1.6364e-12 2.1443e-12 2.5976e-12 3.0142e-12 3.4038e-12]*1e12; %m2 then um2
%all PSD
PSDs = [2.5332e-14 3.3195e-14 4.0212e-14 4.6662e-14 5.1647e-14 1.9236e-13 2.5206e-13 3.0535e-13 3.5432e-13 4.0012e-13]*1e12; %m2 then um2

VSAs = vols./SAs;

% Indexes - bistable then monostable; location 2 and then 3/4
% 1,2,3,4 - bi (top PSD, side PSD); mono (top PSD, side PSD); no influx
% 5,6,7,8 - bi (top, side), mono (top, side); only diff (no influx/enex)
% 9,10,11,12 - bi, mono; no enex (with influx and diff)
% 13,14,15,16 - bi, mono; no diffusion (with influx and enex)
% 17, 18, 19, 20  - bi, mono; control case


%%%%%Control trafficking case
%will plot temporal dynamics for thin and mush control for both bistable and monostable; as density and number

%control thin bi and mono
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter = 1;
for i = [17 19]%[1 5 9 13]
    plot(thin1Var((steps*(i-1)+1):(steps*i),1), thin1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
%title('Thin Spine - top of PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-thin1-both-topPSD-control.png');
saveas(gcf, pngfile);

%%% mush control bi mono
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter=1;
for i = [17 19]%[1 5 9 13]
    plot(mush1Var((steps*(i-1)+1):(steps*i),1), mush1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
%title('Mush Spine - top of PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1500])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(8) 1500*PSDs(8)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-mush1-both-topPSD-control.png');
saveas(gcf, pngfile);

%%%plot temporal all trafficking cases
%control volumes thin - all cases, do bi and mono separately
%bi
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter = 1;
for i = [17 1 5 9 13]%[1 5 9 13]
    plot(thin1Var((steps*(i-1)+1):(steps*i),1), thin1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
%title('Thin Spine - bi top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'All','No influx','Only diffusion','No EnEx','No diffusion'},'Location','East')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-thin1-bi-topPSD-allTraf.png');
saveas(gcf, pngfile);

%control volumes thin - all cases MONO
figure 
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter = 1;
for i = [17 1 5 9 13]+2
    plot(thin1Var((steps*(i-1)+1):(steps*i),1), thin1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
%title('Thin Spine - mono top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1300])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(3) 1300*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
% legend({'All','No influx','Only diffusion','No EnEx','No diffusion'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-thin1-mono-topPSD-allTraf.png');
saveas(gcf, pngfile);

%control volumes mush - all cases, do bi and mono separately
%bi
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter = 1;
for i = [17 1 5 9 13]%[1 5 9 13]
    plot(mush1Var((steps*(i-1)+1):(steps*i),1), mush1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
%title('Thin Spine - bi top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(8) 1650*PSDs(8)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'All','No influx','Only diffusion','No EnEx','No diffusion'},'Location','Northwest')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-mush1-bi-topPSD-allTraf.png');
saveas(gcf, pngfile);

%control volumes mush - all cases MONO
figure 
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis left
colororder(newcolors)
counter = 1;
for i = [17 1 5 9 13]+2
    plot(mush1Var((steps*(i-1)+1):(steps*i),1), mush1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
%title('Thin Spine - mono top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
ylim([1000 1200])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
yyaxis right
ylabel('Bound AMPAR (#)')
ylim([1000*PSDs(8) 1200*PSDs(8)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
% legend({'All','No influx','Only diffusion','No EnEx','No diffusion'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-mush1-mono-topPSD-allTraf.png');
saveas(gcf, pngfile);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%control trafficking vs geometry
%density vs vol, vs VSA; # vs vol, vs VSA; percent change vs vol, vs VSA
%plotting bi and mono together but ONLY thin then ONLY mush

%%%%%%%%%%%%%%%%%%%%%%%%%%THIN
%%%%plot SS vs vol thin
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), SSMatrix(1:5,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(1:5), SSMatrix(1:5,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol (\mum^3)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVol-thin-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS vs VSA thin
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), SSMatrix(1:5,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(1:5), SSMatrix(1:5,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol to SA ratio (\mum)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVSA-thin-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS # vs vol thin
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), SSMatrix(1:5,5,1).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(1:5), SSMatrix(1:5,5,3).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVol-thin-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS # vs VSA thin
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), SSMatrix(1:5,5,1).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(1:5), SSMatrix(1:5,5,3).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750]*PSDs(5))
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVSA-thin-both-Con.png');
saveas(gcf, pngfile);


%%%%plot percent change vs vol thin
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), 100*SSDiffMatrix(1:5,5,1)./ICAB(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(1:5), 100*SSDiffMatrix(1:5,5,3)./ICAB(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVol-thin-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS % vs VSA thin
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), 100*SSDiffMatrix(1:5,5,1)./ICAB(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(1:5), 100*SSDiffMatrix(1:5,5,3)./SSMatrix(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVSA-thin-both-Con.png');
saveas(gcf, pngfile);


%%%%%%%%%%%%%%%%%%%%%%%%%%MUSH
%%%%plot SS vs vol mush
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(6:10), SSMatrix(6:10,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), SSMatrix(6:10,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol (\mum^3)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVol-mush-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS vs VSA mush
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(6:10), SSMatrix(6:10,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), SSMatrix(6:10,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol to SA ratio (\mum)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVSA-mush-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS # vs vol mush
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(6:10), SSMatrix(6:10,5,1).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), SSMatrix(6:10,5,3).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVol-mush-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS # vs VSA mush
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(6:10), SSMatrix(6:10,5,1).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), SSMatrix(6:10,5,3).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVSA-mush-both-Con.png');
saveas(gcf, pngfile);


%%%%plot percent change vs vol mush
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(6:10), 100*SSDiffMatrix(6:10,5,1)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), 100*SSDiffMatrix(6:10,5,3)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVol-mush-both-Con.png');
saveas(gcf, pngfile);

%%%%plot SS % vs VSA mush
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(6:10), 100*SSDiffMatrix(6:10,5,1)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), 100*SSDiffMatrix(6:10,5,3)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVSA-mush-both-Con.png');
saveas(gcf, pngfile);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%control trafficking vs geometry
%density vs vol, vs VSA; # vs vol, vs VSA; percent change vs vol, vs VSA
%plotting thin and mush together, separate by bi and mono!

%%%%%%%%%%%%%%%%%%%%%%%%%%THIN
%%%%plot SS vs vol bi
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), SSMatrix(1:5,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), SSMatrix(6:10,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol (\mum^3)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVol-allVol-bi-Con.png');
saveas(gcf, pngfile);

%%%%plot SS vs vol mono
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), SSMatrix(1:5,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), SSMatrix(6:10,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol (\mum^3)');
ylim([1000 1350])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVol-allVol-mono-Con.png');
saveas(gcf, pngfile);

%%%%plot SS # vs vol bi
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), SSMatrix(1:5,5,1).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), SSMatrix(6:10,5,1).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVol-allVol-bi-Con.png');
saveas(gcf, pngfile);

%%plot SS # vs vol mono
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), SSMatrix(1:5,5,3).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), SSMatrix(6:10,5,3).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVol-allVol-mono-Con.png');
saveas(gcf, pngfile);


%%%%plot percent change vs vol bi
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), 100*SSDiffMatrix(1:5,5,1)./ICAB(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), 100*SSDiffMatrix(6:10,5,1)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVol-allVol-bi-Con.png');
saveas(gcf, pngfile);

%%%%plot percent change vs vol mono
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(1:5), 100*SSDiffMatrix(1:5,5,3)./ICAB(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(vols(6:10), 100*SSDiffMatrix(6:10,5,3)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVol-allVol-mono-Con.png');
saveas(gcf, pngfile);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%same as above but vs VSA
%%%%%%%%%%%%%%%%%%%%%%%%%%THIN
%%%%plot SS vs VSA bi
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), SSMatrix(1:5,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), SSMatrix(6:10,5,1),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol to SA ratio (\mum)');
ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVSA-allVSA-bi-Con.png');
saveas(gcf, pngfile);

%%%%plot SS vs VSA mono
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), SSMatrix(1:5,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), SSMatrix(6:10,5,3),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol to SA ratio (\mum)');
ylim([1000 1350])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSvsVSA-allVSA-mono-Con.png');
saveas(gcf, pngfile);

%%%%plot SS # vs VSA bi
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), SSMatrix(1:5,5,1).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), SSMatrix(6:10,5,1).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVSA-allVSA-bi-Con.png');
saveas(gcf, pngfile);

%%plot SS # vs vol mono
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), SSMatrix(1:5,5,3).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), SSMatrix(6:10,5,3).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Bound AMPAR (#)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSTotNumvsVSA-allVSA-mono-Con.png');
saveas(gcf, pngfile);


%%%%plot percent change vs vol bi
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), 100*SSDiffMatrix(1:5,5,1)./ICAB(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), 100*SSDiffMatrix(6:10,5,1)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVSA-allVSA-bi-Con.png');
saveas(gcf, pngfile);

%%%%plot percent change vs vol mono
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(VSAs(1:5), 100*SSDiffMatrix(1:5,5,3)./ICAB(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
hold on
counter = counter + 1;
%end
plot(VSAs(6:10), 100*SSDiffMatrix(6:10,5,3)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title('Steady state Bound AMPAR - BiMono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVSA-allVSA-mono-Con.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%all trafficking cases vs vol, vs VSA; split into bi vs monostable
%%%%plot percent change vs vol mush
figure %bi
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [5 1 2 3 4] %plot all 
	plot(vols, 100*SSDiffMatrix(:,i,1)./ICAB(:),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
	hold on
	counter = counter + 1;
end
%title'Steady state Bound AMPAR - Bi')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%legend({'All','No influx','Only diffusion','No EnEx','No diffusion'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVol-allVol-bi-allTraff.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [5 1 2 3 4] %plot all 
	plot(vols, 100*SSDiffMatrix(:,i,3)./ICAB(:),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
	hold on
	counter = counter + 1;
end
%title'Steady state Bound AMPAR - Mono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'All','No influx','Only diffusion','No EnEx','No diffusion'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVol-allVol-mono-allTraff.png');
saveas(gcf, pngfile);

%%%%plot SS % vs VSA all
figure %bi
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [5 1 2 3 4] %plot all 
	plot(VSAs, 100*SSDiffMatrix(:,i,1)./ICAB(:),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
	hold on
	counter = counter + 1;
end
%title'Steady state Bound AMPAR - Bi')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVSA-allVSA-bi-allTraff.png');
saveas(gcf, pngfile);

figure %mono
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [5 1 2 3 4] %plot all 
	plot(VSAs, 100*SSDiffMatrix(:,i,3)./ICAB(:),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
	hold on
	counter = counter + 1;
end
%title'Steady state Bound AMPAR - Mono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol to SA ratio (\mum)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVSA-allVSA-mono-allTraff.png');
saveas(gcf, pngfile);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%temporal - plot all control traff for mushroom sizes; monostable then bi
%stable 

figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [19]%[1 5 9 13]
    plot(mush05Var((steps*(i-1)+1):(steps*i),1), mush05Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
    plot(mush075Var((steps*(i-1)+1):(steps*i),1), mush075Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(mush1Var((steps*(i-1)+1):(steps*i),1), mush1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(mush125Var((steps*(i-1)+1):(steps*i),1), mush125Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(mush15Var((steps*(i-1)+1):(steps*i),1), mush15Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    
end
%title('Thin Spine - bi top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis right
% ylabel('Bound AMPAR (#)')
% ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'0.5','0.75','1','1.25','1.5'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-allMush-mono-topPSD-Con.png');
saveas(gcf, pngfile);

%bistable
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [17]%[1 5 9 13]
    plot(mush05Var((steps*(i-1)+1):(steps*i),1), mush05Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
    plot(mush075Var((steps*(i-1)+1):(steps*i),1), mush075Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(mush1Var((steps*(i-1)+1):(steps*i),1), mush1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(mush125Var((steps*(i-1)+1):(steps*i),1), mush125Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(mush15Var((steps*(i-1)+1):(steps*i),1), mush15Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    
end
%title('Thin Spine - bi top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis right
% ylabel('Bound AMPAR (#)')
% ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'0.5','0.75','1','1.25','1.5'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-allMush-bi-topPSD-Con.png');
saveas(gcf, pngfile);


%%%%all thin

figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [19]%[1 5 9 13]
    plot(thin05Var((steps*(i-1)+1):(steps*i),1), thin05Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
    plot(thin075Var((steps*(i-1)+1):(steps*i),1), thin075Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(thin1Var((steps*(i-1)+1):(steps*i),1), thin1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(thin125Var((steps*(i-1)+1):(steps*i),1), thin125Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(thin15Var((steps*(i-1)+1):(steps*i),1), thin15Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    
end
%title('Thin Spine - bi top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis right
% ylabel('Bound AMPAR (#)')
% ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'0.5','0.75','1','1.25','1.5'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-allThin-mono-topPSD-Con.png');
saveas(gcf, pngfile);


%bistable
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
for i = [17]%[1 5 9 13]
    plot(thin05Var((steps*(i-1)+1):(steps*i),1), thin05Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
    plot(thin075Var((steps*(i-1)+1):(steps*i),1), thin075Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(thin1Var((steps*(i-1)+1):(steps*i),1), thin1Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(thin125Var((steps*(i-1)+1):(steps*i),1), thin125Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    counter = counter + 1;
    plot(thin15Var((steps*(i-1)+1):(steps*i),1), thin15Var(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    
end
%title('Thin Spine - bi top PSD')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis right
% ylabel('Bound AMPAR (#)')
% ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'0.5','0.75','1','1.25','1.5'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-temporal-allThin-bi-topPSD-Con.png');
saveas(gcf, pngfile);


%%%%%plot all IC
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
plot(vols(1:5),ICAB(1:5),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
counter = 2;
hold on
plot(vols(6:10),ICAB(6:10),marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
title('Initial Conditions')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Vol (\mum^3)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis right
% ylabel('Bound AMPAR (#)')
% ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
legend({'Thin','Mushroom'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ICABvsVol-allVols.png');
saveas(gcf, pngfile);

%%%%%plot all IC
figure
colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
plot(vols(1:5),ICAB(1:5).*PSDs(1:5).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
counter = 2;
hold on
plot(vols(6:10),ICAB(6:10).*PSDs(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
title('Initial Conditions')
ylabel('Bound AMPAR (#)')
xlabel('Vol (\mum^3)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis right
% ylabel('Bound AMPAR (#)')
% ylim([1000*PSDs(3) 1650*PSDs(3)])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder({'r','b','c'})
%legend({'0.5','0.75','1','1.25','1.5','0.5','0.75','1','1.25','1.5'},'Location','East')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ICABTotNumvsVol-allVols.png');
saveas(gcf, pngfile);



%%%%plot percent change vs vol mush
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
colororder(newcolors)
counter = 1;
%for i = 1:5 %plot all 
plot(vols(6:10), 100*SSDiffMatrix(6:10,5,3)./ICAB(6:10).',marker(counter), 'MarkerSize', 12,'MarkerFaceColor',colors{counter}, 'Color' , colors{counter})
%title'Steady state Bound AMPAR - Mono')
ylabel('Change in Bound AMPAR (%)')
xlabel('Vol (\mum^3)');
%ylim([1000 1750])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% legend({'Bistable','Monostable'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'ABound-ABSSPercentvsVol-mush-mono-Con.png');
saveas(gcf, pngfile);

