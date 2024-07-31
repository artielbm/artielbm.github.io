clear

% Artie 07/31/24
% a cleaner version of the FIG1.m file originally posted on Github
% no structure that grows every iteration to store the OGTT data
% doesn't write out the data and read it back in to plot

total_t=2628000; % 5 years: 1440*365*5
OGTT_period=7200; % 5 days
nPeriods=total_t/OGTT_period; % number of 5-day blocks
T0 = 0:OGTT_period:total_t;

%%%% NOTE THAT odeparams.HGP_no_si=1 and  HGP_no_si=1 are used only for HGP test with or
%%%% w/o si dependency, otherwise ALWAYS 0
odeparams.HGP_no_si=0;
HGP_no_si=0; % for recomputing HGP in full_run.m


odeparams.BW=75;
odeparams.mealbar=11.055; 
outfile='FIG1.xlsx';
odeparams.k=0.4861;

odeparams.meal=1;
odeparams.OGTT=0;
odeparams.IVGTT=0;

odeparams.r20=0.006;
odeparams.tar_si=0.1; %FIG1
odeparams.tau_si=360000; 
odeparams.tar_hepasi=0.85;%FIG1
odeparams.tau_hepasi=360000;
odeparams.Gs=100;
odeparams.ISRI_bar=0.5259; % beta-function defect for all pathways, default:1.4

    
odeparams.tar_si=0.1; %FIG1
odeparams.tau_si=360000; 
odeparams.tar_hepasi=0.85; %FIG1
odeparams.tau_sigma=359856;
odeparams.tau_hepasi=360000;
odeparams.Gs=100;
odeparams.ISRI_bar=0.5259; % beta-function defect for all pathways, default:1.4


init=[78.59, 5.63, 1533.91, -0.07663, 1, 0.8, 1, 60.24, 443.39];


options= odeset('RelTol',1e-5);
dt=10;
tspan=[0:dt:OGTT_period];
tspanOGTT=[0:1:120];

% save OGTT data for final longitudinal plot    
OGTT_G = zeros(nPeriods+1, 5); % save 0, 30, 60, 90, 120
OGTT_I = zeros(nPeriods+1, 5);
b = zeros(nPeriods+1, 1);
gamma = zeros(nPeriods+1, 1);
sigma = zeros(nPeriods+1, 1);
hepasi = zeros(nPeriods+1, 1);

tspecial = [0 30 60 90 120];


%%%% DO an OGTT at baseline

odeparams.meal=0;
odeparams.OGTT=1;
[t1,y1]=ode15s(@pathway,tspanOGTT,init,options,odeparams);

OGTT_G(1,:) = interp1(t1, y1(:,1), tspecial);
OGTT_I(1,:) = interp1(t1, y1(:,2), tspecial);
b(1)=init(3);
gamma(1)=init(4);
sigma(1)=init(5);
si(1)=init(6);
hepasi(1)=init(7);  

%%%%%%%%%%%%%
%%%% Beginning of longitudinal simulations and OGTTs

disp('OGTTs calculated every 5 days for 5 years, 365 total')
tic
for i=1:nPeriods

   %inter-OGTTs
    if(mod(i, 10) == 0)
        disp(num2str(i))
    end
    odeparams.meal=1;
    odeparams.OGTT=0;
    
    [thepa,y]=ode15s(@pathway,tspan,init,options,odeparams);
    %save final value of current segment of meal simulations
    init=y(end,:);

    %OGTT at the end of longitudinal simulations
    %switch from meal to OGTT:
    odeparams.meal=0;
    odeparams.OGTT=1;
    [thepa,y]=ode15s(@pathway,tspanOGTT,init,options,odeparams);

    OGTT_G(i+1,:) = interp1(thepa, y(:,1), tspecial);
    OGTT_I(i+1,:) = interp1(thepa, y(:,2), tspecial);
    b(i+1)=init(3);
    gamma(i+1)=init(4);
    sigma(i+1)=init(5);
    si(i+1)=init(6);
    hepasi(i+1)=init(7);  
       
end
disp(num2str(i))
disp('End of Simulations')
toc

%%%%% End of Simulations%%%

%%% write data

long_OGTT=[T0',OGTT_G, OGTT_I, b, gamma, sigma, si', hepasi];
NGT_IGT_CGI_T2D = array2table(long_OGTT, 'VariableNAMES', {'t','G0','G30','G60','G90','G120','I0','I30','I60','I90','I120','b','gamma','sigma','si','hepasi'});
writetable(NGT_IGT_CGI_T2D, outfile) 

f1 = figure(1);
f1.Position = [1338         455         560         420];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fs=12;
fs2=8;
fn='arial';
lw=1.5;
lw2=1.5;
lw3=0.5;
%%%%%%%%


fpan=10;
title('FIG. 1', 'linewidth', 15);

