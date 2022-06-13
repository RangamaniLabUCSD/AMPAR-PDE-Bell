%%%plot control temporal for all species
%% from thin control spine

clear
close all
clc

%%all temporal species

pathname = fileparts('resultsAutoPrint/');

%Load thin control at 3 different locations; 
% 234 - top PSD, side PSD, bottom spine neck
%bistable and monostable
%All are 300s with steps 0.1
cacyto = load('controlAndTraffCases/temporal-time234-thin1-both-control-cacyto.txt');
cacam = load('controlAndTraffCases/temporal-time234-thin1-both-control-cacam.txt');
camng = load('controlAndTraffCases/temporal-time234-thin1-both-control-camng.txt');
camkiip = load('controlAndTraffCases/temporal-time234-thin1-both-control-camkiip.txt');
can = load('controlAndTraffCases/temporal-time234-thin1-both-control-can.txt');
i1 = load('controlAndTraffCases/temporal-time234-thin1-both-control-i1.txt');
pp1 = load('controlAndTraffCases/temporal-time234-thin1-both-control-pp1.txt');
aint = load('controlAndTraffCases/temporal-time234-thin1-both-control-aint.txt');
amem = load('controlAndTraffCases/temporal-time234-thin1-both-control-amem.txt');
psd95 = load('controlAndTraffCases/temporal-time23-thin1-both-control-psd95.txt');

% Indexes - bistable then monostable; location 2 and then 3/4
% 1,2,3 - bistable (top PSD, side PSD, bottom neck)
% 4,5,6 - monostable (top PSD, side PSD, bottom neck)

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



%geometry info - 05, 5, 15, thin then mush
%all vol
vols = [2.0327e-20 4.0655e-20 6.0982e-20 1.3706e-19 2.7413e-19 4.1119e-19]*1e18; %m3 then um3
%all SA
SAs = [4.3873e-13 6.9644e-13 9.1259e-13 1.6364e-12 2.5976e-12 3.4038e-12]*1e12; %m2 then um2
%all PSD
PSDs = [2.5332e-14 4.0212e-14 5.2693e-14 9.0549e-14 1.4374e-13 1.8835e-13]*1e12; %m2 then um2


% newcolors = [0 0.4470 0.7410; 0 .5 .5];
% styleLine = ['-','--',':'];
%control volumes
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
counter = 1;
for i = [1 4]%1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(cacyto((steps*(i-1)+1):(steps*i),1), cacyto(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('Ca^{2+}_{cyto} (\muM)')
xlabel('Time (s)');
xlim([0 5])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','Northeast')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-cacyto.png');
saveas(gcf, pngfile);

%cacam
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter=1;
for i = [1 4]%1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(cacam((steps*(i-1)+1):(steps*i),1), cacam(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('Ca^{2+}CaM (\muM)')
xlabel('Time (s)');
xlim([0 10])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','Northeast')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-cacam.png');
saveas(gcf, pngfile);

%camng
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter=1;
for i = [1 4]%1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(camng((steps*(i-1)+1):(steps*i),1), camng(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('CaMNg (\muM)')
xlabel('Time (s)');
xlim([0 10])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','East')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-camng.png');
saveas(gcf, pngfile);

%camkiip
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter=1;
for i = [1 4]%1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(camkiip((steps*(i-1)+1):(steps*i),1), camkiip(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('CaMKIIp (\muM)')
xlabel('Time (s)');
%xlim([0 5]) 
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','Northeast')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-camkiip.png');
saveas(gcf, pngfile);

%can
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter=1;
for i = [1 4]%1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(can((steps*(i-1)+1):(steps*i),1), can(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('CaN (\muM)')
xlabel('Time (s)');
%xlim([0 5]) 
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','Northeast')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-can.png');
saveas(gcf, pngfile);

%i1
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter=1;
for i = [1 4]%1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(i1((steps*(i-1)+1):(steps*i),1), i1(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('I1 (\muM)')
xlabel('Time (s)');
%xlim([0 5]) 
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','Northeast')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-i1.png');
saveas(gcf, pngfile);

%pp1
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter=1;
for i = [1 4]%1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(pp1((steps*(i-1)+1):(steps*i),1), pp1(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('PP1 (\muM)')
xlabel('Time (s)');
%xlim([0 5]) 
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','Northeast')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-pp1.png');
saveas(gcf, pngfile);

%aint
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter = 1;
for i = 1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(aint((steps*(i-1)+1):(steps*i),1), aint(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('Aint (\muM)')
xlabel('Time (s)');
%xlim([0 5]) 
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Bistable - side PSD','Bistable - neck base','Monostable - top PSD','Monostable - side PSD','Monostable - neck base'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-allLocations-control-aint.png');
saveas(gcf, pngfile);

%amem
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter=1;
for i = 1:6%[1 5 9 13]
    if i < 4
        markeri = 1;
    else
        markeri = 2;
    end
    plot(amem((steps*(i-1)+1):(steps*i),1), amem(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('Amem (#/\mum^2)')
xlabel('Time (s)');
%xlim([0 5]) 
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Bistable - side PSD','Bistable - neck base','Monostable - top PSD','Monostable - side PSD','Monostable - neck base'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-allLocations-control-amem.png');
saveas(gcf, pngfile);

%psd95
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
%colororder(newcolors)
counter = 1;
for i = [1 3]%1:4%[1 5 9 13]
    if i < 3
        markeri = 1;
    else
        markeri = 2;
    end
    plot(psd95((steps*(i-1)+1):(steps*i),1), psd95(((steps*(i-1)+1)):(steps*i),2),styles{counter}, 'Color' , colors{counter});%'MarkerSize', 2,'MarkerFaceColor',colors{6*(i)}, 'Color' , colors{counter})
    hold on
    counter = counter + 1;
end
title('Thin Spine')
ylabel('PSD95 (#/\mum^2)')
xlabel('Time (s)');
%xlim([0 5])
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
legend({'Bistable - top PSD','Monostable - top PSD'},'Location','Northeast')
%legend({'Bistable - top PSD','Bistable - side PSD','Monostable - top PSD','Monostable - side PSD'},'Location','Northeast')
set(gcf,'pos',[0 0 750 450])
pngfile = fullfile(pathname, 'temporal-thin1-both-topPSD-control-psd95.png');
saveas(gcf, pngfile);