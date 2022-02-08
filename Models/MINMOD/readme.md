<p align="center">
### Assessing Insulin Resistance
</p>

XPP and Matlab files for:

J. Ha, R. Muniyappa, A. S. Sherman, and M. J. Quon. 2021. When MINMOD Artifactually Interprets Strong Insulin Secretion as Weak Insulin Action. Frontiers in Physiology. 12:601894. [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/33967818/) [[doi]](https://www.frontiersin.org/articles/10.3389/fphys.2021.601894/full).

XPP zip file: [FrontiersXPP.zip](FrontiersXPP.zip)

Matlab zip file: [FrontiersMatlab.zip](FrontiersMatlab.zip)

**Note**: if you would like to run any of the scenarios below with different parameters, first bring the system to steady state with the new parameters using 0 input (i.e., set the IVGTT or OGTT flux to 0).

Files by Figure:

* Figure 2: IVGTTs, varying RRP size
    * XPP: Run [IVGTT.ode](IVGTT.ode) using in turn [FIG2_control.set](FIG2_control.set) and [FIG2_Large_RRP.set](FIG2_Large_RRP.set)
    * Matlab: [FIG2.m](FIG2.m) calls RHS file [IVGTT_ode.m](IVGTT_ode.m) 

* Figure 3: MINMOD Estimated vs. Assumed SI corresponding to Figure 2
    * XPP: Run [IVGTT.ode](IVGTT.ode) using in turn [FIG3_control_1.set](FIG3_control_1.set), [FIG3_control_2.set](FIG3_control_2.set), [FIG3_control_3.set](FIG3_control_3.set), [FIG3_control_4.set](FIG3_control_4.set), [FIG3_Large_RRP_1.set](FIG3_Large_RRP_1.set), [FIG3_Large_RRP_2.set](FIG3_Large_RRP_2.set), [FIG3_Large_RRP_3.set](FIG3_Large_RRP_3.set), and [FIG3_Large_RRP_4.set](FIG3_Large_RRP_4.set) (freeze curves to build up plot).        
    * Matlab: run simulations with [FIG3_sim.m](FIG3_sim.m), plot final figure with [FIG3.m](FIG3.m)

* Figure 4: Simulated hyperinsulinemic euglycemic clamps (HIEC)
    * XPP:  Run [IVGTT.ode](IVGTT.ode) using in turn [FIG4_control.set](FIG4_control.set) and [FIG4_Large_RRP.set](FIG4_Large_RRP.set). 
    * Matlab: [FIG4.m](FIG4.m) calls RHS file [IVGTT_ode.m](IVGTT_ode.m) 

* Figure 5: HIEC Estimated vs. Assumed SI corresponding to Figure 4
    * XPP: Run [IVGTT.ode](IVGTT.ode) using in turn [FIG5_control_1.set](FIG5_control_1.set), [FIG5_control_2.set](FIG5_control_2.set), [FIG3_control_3.set](FIG5_control_3.set), [FIG5_control_4.set](FIG5_control_4.set), [FIG5_Large_RRP_1.set](FIG5_Large_RRP_1.set), [FIG5_Large_RRP_2.set](FIG5_Large_RRP_2.set), [FIG5_Large_RRP_3.set](FIG5_Large_RRP_3.set), and [FIG5_Large_RRP_4.set](FIG3_Large_RRP_5.set)
    * Matlab: run simulations with [FIG5_sim.m](FIG5_sim.m), plot final figure with [FIG5.m](FIG5.m)

* Figure 6: IVGTTs, varying vesicle docking rate sigma
    * XPP: Run [IVGTT.ode](IVGTT.ode) using in turn [FIG6_control.set](FIG6_control.set), [FIG6_strong_secretion.set](FIG6_strong_secretion.set), and [FIG6_very_strong_secretion.set](FIG6_very_strong_secretion.set).
    * Matlab: [FIG6.m](FIG6.m) calls RHS file [IVGTT_ode.m](IVGTT_ode.m) 

* Figure 7:  HIEC Estimated vs. Assumed SI corresponding to Figure 6
    * XPP: Run [IVGTT.ode](IVGTT.ode) using in turn [FIG7_control_1.set](FIG7_control_1.set), [FIG7_control_2.set](FIG7_control_2.set), [FIG7_control_3.set](FIG7_control_3.set), [FIG7_control_4.set](FIG7_control_4.set), [FIG7_Large_sigma_1.set](FIG7_Large_sigma_1.set), [FIG7_Large_sigma_2.set](FIG7_Large_sigma_2.set), [FIG7_Large_sigma_3.set](FIG7_Large_sigma_3.set), and [FIG7_Large_sigma_4.set](FIG7_Large_sigma_4.set). 
    * Matlab: run simulations with [FIG7_sim.m](FIG7_sim.m), plot final figure with [FIG7.m](FIG7.m)

* Figure 8: OGTTs, varying RRP size or vesicle docking rate sigma
    * XPP:   Run [IVGTT.ode](IVGTT.ode) using in turn [FIG8_control.set](FIG8_control.set) and [FIG8_Large_RRP.set](FIG8_Large_RRP.set) for Panels A, B; [FIG8_control.set](FIG8_control.set), [FIG8_strong_secretion.set](FIG8_strong_secretion.set), and [FIG8_very_strong_secretion.set](FIG8_very_strong_secretion.set) for Panels C, D. 
    * Matlab: [FIG8.m](FIG8.m) calls [IVGTT_ode.m](IVGTT_ode.m) (sic) 
    * Erratum: the legend in Fig. 8C is backwards: green should be "Very Strong" and black should be "Control".  Run FIG8.m for the corrected figure. 
