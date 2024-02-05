
yinit = [-64.3581    0.0001  460.4832    0.0959  839.3863   60.1374  110.4577];
tspan = [0 900000]; % t in msec

[t y] = ode15s(@iom17, tspan, yinit);

plot(t/1000, y(:,4))
xlabel('t (sec)')
ylabel('Ca (\muM)')
%BigLabels

%===================================================================
function dydt = iom17(t,y)

% This ODE file defines a version of the Integrated Oscillator Model 
% originally published in: 
% 
% Pulsatile Basal Insulin Secretion is Driven by Glycolytic Oscillations
% P. A. Fletcher, I. Marinelli, R. Bertram, L. S. Satin, A. S. Sherman
% Physiology, 37. https://doi.org/10.1152/physiol.00044.2021 
%
%
% Also used with modifications in:
% "Ca2+ Release or Ca2+ Entry, that is the Question: What Governs Ca2+ Oscillations in Pancreatic Beta Cells?" 
% Patrick A. Fletcher, Ben Thompson, Chanté Liu, Richard Bertram, Leslie S. Satin, Arthur S. Sherman
%
% and:
%J. Corradi, B. Thompson, P. A. Fletcher, R. Bertram, A. S. Sherman, L. S. Satin. 2023. 
% KATP channel activity and slow oscillations in pancreatic beta cells are regulated by mitochondrial ATP production. 
% J. Physiol., 601(24):5655-5667, https://pubmed.ncbi.nlm.nih.gov/37983196/

dydt = zeros(7,1);

vserca = 0.125; %vserca = 0.35;

%pleak = 0.00015;
pleak = 0.000075;

G = 15; %G = 10

v = y(1);
n = y(2);
cer = y(3);
c = y(4);
adp = y(5);
f6p = y(6);
fbp = y(7);


%###########################
%       Ca2+ fluxes	       #
%###########################


vca=25;
gca=1000;
vm=-20; sm=12;
minf = 1/(1+exp((vm-v)/sm));
ica = gca*minf*(v-vca);

%######
% Isoc
% https://doi.org/10.1371/journal.pone.0069598  <-- Ks=50uM, nHill=4, taus=30s
% dynamics of activation here would be physiological...
vsoc=-20;
gsoc=0; %10;
ksoc=300;
osoc = ksoc^4/(ksoc^4 + cer^4);
Isoc = gsoc * osoc * (v-vsoc);


% Ca2+ fluxes across the plasma membrane
alpha=4.5e-6;
Jin = -alpha*(ica+Isoc);

% PMCA - Hill version
vpmca=0.042;
kpmca=0.1;
Jpmca = vpmca*c^2/(c^2+kpmca^2);


% SERCA - Hill version
kserca=0.2;
Jserca=vserca*c^2/(c^2+kserca^2);

% Ca2+ efflux through leak
Jleak = pleak*(cer-c) ;

Jmem = Jin - Jpmca;
Jer = Jserca - Jleak;

%#################################
%#        Metabolic Model       ##
%#################################


%#####################################
%# Adenosine phosphorylation states  # 
%#####################################
% assuming 2 conservation laws eliminates two variables:
% 1. atot=atp+adp+amp (adenosine is neither created nor destroyed, just changes phosphorylation states)
% 2. amp=adp^2/atp ( rapid equilibrium of the Adenylate kinase (myokinase) reaction: atp+amp <=> 2adp )

atot = 3000;
atp = 0.5*(atot-adp + sqrt(adp*atot)*sqrt(-2+atot/adp-3*adp/atot));
amp = adp^2/atp;

ratio = atp/adp;



%#####################################
%# PFK model  # 
%#####################################

% Glucokinase reaction rate 
vgk=0.005;
kgk=8.0;
ngk=1.7;
Jgk=vgk*G^ngk/(G^ngk+kgk^ngk);

% PFK reaction rate, Jpfk
k1=30.000;
k2=1.000;
k3=50000;
k4=1000.000;
famp=0.0200;
fatp=20.00;
ffbp=0.200;
fbt=20.00;
fmt=20.00;

% (alpha,beta,gamma,delta)
% (0,0,0,0)
weight1=1;
topa1=0;
bottom1=1;

% (0,0,0,1)
weight2=atp^2/k4;
topa2=topa1;
bottom2=bottom1+weight2;

% (0,0,1,0)
weight3=f6p^2/k3;
topa3=topa2+weight3;
bottom3=bottom2+weight3;

% (0,0,1,1)
weight4=(f6p*atp)^2/(fatp*k3*k4);
topa4=topa3+weight4;
bottom4=bottom3+weight4;

% (0,1,0,0)
weight5=fbp/k2;
topa5=topa4;
bottom5=bottom4+weight5;

% (0,1,0,1)
weight6=(fbp*atp^2)/(k2*k4*fbt);
topa6=topa5;
bottom6=bottom5+weight6;

