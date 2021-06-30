% From Bertram and Sherman, Bulletin of Mathematical Biology 66:1313-1344 2004. 
% bursting with three slow variables

% units: V=mV; t=ms; g=pS; I=fA
% Reference:  Bertram and Sherman. 
% Calcium-based model for pancreatic islets
% Figure 13A...slow bursting generated with the interaction of 3 slow variables
% burst period is about 275 seconds
%
% Ica- calcium current
% Ik- delayed rectifier K+ current
% Ik(Ca)- Ca2+ dependent K+ current
% Ik(ATP)- nucleotide-sensitive K+ current
% c - cytosolic free Ca2+ concentration
% cer - ER Ca2+ concentration

% initial conditions
% init v=-80.0, c=0.10, n=0.01, cer=80, a=0.48

yinit = [-80.0; 0.10; 0.01; 80.0; 0.48];

tspan = [0 600000];

options = odeset('Stats','off');

[t, y] = ode15s(@burst, tspan, yinit, options);
%[t, y] = ode45(@burst, tspan, yinit, options);

subplot(5,1,1)
plot(t/1000, y(:,1))
xlabel('t (sec)');
ylabel('V (mV)');

subplot(5,1,2)
plot(t/1000, y(:,2))
xlabel('t (sec)');
ylabel('n');

subplot(5,1,3)
plot(t/1000, y(:,3))
xlabel('t (sec)');
ylabel('c (uM)');

subplot(5,1,4)
plot(t/1000, y(:,4))
xlabel('t (sec)');
ylabel('cer (uM)');

subplot(5,1,5)
plot(t/1000, y(:,5))
xlabel('t (sec)');
ylabel('a');




%=====================================================
function dydt = burst(t,y)

% names for the variables:
v = y(1);
n = y(2);
c = y(3);
cer = y(4);
a = y(5);

dydt = zeros(5,1);

% default parameter values:

gca=1200; gkca=100; gk=3000;
vca=25; vk=-75; cm=5300;
taun=16; alpha=4.5e-6;
fcyt=0.01; kpmca=0.2; kd=0.3;
vn=-16; vm=-20; sn=5; sm=12;
kserca=0.4; dact=0.35; dinact=0.4;
fer=0.01; pleak=0.0005; dip3=0.5; vcytver=5;
ip3=0; gkatp=500; sa=0.1; r=0.14; taua=300000;
epser=1; freezeatp=0; astar=0.46;

% parameters that vary by simulation type:

simtype = 'atpslow';

switch simtype
    case 'basic' % figure 1
       freezeatp=1; epser=0; astar=0.46; gkca=300; fcyt=0.01;
    case 'basicmedium'
        freezeatp=1; epser=0; astar=0.46; gkca=300; fcyt=0.0005;
    case 'erfast'
        freezeatp=1; epser=1; gkca=900; astar=0.455; fcyt=0.01;
    case 'ermedium'
        freezeatp=1; epser=1; gkca=700; astar=0.46; fcyt=0.01;
    case 'erslow'
        freezeatp=1; epser=1; gkca=300; astar=0.46; fcyt=0.01;
    case 'atpfast'
        freezeatp=0; epser=1; gkca=1000; fcyt=0.01;
    case 'atpmedium'
        freezeatp=0; epser=1; gkca=700; fcyt=0.01;
    case 'atpslow' % Figure 13
        freezeatp=0; epser=1; gkca=100; fcyt=0.01;        
end


% activation functions for plasma membrane currents:
minf=1.0/(1.0+exp((vm - v)/sm));
ninf=1.0/(1.0+exp((vn - v)/sn));
ainf=1.0/(1.0+exp((r - c)/sa));
% w = fraction of K(Ca) channels activated by cytosolic Ca2+:
w=c^5/(c^5 + kd^5);


% ionic currents
ica = gca*minf*(v - vca);
ik = gk*n*(v - vk);
ikca = gkca*w*(v - vk);
ikatp = gkatp*a*(v - vk);

%flux of Ca2+ through the membrane
jmem = -(alpha*ica + kpmca*c);

%Ca2+ influx into the ER via SERCA 
jserca = kserca*c;

%efflux out of the ER has two components
% 1. Ca2+ leak proportional to gradient between Ca2+ and ER:
jleak = pleak*(cer-c);

% 2. Ca2+ efflux through the IP3R
% fraction of open IP3R
oinf = (c/(dact+c))*(ip3/(dip3+ip3))*(dinact/(dinact+c));
jip3 = oinf*(cer-c);

%net Ca2+ efflux from the ER
jer = jleak + jip3 - jserca;

%differential equations
dydt(1) = -(ica + ik + ikca + ikatp)/cm;
dydt(2) = (ninf - n)/taun;
dydt(3) = fcyt*(jmem + epser*jer);
dydt(4) = -epser*fer*vcytver*jer;
dydt(5) = (1 - freezeatp)*(ainf - a)/taua + freezeatp*(astar - a);

end
