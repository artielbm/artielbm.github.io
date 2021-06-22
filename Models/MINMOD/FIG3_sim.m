
%%%%%% FIG. 3 Control 1

init=[90.68, 0, 4.55, 1153.70, -0.02788, 3.374, 0.2, 1, 29, 195.59]; % IC, sigma=964, si=0.2
odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.2; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.006;
odeparams.SG=0.0118; 
odeparams.Ib=15.787; 

options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t1,y1)IVGTT_ode(t1,y1,odeparams);
[~,y1] = ode15s(odefun,[0,14400],init,options);
init=y1(end,:);
init(2)=0; % set X=0 for IC
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.2; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.0012;
odeparams.SG=0.0118; 
odeparams.Ib=15.787; 



[t1,y1] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% FIG. 3 Large RRP 1
init=[90.68, 0, 4.55, 1153.70, -0.02788, 3.374, 0.2, 1, 29, 195.59]; % IC, sigma=964, si=0.2

odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.2; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.06;
odeparams.SG=0.0104; 
odeparams.Ib=20.61; 
 



options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t1_RRP,y1_RRP)IVGTT_ode(t1_RRP,y1_RRP,odeparams);
[~,y1_RRP] = ode15s(odefun,[0,14400],init,options);
init=y1_RRP(end,:);
init(2)=0;% set X=0 for IC
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.2; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.012;
odeparams.SG=0.0104; 
odeparams.Ib=20.61; 
 



[t1_RRP,y1_RRP] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%%% End of FIG. 3 Large RRP 1

%%%%%%%% FIG. 3 Control 2

init=[90.68, 0, 4.55, 1153.70, -0.02788, 1.687, 0.4, 1, 29, 195.59]; % IC, sigma=482, si=0.4
odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.4; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.006;
odeparams.SG=0.0118; 
odeparams.Ib=9.167; 
 



options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t2,y2)IVGTT_ode(t2,y2,odeparams);
[~,y2] = ode15s(odefun,[0,14400],init,options);
init=y2(end,:);
init(2)=0; % set X=0 for IC
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.4; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.0012;
odeparams.SG=0.0118; 

[t2,y2] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% FIG. 3 Large RRP 2

init=[90.68, 0, 4.55, 1153.70, -0.02788, 1.687, 0.4, 1, 29, 195.59]; % IC, sigma=482, si=0.4
odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.4; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.06;
odeparams.SG=0.0104; 
odeparams.Ib=11.54; 

options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t2_RRP,y2_RRP)IVGTT_ode(t2_RRP,y2_RRP,odeparams);
[~,y2_RRP] = ode15s(odefun,[0,14400],init,options);
init=y2_RRP(end,:);
init(2)=0;
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.4; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.012;
odeparams.SG=0.0104; 
odeparams.Ib=11.54; 




[t2_RRP,y2_RRP] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% End of FIG. 3 Large RRP 2

%%%%%%%% FIG. 3 Control 3
init=[90.68, 0, 4.55, 1153.70, -0.02788, 1.127, 0.6, 1, 29, 195.59]; % IC, sigma=322.6, si=0.6 

odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.6; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.006;
odeparams.SG=0.0118; 
odeparams.Ib=6.222; 
 



options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t3,y3)IVGTT_ode(t3,y3,odeparams);
[~,y3] = ode15s(odefun,[0,14400],init,options);
init=y3(end,:);
init(2)=0;
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.6; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.0012;
odeparams.SG=0.0118; 
odeparams.Ib=6.222; 



[t3,y3] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% FIG. 3 Large RRP 3

init=[90.68, 0, 4.55, 1153.70, -0.02788, 1.127, 0.6, 1, 29, 195.59]; % IC ,sigma=322.6, si=0.6
odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.6; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.06;
odeparams.SG=0.0104; 
odeparams.Ib=7.16; 



options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t3_RRP,y3_RRP)IVGTT_ode(t3_RRP,y3_RRP,odeparams);
[~,y3_RRP] = ode15s(odefun,[0,14400],init,options);
init=y3_RRP(end,:);
init(2)=0;
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.6; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.012;
odeparams.SG=0.0104; 
odeparams.Ib=7.16; 
 



[t3_RRP,y3_RRP] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% End of FIG. 3 Large RRP 3