% (0,1,1,0)
weight7=(fbp*f6p^2)/(k2*k3*ffbp);
topa7=topa6+weight7;
bottom7=bottom6+weight7;

% (0,1,1,1)
weight8=(fbp*f6p^2*atp^2)/(k2*k3*k4*ffbp*fbt*fatp);
topa8=topa7+weight8;
bottom8=bottom7+weight8;

% (1,0,0,0)
weight9=amp/k1;
topa9=topa8;
bottom9=bottom8+weight9;

% (1,0,0,1)
weight10=(amp*atp^2)/(k1*k4*fmt);
topa10=topa9;
bottom10=bottom9+weight10;

% (1,0,1,0)
weight11=(amp*f6p^2)/(k1*k3*famp);
topa11=topa10+weight11;
bottom11=bottom10+weight11;

% (1,0,1,1)
weight12=(amp*f6p^2*atp^2)/(k1*k3*k4*famp*fmt*fatp);
topa12=topa11+weight12;
bottom12=bottom11+weight12;

% (1,1,0,0)
weight13=(amp*fbp)/(k1*k2);
topa13=topa12;
bottom13=bottom12+weight13;

% (1,1,0,1)
weight14=(amp*fbp*atp^2)/(k1*k2*k4*fbt*fmt);
topa14=topa13;
bottom14=bottom13+weight14;

% (1,1,1,0) -- the most active state of the enzyme
weight15=(amp*fbp*f6p^2)/(k1*k2*k3*ffbp*famp);
topa15=topa14;
topb=weight15;
bottom15=bottom14+weight15;

% (1,1,1,1)
weight16=(amp*fbp*f6p^2*atp^2)/(k1*k2*k3*k4*ffbp*famp*fbt*fmt*fatp);
topa16=topa15+weight16;
bottom16=bottom15+weight16;

% Phosphofructokinase rate
kpfk=0.05;
vpfk=0.01;
Jpfk= vpfk*(topb + kpfk*topa16)/bottom16;

%#########
% Gapdh rate, Jgapdh
Jgapdh = sqrt(fbp);

%#########
% PDH reaction rate, Jpdh
vpdh=0.005;

% how to control nozzle? shift kCaPDH higher. for simplicity, just use c
kCaPDH=300;
kcam=400;
cam = kcam*c;
sinfty = cam/(cam + kCaPDH);

Jpdh = vpdh*sinfty*Jgapdh;

%####################################
%# ATP dynamics 
%####################################

%######
% basal and glucose-stimulated ADP phosphorylation rate
%par vg=2
%par kg=0.05
%y = vg*(Jpdh/(kg+Jpdh))

%alt: linearly boost JPDH to r's scale.
ky=20;
y = ky*Jpdh;

% Calcium inhibition of ATP production (Keizer-Magnus effect)
kkm=0;
cainh=1-kkm*c;

r=0.7;
freezeprod = 0; Jprod0 = 0;
vphos = exp( (r + y) * cainh);
Jprod = (1 - freezeprod)*vphos*adp + freezeprod*Jprod0;

%######
% ATP hydrolysis
vhyd=5;
vhydbas=0.8;
vhydtot=vhydbas + vhyd*(Jpmca + Jserca/2);
Jhyd = vhydtot*atp;


%#################################
%# Ionic currents               ##
%#################################

vk = -75;

%#######
% ICa - defined before metabolic section


%#######
% Ik
gk=2700;
vn=-16; sn=5; taun=20;
ninf = 1/(1+exp((vn-v)/sn));
ik = gk*n*(v-vk);

%#######
gkca = 50; 
%gkca=1500; % for fast
kd=0.3;
nkca=4;
qinf = c^nkca/(kd^nkca+c^nkca);
ikca = gkca*qinf*(v-vk);

%#######
%Ikatp
% - can simulated diazoxide by increasing ktt
gkatpbar=27000;
ktt=1;
kdd=17; ktd=26;
mgadp = 0.165*adp;
adp3m = 0.135*adp;
atp4m = 0.05*atp;
topo = 0.08*(1+2*mgadp/kdd) + 0.89*(mgadp/kdd)^2;
bottomo = (1+mgadp/kdd)^2 * (1+adp3m/ktd+atp4m/ktt);
katpo = topo/bottomo ;
ikatp = gkatpbar*katpo*(v-vk);




%###########################
%       Vector field	   #
%###########################
taua=300000;
fca=0.01;
sigmaer=30;
Cm=5300;

kgo=1;
kadp=1;

dydt(1) = -(ica + ik + ikca + ikatp + Isoc)/Cm; % V
dydt(2) = (ninf-n)/taun; % n
dydt(3) = fca*sigmaer*Jer; % cer
dydt(4) = fca*(Jmem - Jer); % c
dydt(5) = kadp*(Jhyd-Jprod)/taua; % adp
dydt(6) = kgo*0.3*(Jgk-Jpfk); % f6p
dydt(7) = kgo*(Jpfk-0.5*Jpdh); % fbp


end
