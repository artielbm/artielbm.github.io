% Produces Fig. 8B.  To see Fig. 8D, plot gkatp vs. tmin.

% Model originally published in Biophysical Journal, 92:1544-1555, 2007.

% Parameter vlaues for various behaviors:
%
% {Jgk=0.4, gkatpbar=16000, gkca=300, p21=0.04, p23=0.01} compound
% {Jgk=0.4, gkatpbar=12000, gkca=100, p21=0.04, p23=0.01} slow
% {Jgk=0.7, gkatpbar=16000, gkca=300, p21=0.04, p23=0.01} fast

% Initial Conditions

function mitophan

v0=-66.90660815535639
n0=3.785838489033591e-05
c0=0.1598647106220047
cer0=372.2919312521756
g6p0=56.77606487453917
fbp0=1445.363935125425

% Mito variables (MGP) -  in mM

ADPM0=10.58512442405301
NADHm0=3.117055470159684

% Mito Ca - in uM
Cam0=0.1594619169920177

% mV (cyto-mito)
Psim0=165.9127574197201


% Cytosolic ADP concentration - in uM
adp0=879.1601045158308


yinit = [v0; n0; c0; cer0; g6p0; fbp0; ADPM0; NADHm0; Cam0; Psim0; adp0]

tspan = [0 240000]

% options = odeset('Stats','off', 'OutputFcn', @odeplot, 'OutputSel', [1]);
options = odeset('Stats','off');

tic
[t,y] = ode15s(@mitoeqns,tspan,yinit,options);
toc

figure

subplot(211)
plot(t/1000, y(:,1))
xlabel 't (sec)'
ylabel '(V (mV)'

subplot(212)
plot(t/1000, y(:,11))
xlabel 't (sec)'
ylabel '(ADP (uM)'


% ------------------------------------------------------
% Differential equations

function dydt = mitoeqns(t, y)

% Give names to the variables

dydt = zeros(11,1);

v = y(1); n = y(2); c = y(3); cer=y(4); g6p=y(5); fbp=y(6); ADPm=y(7);
NADHm=y(8); Cam=y(9); Psim=y(10); adp=y(11);

% Expressions

% Plasma membrane capacitance
cm=5300;

% Ikca
gkca=100;
kd=0.5;

% Ikatp
gkatpbar=18000;

% ICa
gca=1000;
vca=25;
vm=-16; sm=12;
minf = 1/(1+exp((vm-v)/sm));
Ica = gca*minf*(v-vca);

% Ik
vk=-75; gk=2700;
vn=-16; sn=5; taun=20;
ninf = 1/(1+exp((vn-v)/sn));
Ik = gk*n*(v-vk);
Ikca = gkca/(1+(kd/c)^2)*(v-vk);

% IKATP
% Dissociation constants (from Magnus and Keizer, 1998)
kdd=17; ktd=26; ktt=1;
Dz=0;

%##### Cytosolic nucleotide concentrations #####
khyd=0.00005; JhydSS=0.00005;
amp=500; atot=2500;
atp = atot-adp;
Jhyd=(khyd*c+JhydSS)*atp ;
mgadp = 0.165*adp;
adp3m = 0.135*adp;
atp4m = 0.05*atp;
RATc = atp/adp;

% KATP channel open probability (from Magnus and Keizer, 1998)
topo = 0.08*(1+2*mgadp/kdd) + 0.89*(mgadp/kdd)^2;
bottomo = (1+mgadp/kdd)^2 * (1+adp3m/ktd+atp4m/ktt);
katpo = (topo/bottomo);
Ikatp = (1-Dz)*gkatpbar*katpo*(v-vk)+Dz*gkatpbar*(v-vk);

% ----------------------------------------------------------------
%##### Cytosolic Calcium Handling ######
% sigmav=cyt volume/ER volume 
alpha=4.50e-6; fcyt=0.01; fer=0.01;
kpmca=0.15;
per=0.0002; kserca=0.4; lambdaer=1; epser=1;
sigmav=31;
cbas=0.05;