%%%% FIG. 3 Control 4
ttime=[0:1:120];
init=[90.68, 0, 4.55, 1153.70, -0.02788, 0.843, 0.8, 1, 29, 195.59]; % IC ,sigma=241, si=0.8

odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.8; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.006;
odeparams.SG=0.0118; 
odeparams.Ib=4.5569; 




options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t4,y4)IVGTT_ode(t4,y4,odeparams);
[~,y4] = ode15s(odefun,[0,14400],init,options);
init=y4(end,:);
init(2)=0;
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.8; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.0012;
odeparams.SG=0.0118; 
odeparams.Ib=4.5569; 



[t4,y4] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% FIG. 3 Large RRP 4
init=[90.68, 0, 4.55, 1153.70, -0.02788, 0.843, 0.8, 1, 29, 195.59]; % IC,sigma=241, si=0.8

odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0;
odeparams.Iinj=0;



odeparams.tar_si=0.8; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.06;
odeparams.SG=0.0104; 
odeparams.Ib=4.5569; 




options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t4_RRP,y4_RRP)IVGTT_ode(t4_RRP,y4_RRP,odeparams);
[~,y4_RRP] = ode15s(odefun,[0,14400],init,options);
init=y4_RRP(end,:);
init(2)=0;
odeparams.IVGTT=1;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.8; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.012;
odeparams.SG=0.0104; 
odeparams.Ib=4.5569; 

%%%%init=[84.4, 0, 5.82, 1153.70, -0.039, 241, 0.8, 1, 64.39, 42.14]; % tmp IC 


[t4_RRP,y4_RRP] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);


%%%%% plot 


Dose=categorical({'Control','Large RRP'});
Dose = reordercats(Dose,{'Control','Large RRP'});

input_si=[1.388 2.776 4.1664 5.5552];  % input si, si=input_si*6.944 for unit conversion
MINMOD_si=[0.463 1.21 2.17 4.04];% estimated from MINMOD



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


IVGTT_I=subplot(1,2,1);

plot(ttime,interp1(t1,y1(:,3),ttime),'k--', 'linewidth',lw);
hold('on')
plot(ttime,interp1(t2,y2(:,3),ttime),'k:', 'linewidth',lw);
plot(ttime,interp1(t3,y3(:,3),ttime),'k-.', 'linewidth',lw);
plot(ttime,interp1(t4,y4(:,3),ttime),'k', 'linewidth',lw);

plot(ttime,interp1(t1_RRP,y1_RRP(:,3),ttime),'r--', 'linewidth',lw);
plot(ttime,interp1(t2_RRP,y2_RRP(:,3),ttime),'r:', 'linewidth',lw);
plot(ttime,interp1(t3_RRP,y3_RRP(:,3),ttime),'r-.', 'linewidth',lw);
plot(ttime,interp1(t4_RRP,y4_RRP(:,3),ttime),'r', 'linewidth',lw);
xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('I (\muU/ml)','fontsize', fs, 'fontname',fn);

lh=legend('Control 1','Control 2','Control 3','Control 4','Large RRP 1','Large RRP 2','Large RRP 3','Large RRP 4','location','northeast');
set(lh,'FontSize',8); 
legend('boxoff');
text(0,385,'A','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 350])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IVGTT_G=subplot(1,2,2);

plot(ttime,interp1(t1,y1(:,1),ttime),'k--', 'linewidth',lw);
hold('on')
plot(ttime,interp1(t2,y2(:,1),ttime),'k:', 'linewidth',lw);
plot(ttime,interp1(t3,y3(:,1),ttime),'k-.', 'linewidth',lw);
plot(ttime,interp1(t4,y4(:,1),ttime),'k', 'linewidth',lw);

plot(ttime,interp1(t1_RRP,y1_RRP(:,1),ttime),'r--', 'linewidth',lw);
plot(ttime,interp1(t2_RRP,y2_RRP(:,1),ttime),'r:', 'linewidth',lw);
plot(ttime,interp1(t3_RRP,y3_RRP(:,1),ttime),'r-.', 'linewidth',lw);
plot(ttime,interp1(t4_RRP,y4_RRP(:,1),ttime),'r', 'linewidth',lw);

xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('G (mg/dl)','fontsize', fs, 'fontname',fn);


text(0,330,'B','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 300])
 









