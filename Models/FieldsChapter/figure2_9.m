function burst

% Ref: Fields Chapter, Fig. 2.9

%yinit = [-65; 0.00016; 0.2];
yinit = [-58.7; 0.00049; 0.096];

tspan = [0 20000];

% axis([0.170 0.184 -65 -20]);



% options = odeset('Stats','off', 'OutputFcn', @odephas2, 'OutputSel', [3 1])
% These options plot solution as it is calculated:
% options = odeset('Stats','off', 'OutputFcn', @odeplot, 'OutputSel', [1])
options = odeset('Stats','off');

[t,y] = ode45(@qbc,tspan,yinit,options);
%[t,y] = ode15s(@qbc,tspan,yinit,options);

yyaxis left
plot(t/1000, y(:,1), 'c-')
%xlim([0 20])
xlabel 't (sec)'
ylabel 'V (mV)'

yyaxis right
plot(t/1000, y(:,3), 'r-')
%xlim([0 20])
%ylim([0 0.4])
xlabel 't (sec)'
ylabel 'Ca (uM)'

end
%========================================================
function dydt = qbc(t,y)

vk=-75; vl=-70; vca=25;
iapp=1000; gk=2700; gl=200; gca=1000; cm=5300;
v1=-20.0; v2=24; v3=-16; v4=11.2; phi=0.01;
gkca=3000.0; c0=5.0;
alpha=4.50e-6; kc=0.15; f=0.001;
gkatp=0;

dydt = zeros(3,1);

v = y(1); n = y(2); c = y(3);

minf = 0.5*(1+tanh((v-v1)/v2));
ninf = 0.5*(1+tanh((v-v3)/v4));
tau = 1/(phi*cosh((v-v3)/(2*v4)));

Ikca = gkca/(1+(c0/c))*(v-vk);
Ica = gca*minf*(v-vca);


dydt(1) = (iapp + gl*(vl-v) + gk*n*(vk-v) - Ica - Ikca + gkatp*(vk-v))/cm;
dydt(2) = (ninf - n)/tau;
dydt(3) = f*(-alpha*Ica - kc*c);

end

