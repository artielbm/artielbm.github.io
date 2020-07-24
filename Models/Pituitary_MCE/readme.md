# Pituitary cell model using a common core of ionic currents

The files found here reproduce model trajectories described in:

"Common and diverse elements of ion channels and receptors underlying electrical activity in endocrine pituitary cells" by Fletcher, Sherman, and Stojilkovic, Molecular and Cellular Endocrinology, 463:23–36, 2018. [10.1016/j.mce.2017.06.022](http://dx.doi.org/10.1016/j.mce.2017.06.022)

The ODE files can be run using Bard Ermentrout's [XPPAUT simulation tool](http://www.math.pitt.edu/~bard/xpp/xpp.html)

## MCE17a.ode

This ODE file can be used to reproduce trajectories in Figures 2 and 6

### Figure 2

Change (gBK, gNaV) as follows:

- top - (0.9, 15)
- middle - (0.6, 1)
- bottom - (0.02, 12)

### Figure 6

Make sure the system is at steady state before applying a pulse stimulus to exactly recreate the figure.

Modify paramter values as follows:

- All panels - gBK=1
- top - gNav=1, ggsp=0.15
- middle - gNav=15, ggsp=0.15
- bottom - gNab=0.2, ggirk=2

## MCE17b.ode

Pituitary cell model using a common core of ionic currents, modified to include ER calcium, a cytosolic calcium subspace, and IP3 receptor dynamics. This file can be used to reproduce Figure 7

### Figure 7

Modify parameter values as follows:

- left panel: sigmad=39, ip3p=0.22, ggqp=0.15
- right panel: sigmad=1, ip3p=0.5, ggqp=0.15