%%%%%%%%%%%%%%%%%%%%%

tsi=subplot(3,2,1);

%%% t rescaled by 365*1440 to convert to years in all figs below

plot(NGT_IGT_CGI_T2D.t/(365*1440),NGT_IGT_CGI_T2D.si.*6.9444,'k', 'linewidth',lw);
ylabel('{S_I} (10^{-4}ml/\muU/min)','fontsize', fs, 'fontname',fn);


text(0,1.1,'A','fontsize',fpan,'fontweight','bold', 'Units','normalized');
axis ([0 5 0 6])
%%%%%%%%%%%%%%%%%%%%%%%%%%
thepa=subplot(3,2,2);

plot(NGT_IGT_CGI_T2D.t/(365*1440),NGT_IGT_CGI_T2D.hepasi,'k', 'linewidth',lw);
ylabel('{hepa_{S_I}}','fontsize', fs, 'fontname',fn);
text(0,1.1,'B','fontsize',fpan,'fontweight','bold', 'Units','normalized');
axis ([0 5 0 1.5])

%%%%%%%%%%%%%%%%%%%%%%%%

tG=subplot(3,2,3);


plot(NGT_IGT_CGI_T2D.t./(365*1440),NGT_IGT_CGI_T2D.G0,'-k', 'linewidth',lw);
hold('on')
plot(NGT_IGT_CGI_T2D.t/(365*1440),NGT_IGT_CGI_T2D.G120,'-k', 'linewidth',lw);

tIGT=1;
tCGI=1.92;
tT2D=3.00;

th_IGT=140;
th_CGI=100;
th_T2D=200;

plot([tIGT tIGT],[0 th_IGT],'k','linewidth',lw3);
plot([tCGI tCGI],[0 th_CGI],'k','linewidth',lw3);
plot([tT2D tT2D],[0 th_T2D],'k','linewidth',lw3);

%%% longitudinal location at t=0 (NGT1), t=1*319680 (NGT2), t=2*319680 (IGT), t=4*319680 (CGI), t=7*319680


plot(0,0,'.k','MarkerSize',15);
plot(0.685,0,'.k','MarkerSize',15);
plot(1.216, 0, '.k', 'MarkerSize',15);
plot(2.432, 0, '.k', 'MarkerSize',15);
plot(4.256, 0, '.k', 'MarkerSize',15);

ylabel('{Glucose} (mg/dl)','fontsize', fs, 'fontname',fn);


text(0,1.1,'C','fontsize',fpan,'fontweight','bold','Units','normalized');
text(3.7,330,'2hPG', 'fontsize',fs2,'fontname',fn);
text(4,165, 'FPG','fontsize',fs2,'fontname',fn);;

fs10=8;
text(0.06,40,'NGT','fontsize',fs10,'fontname',fn);
text(1.3,40,'IGT','fontsize',fs10,'fontname',fn);
text(2.2,40,'CGI','fontsize',fs10,'fontname',fn);
text(4.1,40,'T2D','fontsize',fs10,'fontname',fn);

axis ([0 5 0 350])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tI=subplot(3,2,4);
plot(NGT_IGT_CGI_T2D.t/(365*1440),NGT_IGT_CGI_T2D.I0,'k', 'linewidth',lw);

hold('on')
plot(NGT_IGT_CGI_T2D.t/(365*1440),NGT_IGT_CGI_T2D.I120,'k', 'linewidth',lw);


%xlabel('time (year)','fontsize', fs, 'fontname',fn);
ylabel('{Insulin} ({\mu}U/ml)','fontsize', fs, 'fontname',fn);


text(0,1.1,'D','fontsize',fpan,'fontweight','bold','Units','normalized');
text(4,65,'2hPI', 'fontsize',fs2,'fontname',fn);
text(4,25, 'FPI','fontsize',fs2,'fontname',fn);


axis ([0 5 0 150])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tsigma=subplot(3,2,5);

plot(NGT_IGT_CGI_T2D.t/(365*1440),NGT_IGT_CGI_T2D.sigma,'k', 'linewidth',lw);
%hold('on')



xlabel('time (year)','fontsize', fs, 'fontname',fn);
ylabel('{\sigma}','fontsize', fs, 'fontname',fn);

text(0,1.1,'E','fontsize',fpan,'fontweight','bold','Units','normalized');
axis ([0 5 0 1])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tb=subplot(3,2,6);

plot(NGT_IGT_CGI_T2D.t/(365*1440),NGT_IGT_CGI_T2D.b,'k', 'linewidth',lw);

xlabel('time (year)','fontsize', fs, 'fontname',fn);
ylabel('{\beta} (mg)','fontsize', fs, 'fontname',fn);

text(0,1.1,'F','fontsize',fpan,'fontweight','bold','Units','normalized');
axis ([0 5 0 3000])


