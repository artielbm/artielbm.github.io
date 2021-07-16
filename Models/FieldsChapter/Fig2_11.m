% This file produces Fig. 2.11 in:
% L. S. Satin, M. Watts, and A. Sherman. 2020. An introduction to beta cell electrophysiology and modeling, in Diabetes System Biology: Quantitative methods for understanding beta-cell dynamics and function, A. Khadra, editor. IOP Publishing, Bristol, UK, pp. 2-1 - 2-46, doi: https://iopscience.iop.org/book/978-0-7503-3739-7.
%
% Adapted from Bertram and Sherman, Bull. Math. Biol., 66:1313-1344, 2004.

% Variables:
%    v -- voltage
%    n -- activation variable for a delayed rectifier
%    c -- free cytosolic calcium concentration
%    a -- fraction of activated KATP channels
%    cer -- concentration of free calcium in the endoplasmic reticulum

% Units: conductances in pS; currents in fA; Ca concentrations in uM; time in ms


yinit = [-71.3; 1.57e-05; 0.036; 28.59; 0.86];

tspan = [0 240000];

options = odeset('Stats','off');

[t, y] = ode15s(@burst, tspan, yinit, options);

subplot(2,1,1)
plot(t/1000, y(:,1))
xlabel('t (sec)');
ylabel('V (mV)');

subplot(2,1,2)
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

% conductances

% r stepped with glucose
% gkatp stepped with tolbutamide:

simtype = 'tolb'; % Panel A

switch simtype 
	case 'gluc'
		gkatp0=500; gkatp1=500; gkatp2=500;
		r0=0; r1=0.11; r2=0.22;
		t1=80000; t2=160000;
	case 'tolb'
		gkatp0=500; gkatp1=225; gkatp2=225;
		r0=0; r1=0.0; r2=0.0;
		t1=120000; t2=1e6; % t2 is a dummy param, never reached
end

gkatpbar = gkatp0 + (t > t1)*(gkatp1 - gkatp0) + (t > t2)*(gkatp2 - gkatp1);
r = r0 + (t > t1)*(r1 - r0) + (t > t2)*(r2 - r1);


% Ikca (gkca =  800 for fast, 700 for medium, 200 for slow)
gkca=200;

kserca=0.4;

% Ca parameters  (sigmav=cyt volume/ER volume)
sigmav=5; kc=0.2;

% Ik
vn=-16; vk=-75; taun=20; gk=3000; sn=5;
% Ica
vca=25; gca=1200;
vm=-20; sm=12;
% Ikca
kd=0.3;
% Miscellaneous
lambda=1.25;
cm=5300;
% Calcium Handling
f=0.01; fer=0.01;
alpha=4.50e-6;
% Calcium Handling: ER
perl=0.0005; sa=0.02; taua=30000;

% Activation variables
ninf = 1/(1+exp((vn-v)/sn));
minf = 1/(1+exp((vm-v)/sm));
ainf = 1/(1+exp((r-c)/sa));
omega = 1/(1+(kd/c)^5);

% Ionic currents
ica = gca*minf*(v-vca);
ikca = gkca*omega*(v-vk);
ikatp = gkatpbar*a*(v-vk);
ik = gk*n*(v-vk);

% ER functions
jerp = kserca*c;

% Ca fluxes
jmemtot = -(alpha*ica + kc*c);
jerleak = perl*(cer - c);
jertot = jerleak - jerp;

% Differential Equations

dydt(1) = (-ica - ik - ikatp  - ikca)/cm;
dydt(2) =  lambda*(ninf - n)/taun;
dydt(3) = f*(jertot + jmemtot);
dydt(4) = -fer*sigmav*jertot;
dydt(5) = (ainf-a)/taua; 

end