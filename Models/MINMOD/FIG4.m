
%%%% Fig. 4 Control
ttime=[0:1:240];
init=[90.68, 0, 4.55, 1153.70, -0.02788, 0.843, 0.8, 1, 29, 195.59]; % IC,sigma=241, si=0.8 

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


odefun=@(t1,y1)IVGTT_ode(t1,y1,odeparams);
[~,y1] = ode15s(odefun,[0,14400],init,options);
init=y1(end,:);
init(2)=0;% set X=0 for IC
odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=8400;
odeparams.Iinj=60000;

odeparams.tar_si=0.8; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.0012;
odeparams.SG=0.0118; 
odeparams.Ib=4.5569; 



[t1,y1] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);

%%%% Fig. 4 Large RRP
init=[90.68, 0, 4.55, 1153.70, -0.02788, 0.843, 0.8, 1, 29, 195.59]; % IC,sigma=241, si=0.8 

odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=1;
odeparams.Ginj=0; %G injection
odeparams.Iinj=0; % I injection



odeparams.tar_si=0.8; 
odeparams.GF_bar=5.7;  
odeparams.GF_b=0.57;
odeparams.r20=0.06;
odeparams.SG=0.0104; 
odeparams.Ib=4.5569; 




options= odeset('RelTol',1e-5);
tspan=[0,240];


odefun=@(t2,y2)IVGTT_ode(t2,y2,odeparams);
[~,y2] = ode15s(odefun,[0,14400],init,options);
init=y2(end,:);
init(2)=0;% set X=0 for IC
odeparams.IVGTT=0;
odeparams.OGTT=0;
odeparams.meal=0;
odeparams.Ginj=8370;
odeparams.Iinj=60000;

odeparams.tar_si=0.8; 
odeparams.GF_bar=0;  
odeparams.GF_b=0.285;
odeparams.r20=0.012;
odeparams.SG=0.0104; 
odeparams.Ib=4.5569; 


[t2,y2] = ode15s(@IVGTT_ode,tspan,init,options,odeparams);


%%%%% plot 


Dose=categorical({'Control','Large RRP'});
Dose = reordercats(Dose,{'Control','Large RRP'});



control_Ginf=8400.*150./(55*1440);  
large_RRP_Ginf=8370.*150./(55*1440);  
Dose_clamp_si=[control_Ginf./87.69 large_RRP_Ginf./89.79];


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

text(0,220,'A','fontsize',fpan,'fontweight','bold');
axis ([0 240 0 200])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IVGTT_G=subplot(2,2,2);

plot(ttime,interp1(t1,y1(:,1),ttime),'k', 'linewidth',lw);
hold('on')

plot(ttime,interp1(t2,y2(:,1),ttime),'r', 'linewidth',lw);
xlabel('time (min)','fontsize', fs, 'fontname',fn);
ylabel('G (mg/dl)','fontsize', fs, 'fontname',fn);


text(0,220,'B','fontsize',fpan,'fontweight','bold');
axis ([0 240 0 200])
 

IVGTT_Ginf=subplot(2,2,3);


plot(ttime,interp1(t1,control_Ginf.*y1(:,3)./87.69,ttime),'k', 'linewidth',lw);
hold('on')
%plot(time2,I2,'b', 'linewidth',lw);
plot(ttime,interp1(t2, large_RRP_Ginf.*y2(:,3)./89.79,ttime),'r', 'linewidth',lw);
%plot(time4,I4,'r', 'linewidth',lw);
%%%% 10% of the length of y axis
axis ([0 240 0 30])
text(0.5,33,'C','fontsize',fpan,'fontweight','bold');
ylabel('Ginf(mg/kg/min)','fontsize', fs, 'fontname',fn);
%%%%%%%%%%%%%%%%

IVGTT_clamp=subplot(2,2,4);

bar(Dose, Dose_clamp_si,'k')

text(0.5,0.33,'D','fontsize',fpan,'fontweight','bold');
ylim([0 0.3])
%ylabel('{S_I} (10^{-4}ml/\muU/min)','fontsize', fs, 'fontname',fn);
ylabel('Clamp S_I(mg/kg/\muU/ml/min)','fontsize', fs, 'fontname',fn);














