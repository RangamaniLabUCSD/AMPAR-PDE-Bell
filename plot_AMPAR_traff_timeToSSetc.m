%try to find time to max, max value, SS, time to SS; time to half max


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
PeakMatrix = zeros(10,5,4); %pulling out peak, time to peak, time to SS
PeakTimeMatrix = zeros(10,5,4); 
HalfMatrix = zeros(10,5,4); %pulling out peak, time to peak, time to SS
HalfTimeMatrix = zeros(10,5,4); 
for i = [1 2 3 4 5] %5 different cases
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

        start = 1+steps*((j+4*(i-1))-1);
        endVal = steps*(j+4*(i-1));
        
        [PeakMatrix(1,i,j), PeakTimeMatrix(1,i,j)] = max(thin05Var(start:endVal,2));
    	[PeakMatrix(2,i,j), PeakTimeMatrix(2,i,j)] = max(thin075Var(start:endVal,2));
        [PeakMatrix(3,i,j), PeakTimeMatrix(3,i,j)] = max(thin1Var(start:endVal,2));
        [PeakMatrix(4,i,j), PeakTimeMatrix(4,i,j)] = max(thin125Var(start:endVal,2));
        [PeakMatrix(5,i,j), PeakTimeMatrix(5,i,j)] = max(thin15Var(start:endVal,2));
        [PeakMatrix(6,i,j), PeakTimeMatrix(6,i,j)] = max(mush05Var(start:endVal,2));
        [PeakMatrix(7,i,j), PeakTimeMatrix(7,i,j)] = max(mush075Var(start:endVal,2));
        [PeakMatrix(8,i,j), PeakTimeMatrix(8,i,j)] = max(mush1Var(start:endVal,2));
        [PeakMatrix(9,i,j), PeakTimeMatrix(9,i,j)] = max(mush125Var(start:endVal,2));
        [PeakMatrix(10,i,j), PeakTimeMatrix(10,i,j)] = max(mush15Var(start:endVal,2));
        
        
        if i == 2
            for geo = 1:10
                HalfMatrix(geo,i,j) = ICAB(geo);
                HalfTimeMatrix(geo,i,j) = 0;
            end
        else
            HalfMatrix(1,i,j) = (PeakMatrix(1,i,j)-ICAB(1))/2;
            Halfway = (thin05Var(start,2)+HalfMatrix(1,i,j));
            HalfTimeMatrix(1,i,j) = find(thin05Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(2,i,j) = (PeakMatrix(2,i,j)-ICAB(2))/2;
            Halfway = (thin075Var(start,2)+HalfMatrix(2,i,j));
            HalfTimeMatrix(2,i,j) = find(thin075Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(3,i,j) = (PeakMatrix(3,i,j)-ICAB(3))/2;
            Halfway = (thin1Var(start,2)+HalfMatrix(3,i,j));
            HalfTimeMatrix(3,i,j) = find(thin1Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(4,i,j) = (PeakMatrix(4,i,j)-ICAB(4))/2;
            Halfway = (thin125Var(start,2)+HalfMatrix(4,i,j));
            HalfTimeMatrix(4,i,j) = find(thin125Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(5,i,j) = (PeakMatrix(5,i,j)-ICAB(5))/2;
            Halfway = (thin15Var(start,2)+HalfMatrix(5,i,j));
            HalfTimeMatrix(5,i,j) = find(thin15Var(start:endVal,2) >= Halfway, 1, 'first');
            
            HalfMatrix(6,i,j) = (PeakMatrix(6,i,j)-ICAB(6))/2;
            Halfway = (mush05Var(start,2)+HalfMatrix(6,i,j));
            HalfTimeMatrix(6,i,j) = find(mush05Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(7,i,j) = (PeakMatrix(7,i,j)-ICAB(7))/2;
            Halfway = (mush075Var(start,2)+HalfMatrix(7,i,j));
            HalfTimeMatrix(7,i,j) = find(mush075Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(8,i,j) = (PeakMatrix(8,i,j)-ICAB(8))/2;
            Halfway = (mush1Var(start,2)+HalfMatrix(8,i,j));
            HalfTimeMatrix(8,i,j) = find(mush1Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(9,i,j) = (PeakMatrix(9,i,j)-ICAB(9))/2;
            Halfway = (mush125Var(start,2)+HalfMatrix(9,i,j));
            HalfTimeMatrix(9,i,j) = find(mush125Var(start:endVal,2) >= Halfway, 1, 'first');
            HalfMatrix(10,i,j) = (PeakMatrix(10,i,j)-ICAB(10))/2;
            Halfway = (mush15Var(start,2)+HalfMatrix(10,i,j));
            HalfTimeMatrix(10,i,j) = find(mush15Var(start:endVal,2) >= Halfway, 1, 'first');
        
        end

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


Thin1Bi = [t(HalfTimeMatrix(3,1,1)) 0 t(HalfTimeMatrix(3,3,1)) t(HalfTimeMatrix(3,4,1)) t(HalfTimeMatrix(3,5,1))];

Thin1Mo = [t(HalfTimeMatrix(3,1,3)) 0 t(HalfTimeMatrix(3,3,3)) t(HalfTimeMatrix(3,4,3)) t(HalfTimeMatrix(3,5,3))];



Mush1Bi = [t(HalfTimeMatrix(8,1,1)) 0 t(HalfTimeMatrix(8,3,1)) t(HalfTimeMatrix(8,4,1)) t(HalfTimeMatrix(8,5,1))];

Mush1Mo = [t(HalfTimeMatrix(8,1,3)) 0 t(HalfTimeMatrix(8,3,3)) t(HalfTimeMatrix(8,4,3)) t(HalfTimeMatrix(8,5,3))];