% Ca fluxes
Jmem = -(alpha*Ica + kpmca*(c-cbas));
Jserca = kserca*c;
Jleak = per*(cer - c);
Jer = epser*(Jleak - Jserca)/lambdaer;

% -----------------------------------------------------
% Glycolytic components

% g6p -- glucose 6-phosphate
% fbp -- fructose 1,6-bisphosphate

% Parameters
%  Jgk--glucokinase rate (uM/s)
%  Jgk_ms--glucokinase rate (uM/ms)
%  atot--total adenine nucleotide concentration (micromolar)
%  k1--Kd for AMP binding
%  k2--Kd for FBP binding
%  k3--Kd for F6P binding
%  k4--Kd for ATP binding
%  f41--ATP inhibition by weakening binding of AMP
%  f42--ATP inhibition by weakening binding of FBP
%  f43--ATP inhibition by weakening binding of F6P
%  f23--FBP activation by tightening binding of F6P
%  f13--AMP activation by tightening binding of F6P
%  lambda--ratio of PFK activity in inactivated to non-inactivated form

%  famp,etc--Kd amplification factors for heterotropic binding
%  Jgpdh--glyceraldehyde phosphate dehydrogenase rate (uM/ms)
%  kappa--converts from s to ms.
%  Jgpdh_bas--basal GPDH produced by PFK that is not M-type.

% Glycolytic parameters
phigk=0.3; KGPDH=0.0;
Jgk=0.18;
k4=1000;
k1=30; k2=1; k3=50000;
f13=0.02; f43=20; f23=0.2; f42=20; f41=20; lambda=0.06;
VmaxPFK=5;
kappa=0.001;
Jgpdh_bas=0.002;

% Glycolytic expressions
f6p = phigk*g6p;
Jgpdh = KGPDH*sqrt(fbp) ;
Jgk_ms=kappa*Jgk;
% aux JGPDH=Jgpdh 

% Iterative calculation of PFK
% alpha=1 -- AMP bound
% beta=1 -- FBP bound
% gamma=1 -- F6P bound
% delta=1 -- ATP bound

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
weight4=(f6p*atp)^2/(f43*k3*k4);
topa4=topa3+weight4;
bottom4=bottom3+weight4;

% (0,1,0,0)
weight5=fbp/k2;
topa5=topa4;
bottom5=bottom4+weight5;

% (0,1,0,1)
weight6=(fbp*atp^2)/(k2*k4*f42);
topa6=topa5;
bottom6=bottom5+weight6;

% (0,1,1,0)
weight7=(fbp*f6p^2)/(k2*k3*f23);
topa7=topa6+weight7;
bottom7=bottom6+weight7;

% (0,1,1,1)
weight8=(fbp*f6p^2*atp^2)/(k2*k3*k4*f23*f42*f43);
topa8=topa7+weight8;
bottom8=bottom7+weight8;

% (1,0,0,0)
weight9=amp/k1;
topa9=topa8;
bottom9=bottom8+weight9;

% (1,0,0,1)
weight10=(amp*atp^2)/(k1*k4*f41);
topa10=topa9;
bottom10=bottom9+weight10;

% (1,0,1,0)
weight11=(amp*f6p^2)/(k1*k3*f13);
topa11=topa10+weight11;
bottom11=bottom10+weight11;

% (1,0,1,1)
weight12=(amp*f6p^2*atp^2)/(k1*k3*k4*f13*f41*f43);
topa12=topa11+weight12;
bottom12=bottom11+weight12;

% (1,1,0,0)
weight13=(amp*fbp)/(k1*k2);
topa13=topa12;
bottom13=bottom12+weight13;

% (1,1,0,1)
weight14=(amp*fbp*atp^2)/(k1*k2*k4*f42*f41);
topa14=topa13;
bottom14=bottom13+weight14;

% (1,1,1,0) -- the most active state of the enzyme
weight15=(amp*fbp*f6p^2)/(k1*k2*k3*f23*f13);
topa15=topa14;
topb=weight15;
bottom15=bottom14+weight15;

% (1,1,1,1)
weight16=(amp*fbp*f6p^2*atp^2)/(k1*k2*k3*k4*f23*f13*f42*f41*f43);
topa16=topa15+weight16;
bottom16=bottom15+weight16;


