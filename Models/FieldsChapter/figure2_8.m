% Morris-Lecar-like neuron

yinit = [-65.0; 0.00016];

tspan = [0 5000]; % msec

options = odeset('Stats','off');

[t, y] = ode45(@ml, tspan, yinit, options);

plot(t/1000, y(:,1))
xlabel 't (sec)'
ylabel 'V (mV)'


%=================================================
function dydt = ml(t,y)

% parameters
vk=-75; vl=-70; vca=25;
iapp=0; % Table 2.1 says incorrectly that iapp = 1000
gk=2700; gl=260; gca=1000; cm=5300;
v1=-20.0; v2=24; v3=-16; v4=11.2; phi=0.01;
gkatp=0.0;

% give the variables recognizable names:
v = y(1);
n = y(2);

% auxiliary functions:
minf=.5*(1+tanh((v-v1)/v2));
ninf=.5*(1+tanh((v-v3)/v4));
tau=1/(phi*cosh((v-v3)/(2*v4)));
Ica = gca*minf*(v-vca);

% allocate storage for the derivatives (right-hand side):
dydt = zeros(2,1);


% equations:
dydt(1) = (iapp + gl*(vl - v) + gk*n*(vk - v) - Ica + gkatp*(vk-v))/cm;
dydt(2) = (ninf - n)/tau;

end

