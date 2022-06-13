%%%plot control thin spine leaky
%% 

clear
close all
clc

%%All stuff for Fig 3

pathname = fileparts('resultsAutoPrint-leaky/');

%Load thin at 3 different sizes;
%ABound at 2 locations
%CaMKIIp, PP1, Aint, Amem at 3 locations
%3 different cacam inputs
%All are 300s with steps 0.1

camkiip = load('leaky/temporal-time234-thin1-both-control-leakyAllinput-camkiip.txt');
pp1 = load('leaky/temporal-time234-thin1-both-control-leakyAllinput-pp1.txt');
aint = load('leaky/temporal-time234-thin1-both-control-leakyAllinput-aint.txt');
amem = load('leaky/temporal-time234-thin1-both-control-leakyAllinput-amem.txt');
abound = load('leaky/temporal-time234-thin1-both-control-leakyAllinput-abound.txt');

cacam02 = load('leaky/CaCaM-pulse-2s.txt');
cacam10 = load('leaky/CaCaM-pulse-10s.txt');
cacam20 = load('leaky/CaCaM-pulse-20s.txt');
% Indexes - bistable then monostable; location 2 and then 3/4
%sets of 3; abound is set of 2
% 1,2,3 - bistable (top PSD, side PSD, bottom neck), cacam 2
% 4,5,6 - monostable (top PSD, side PSD, bottom neck), cacam 2
% 7,8,9 - bistable (top PSD, side PSD, bottom neck), cacam 10
% 10,11,12 - monostable (top PSD, side PSD, bottom neck), cacam 10
% 13,14,15 - bistable (top PSD, side PSD, bottom neck), cacam 20
% 16,17,18 - monostable (top PSD, side PSD, bottom neck), cacam 20

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

%geometry info - 05, 5, 15, thin then mush
%all vol
vols = [2.0327e-20 4.0655e-20 6.0982e-20 1.3706e-19 2.7413e-19 4.1119e-19]*1e18; %m3 then um3
%all SA
SAs = [4.3873e-13 6.9644e-13 9.1259e-13 1.6364e-12 2.5976e-12 3.4038e-12]*1e12; %m2 then um2
%all PSD
PSDs = [2.5332e-14 4.0212e-14 5.2693e-14 9.0549e-14 1.4374e-13 1.8835e-13]*1e12; %m2 then um2

styles = {"-",":","-.","-",":","-.","-",":","-."};
colors = {[0.301 0.745 0.933];[0.85 0.325 0.098];[0.466 0.674 0.188];[0 0.447 0.741];[0.635 0.078 0.184];[0.466 0.674 0.188]/2;[0 0.447 0.741]/1.5;[0.635 0.078 0.184]/1.5;[0.466 0.674 0.188]/3}; %blue, red, green

