
%%%% Fig. 2 Control
ttime=[0:1:120];
init=[90.68, 0, 4.55, 1153.70, -0.02788, 241, 0.8, 1, 29, 195.59]; % IC,sigma=241, si=0.8 

odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.8; 
odeparams.GF_bar=0.02;  
odeparams.GF_b=0.002;
odeparams.r20=0.006;
odeparams.Eg0=17; 



options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t1,y1)IVGTT_ode(t1,y1,odeparams);
[~,y1] = ode15s(odefun,[0,14400],init,options);
init=y1(end,:);
init(2)=0;% set X=0 for IC
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.8; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.001;
odeparams.r20=0.0012;
odeparams.Eg0=17; 


[t1,y1] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% Fig. 2 Large RRP
init=[90.68, 0, 4.55, 1153.70, -0.02788, 241, 0.8, 1, 29, 195.59]; % IC,sigma=241, si=0.8 

odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.8; 
odeparams.GF_bar=0.02;  
odeparams.GF_b=0.002;
odeparams.r20=0.06;
odeparams.Eg0=15; 



options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t2,y2)IVGTT_ode(t2,y2,odeparams);
[~,y2] = ode15s(odefun,[0,14400],init,options);
init=y2(end,:);
init(2)=0;% set X=0 for IC
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.8; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.001;
odeparams.r20=0.012;
odeparams.Eg0=15; 

%%%%init=[84.4, 0, 5.82, 1153.70, -0.039, 241, 0.8, 1, 64.39, 42.14]; % tmp IC 


[t2,y2] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);


%%%%% plot 


Dose=categorical({'Control','Large RRP'});
Dose = reordercats(Dose,{'Control','Large RRP'});

Dose_si=[5.5552 5.5552];  % input si, si=0.8*6.944 for unit conversion
Dose_MINMOD_si=[7.24 4.04];% estimated from MINMOD



fs=12;
fs2=8;
fn='arial';
lw=1.5;
lw2=1.5;
lw3=0.75;
%%%%%%%%
fs10=10;
fpan=10;
t_f=60;


IVGTT_I=subplot(2,2,1);

plot(ttime,interp1(t1,y1(:,3),ttime),'k', 'linewidth',lw);
hold('on')
plot(ttime,interp1(t2,y2(:,3),ttime),'r', 'linewidth',lw);
xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('I (\muU/ml)','fontsize', fs, 'fontname',fn);
lh=legend('Control','Large RRP','location','northeast');
set(lh,'FontSize',8); 
legend('boxoff');

text(0,110,'A','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 100])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IVGTT_G=subplot(2,2,2);

plot(ttime,interp1(t1,y1(:,1),ttime),'k', 'linewidth',lw);
hold('on')

plot(ttime,interp1(t2,y2(:,1),ttime),'r', 'linewidth',lw);
xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('G (mg/dl)','fontsize', fs, 'fontname',fn);


text(0,330,'B','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 300])
 

IVGTT_si=subplot(2,2,3);

bar(Dose, Dose_si,'k')

%%%% 10% of the length of y axis

text(0.5,8.8,'C','fontsize',fpan,'fontweight','bold');
ylim([0 8])
ylabel('Input {S_I} (10^{-4}ml/\muU/min)','fontsize', fs, 'fontname',fn);

%%%%%%%%%%%%%%%%
IVGTT_MINMOD=subplot(2,2,4);

bar(Dose, Dose_MINMOD_si,'k')

text(0.5,8.8,'D','fontsize',fpan,'fontweight','bold');
ylim([0 8])
ylabel('{S_I} (10^{-4}ml/\muU/min)','fontsize', fs, 'fontname',fn);
















