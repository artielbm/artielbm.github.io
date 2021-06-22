

%%%%% plot FIG3 from estimated MINMOD

input_si=[1.3888 2.7776 4.1664 5.5552];  % input si, si=input_si*6.944 for unit conversion
Control_MINMOD_si=[2.080 3.860 5.57 7.240];% estimated from MINMOD
Large_RRP_MINMOD_si=[1.21 2.17 3.06 4.04];% estimated from MINMOD



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

scatter(input_si,Control_MINMOD_si,'filled', 'k', 'linewidth',lw)
hold('on')
scatter(input_si,Large_RRP_MINMOD_si,'filled', 'r', 'linewidth',lw)

lh=legend('Control','Large RRP','location','northwest');
set(lh,'FontSize',8); 
legend('boxoff');
xlabel('Input {S_I} (10^{-4}ml/\muU/min)','fontsize', fs, 'fontname',fn);
ylabel('MINMOD {S_I} (10^{-4}ml/\muU/min)','fontsize', fs, 'fontname',fn);
axis ([0 8 0 8])












