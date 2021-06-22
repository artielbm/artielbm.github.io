%%%%%% FIG. 8 Very Strong secretion = OGTT of FIG. 6 Very Strong Secretion

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
odeparams.IVGTT=0;
odeparams.OGTT=1;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.2; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.006;
odeparams.SG=0.0118; 
odeparams.Ib=15.787;



[t1,y1] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%%%%%% FIG. 8 Strong Secretion = OGTT of FIG. 6 Strong Secretion

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
odeparams.IVGTT=0;
odeparams.OGTT=1;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;

odeparams.tar_si=0.4; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.006;
odeparams.SG=0.0118; 
odeparams.Ib=9.167;



[t2,y2] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);


%%%% FIG. 8 Control  = OGTT of FIG. 6 Control

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
odeparams.IVGTT=0;
odeparams.OGTT=1;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;


odeparams.tar_si=0.8; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.006;
odeparams.SG=0.0118; 
odeparams.Ib=4.5569;



[t4,y4] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% FIG. 8 Large RRP = OGTT from FIG3 of Large RRP 4
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
odeparams.Ib=5.82;


options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t4_RRP,y4_RRP)IVGTT_ode(t4_RRP,y4_RRP,odeparams);
[~,y4_RRP] = ode15s(odefun,[0,14400],init,options);
init=y4_RRP(end,:);
init(2)=0;
odeparams.IVGTT=0;
odeparams.OGTT=1;
odeparams.meal=0;
odeparams.Ginj=0;
odeparams.Iinj=0;


odeparams.tar_si=0.8; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.06;
odeparams.SG=0.0104; 
odeparams.Ib=5.82;


%%%%init=[84.4, 0, 5.82, 1153.70, -0.039, 241, 0.8, 1, 64.39, 42.14]; % tmp IC 


[t4_RRP,y4_RRP] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);




%%%%% plot 

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

ttime=[0:20:120];

IVGTT_I=subplot(2,2,1);

plot(ttime,interp1(t4,y4(:,3),ttime),'k', 'linewidth',lw);
hold('on')
plot(ttime,interp1(t4_RRP,y4_RRP(:,3),ttime),'r', 'linewidth',lw);

xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('I (\muU/ml)','fontsize', fs, 'fontname',fn);
lh=legend('Control','Large RRP','location','northwest');
set(lh,'FontSize',8); 
legend('boxoff');

text(0,66,'A','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 60])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IVGTT_G=subplot(2,2,2);

plot(ttime,interp1(t4,y4(:,1),ttime),'k', 'linewidth',lw);
hold('on')
plot(ttime,interp1(t4_RRP,y4_RRP(:,1),ttime),'r', 'linewidth',lw);

xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('G (mg/dl)','fontsize', fs, 'fontname',fn);


text(0,176,'B','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 160])

%%% large sigma


IVGTT_I2=subplot(2,2,3);

plot(ttime,interp1(t1,y1(:,3),ttime),'g', 'linewidth',lw);
hold('on')
plot(ttime,interp1(t2,y2(:,3),ttime),'b', 'linewidth',lw);
plot(ttime,interp1(t4,y4(:,3),ttime),'k', 'linewidth',lw);
xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('I (\muU/ml)','fontsize', fs, 'fontname',fn);
lh=legend('Very Strong','Strong','Control','location','northwest');
set(lh,'FontSize',8); 
legend('boxoff');

text(0,275,'C','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 250])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IVGTT_G2=subplot(2,2,4);

plot(ttime,interp1(t1,y1(:,1),ttime),'g', 'linewidth',lw);
hold('on')
plot(ttime,interp1(t2,y2(:,1),ttime),'b', 'linewidth',lw);
plot(ttime,interp1(t4,y4(:,1),ttime),'k', 'linewidth',lw);

xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('G (mg/dl)','fontsize', fs, 'fontname',fn);


text(0,176,'D','fontsize',fpan,'fontweight','bold');
axis ([0 120 0 160]) 