% Phosphofructokinase rate 
pfk=(lambda*VmaxPFK*topa16 + VmaxPFK*topb)/bottom16;
pfk_ms=kappa*pfk;

% ----------------------------------------------------------------
%##### Mitochondrial Ca2+ handling #######
% delta transforms  (mito volume) -> (cyto volume)/ms
% gamma transforms uM to mM.


fmito=0.01;
delta=3.9/53.2;
gamma=0.001;

%## Uniporter [uM/ms]
p21=0.04; p22=1.1;
Juni=(p21*Psim-p22)*c^2;

%## Na/Ca exchanger [uM/ms]
p23=0.01;
p24=0.016;
JNaCa=(p23/c)*Cam*exp(p24*Psim);

% [uM/ms] , mito -> cyto
Jmito=JNaCa-Juni;

% ----------------------------------------------------------------
%##### Mitochondrial fluxes (JTB, 243:575, 2006) ######

% Mitochondrial adenine and pyridine nucleotide conservation. All in [mM].

Amtot=15; NADmtot=10;
NADm=NADmtot-NADHm;
ATPm=Amtot-ADPm;
RATm=ATPm/ADPm;

% Pyruvate dehydrogenase (PDH) (uM/ms)
p1=400; p2=1; p3=0.01;
Jpdh=(p1/(p2+NADHm/NADm))*(Cam/(p3+Cam))*(Jgpdh+Jgpdh_bas);

% ----------------------------------------------------------------
%##### Mitochondrial membrane components ######
% Inner membrane capacitance
Cmito=1.8;

% H+ leakage through mitochondrial inner membrane (uM/ms)
p17=0.002; p18=-0.03;
JHleak=p17*Psim+p18;

% Respiration (uM/ms)
p4=0.6;
p5=0.1; p6=177; p7=5;
MM1=p4*NADHm/(p5+NADHm);
JO=MM1/(1+exp((Psim-p6)/p7));

% Proton pumping due to respiration  (uM/ms)
p8=7; p9=0.1; p10=177; p11=5;
MM2 = p8*NADHm/(p9+NADHm);
JHres = MM2/(1+exp((Psim-p10)/p11));

% Phosphorylation. In uM/ms.
p13=10; p14=190; p15=8.5; p16=35;
b2=(p16*p13)/(p13+ATPm);
JF1F0=b2/(1.0+exp((p14-Psim)/p15));

% Proton flux due to ATPase (uM/ms)
JHatp=3*JF1F0;

% ADP/ATP translocator. In uM/ms.
p19 = 0.35; p20=2;
FRT = 96480/(310.16*8315);
JANT = p19*(RATm/(RATm+p20))/exp(-0.5*FRT*Psim);

dydt(1) = -(Ik + Ica + Ikca + Ikatp)/cm;
dydt(2) = (ninf-n)/taun;
dydt(3) = fcyt*(Jmem + Jer + delta*Jmito);
dydt(4) = -fer*sigmav*Jer;
dydt(5) = Jgk_ms - pfk_ms;
dydt(6) = pfk_ms - 0.5*Jgpdh;

%## Mitochondria 
dydt(7) = gamma*(JANT-JF1F0);
dydt(8) = gamma*(Jpdh-JO);
dydt(9) = -fmito*Jmito;

% Mitochondrial membrane potential [mV] (cyto-mito)
dydt(10) = (JHres-JHatp-JANT-JHleak-JNaCa-2*Juni)/Cmito;

% Cytosolic ADP concentration
dydt(11) = -delta*JANT + Jhyd;

%@ meth=cvode, toler=1.0e-9, atoler=1.0e-9, dt=10.0, total=600000,
%@ maxstor=100000,bounds=10000000, xp=tmin, yp=v
%@ xlo=0, xhi=10, ylo=-80, yhi=-20, bell=off

%aux tsec=t/1000
%aux tmin=t/60000
%aux Atp=atp/1000
%aux ratio=atp/adp
%aux gkatp=gkatpbar*katpo
