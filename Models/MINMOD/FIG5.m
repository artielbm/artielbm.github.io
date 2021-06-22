

%%%%% plot FIG3 from estimated MINMOD

input_si=[1.3888 2.7776 4.1664 5.5552];  % input si, si=input_si*6.944 for unit conversion
Control_clamp_si=[0.063 0.103 0.1427 0.1814 ];% from Iclamp sim
Large_RRP_clamp_si=[ 0.05773403 0.09881845 0.1383 0.17654831];% from Iclamp sim



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

scatter(input_si,Control_clamp_si,'o', 'k', 'linewidth',lw)
hold('on')
scatter(input_si,Large_RRP_clamp_si,'t', 'r', 'linewidth',lw)

lh=legend('Control','Large RRP','location','northwest');
set(lh,'FontSize',8); 
legend('boxoff');
xlabel('Input {S_I} (10^{-4}ml/\muU/min)','fontsize', fs, 'fontname',fn);
ylabel('Clamp S_I(mg/kg/\muU/ml/min)','fontsize', fs, 'fontname',fn);
axis ([0 8 0 0.2])












