The xpp files below were used in Bertram and Sherman, *A calcium based phantom bursting model for pancreatic beta-cells*, Bull. Math. Biol., 66:1313-1344 2004. [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/11106596/)

XPP files by figure:

* Basic Model (Figure 1; like Chay-Keizer negative feedback through cytosolic calcium only) [[figure1.ode]](figure1.ode)

* Basic Model with Slow Calcium (Figure 3; Chay-Keizer with slow cytosolic calcium) [[figure1.ode]](figure3.ode)

* ER Model - Fast Mode (Figure 6; model with cytosolic and ER calcium) [[figure1.ode]](figure6.ode)

* ER Model - Medium Mode (Figure 8; model with cytosolic and ER calcium) [[figure8.ode]](figure8.ode)

* ER Model - Addition of ACh (Figure 9; Store dumped but no ROC or SOC) [[figure9.ode]](figure9.ode)

* ER Model - Muscarinic Bursting (Figure 11; Store dumped and ROC activated)[[figure11.ode]](figure11.ode)

* ER/ATP Model - Slow Mode (Figure 13; c, cer, and a included) [[figure13.ode]](figure13.ode)

* ER/ATP Model - Addition of Tg (Figure 14; medium bursting converted to fast by SERCA blockade) [[figure14.ode]](figure14.ode)

* ER/ATP Model - Addition of Tg (Figure 15; slow bursting persists in face of SERCA blockade) [[figure15.ode]](figure15.ode)

* ER/ATP Model - Triphasic Response to Glucose (Figure 16) [[figure16.ode]](figure16.ode)

* ER/ATP Model - Addition of Tg and Tolbutamide (Figure 17; slow bursting persists in presence of both thapsigargin and tolbutamide) [[figure17.ode]](figure17.ode)

Master file
* Combined Model (Choose File/Get set to get all three models and fast/medium/slow bursting). [[biophan.ode]](biophan.ode)



You can also make animations of the trajectories, superimposed on bifurcation diagrams using the:

XPP file [[movie.ode]](movie.ode)

and the

Animation script file  [[biophan.ani]](biophan.ani)

With these files you can view the moving slow manifold and nullcline in the V-w (omega) plane. By default, the two files are set to produce slow bursting with the ER/ATP model (Figure 13, above). To see the animation choose View/Toons and read in the animation file from the animator File menu. File/Get set can be used to visualize other burst modes. You will need to adjust the parameters ttotal, wmin, and wmax to get the right scaling.

See the xpp documentation for information on how to make animations.