%cacam
figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
counter = 1;
plot(cacam02(:,1), cacam02(:,2)/10, styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
hold on
counter = counter +1;
plot(cacam10(:,1), cacam10(:,2)/10, styles{counter}, 'Color' , colors{counter});
counter = counter +1;
plot(cacam20(:,1), cacam20(:,2)/10, styles{counter}, 'Color' , colors{counter});
title('Calmodulin')
ylabel('Ca^{2+}CaM (\muM)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-cacam-allFreq.png');
saveas(gcf, pngfile);


%camkii
% newcolors = [0 0.4470 0.7410; 0 .5 .5];
% styleLine = ['-','--',':'];
%control volumes
figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
counter = 1;
for i = [1 7 13]%[1 5 9 13]
    plot(camkiip((steps*(i-1)+1):(steps*i),1), camkiip(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Bistable')
ylabel('CaMKIIp (\muM)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-bistable-topPSD-control-leaky-camkiip.png');
saveas(gcf, pngfile);

figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis left
% colororder(newcolors)
counter =1;
for i = [1 7 13]+3%[1 5 9 13]
    plot(camkiip((steps*(i-1)+1):(steps*i),1), camkiip(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Monostable')
ylabel('CaMKIIp (\muM)')
xlabel('Time (s)');
xlim([0 200])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-mono-topPSD-control-leaky-camkiip.png');
saveas(gcf, pngfile);


%pp1
newcolors = [0 0.4470 0.7410; 0 .5 .5];
styleLine = ['-','--',':'];
%control volumes
figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis left
% colororder(newcolors)
counter = 1;
for i = [1 7 13]%[1 5 9 13]
    plot(pp1((steps*(i-1)+1):(steps*i),1), pp1(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Bistable')
ylabel('PP1 (\muM)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-bistable-topPSD-control-leaky-pp1.png');
saveas(gcf, pngfile);

figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis left
% colororder(newcolors)
counter = 1;
for i = [1 7 13]+3%[1 5 9 13]
    plot(pp1((steps*(i-1)+1):(steps*i),1), pp1(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Monostable')
ylabel('PP1 (\muM)')
xlabel('Time (s)');
xlim([0 200])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-mono-topPSD-control-leaky-pp1.png');
saveas(gcf, pngfile);


%aint
newcolors = [0 0.4470 0.7410; 0 .5 .5];
styleLine = ['-','--',':'];
%control volumes
figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis left
% colororder(newcolors)
counter =1;
for i = [1 7 13]%[1 5 9 13]
    plot(aint((steps*(i-1)+1):(steps*i),1), aint(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Bistable')
ylabel('Aint (\muM)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-bistable-topPSD-control-leaky-aint.png');
saveas(gcf, pngfile);

figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
counter=1;
for i = [1 7 13]+3%[1 5 9 13]
    plot(aint((steps*(i-1)+1):(steps*i),1), aint(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Monostable')
ylabel('Aint (\muM)')
xlabel('Time (s)');
xlim([0 200])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-mono-topPSD-control-leaky-aint.png');
saveas(gcf, pngfile);

%amem
newcolors = [0 0.4470 0.7410; 0 .5 .5];
styleLine = ['-','--',':'];
%control volumes
figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% yyaxis left
% colororder(newcolors)
counter=1;
for i = [1 2 3 7 8 9 13 14 15]%[1 5 9 13]
    plot(amem((steps*(i-1)+1):(steps*i),1), amem(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Bistable')
ylabel('Amem (#/\mum^2)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz - top PSD','0.5 Hz - side PSD','0.5 Hz - neck base','0.1 Hz - top PSD','0.1 Hz - side PSD','0.1 Hz - neck base','0.05 Hz - top PSD','0.05 Hz - side PSD','0.05 Hz - neck base'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-bistable-allLocations-control-leaky-amem.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
counter=1;
for i = [1 2 3 7 8 9 13 14 15]+3%[1 5 9 13]
    plot(amem((steps*(i-1)+1):(steps*i),1), amem(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Monostable')
ylabel('Amem (#/\mum^2)')
xlabel('Time (s)');
xlim([0 200])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz - top PSD','0.5 Hz - side PSD','0.5 Hz - neck base','0.1 Hz - top PSD','0.1 Hz - side PSD','0.1 Hz - neck base','0.05 Hz - top PSD','0.05 Hz - side PSD','0.05 Hz - neck base'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-mono-allLocations-control-leaky-amem.png');
saveas(gcf, pngfile);

%abound
newcolors = [0 0.4470 0.7410; 0 .5 .5];
styleLine = ['-','--',':'];
%control volumes
figure
% colororder({'k','k'})
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
counter=1;
for i = [1 5 9]%[1 5 9 13]
    plot(abound((steps*(i-1)+1):(steps*i),1), abound(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Bistable')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
%ylim([1000 1650])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-bistable-topPSD-control-leaky-abound.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
counter=1;
for i = [1 5 9]+2%[1 5 9 13]
    plot(abound((steps*(i-1)+1):(steps*i),1), abound(((steps*(i-1)+1)):(steps*i),2), styles{counter}, 'Color' , colors{counter});%,styleLine(i), 'LineWidth', 4);%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{i})
    hold on
    counter = counter +1;
end
title('Thin Spine - Monostable')
ylabel('Bound AMPAR (#/\mum^2)')
xlabel('Time (s)');
xlim([0 200])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'0.5 Hz','0.1 Hz','0.05 Hz'},'Location','Southeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-mono-topPSD-control-leaky-abound.png');
saveas(gcf, pngfile);