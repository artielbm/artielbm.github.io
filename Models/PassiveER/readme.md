The xpp files below were used in R. Bertram and A. Sherman. 2004. *Filtering of calcium transients by the endoplasmic reticulum in pancreatic beta-cells*, Biophys. J., 87:3775-3785.[[PubMed]](https://pubmed.ncbi.nlm.nih.gov/15465863/)

Cartoons of Two-Compartment (Left) and Three-Compartment (Right) Models

[[cartoons.jpeg]](cartoons.jpeg)

The model reproduces the experiments in Arredouani et al, Am. J. Physiol. __282__:E982-E991, 2002 [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/12401716/)

### XPP files by figure


* Two-Compartment Model (no CICR) (Figures 2 - 6; see ode file for details of how to produce each figure) [[two-cmpt.ode]](two-cmpt.ode)
*Key Finding:* Tg increases peak Ca, lowers nadir in agreement with experiment.
Effects of increasing glucose and external Ca are also reproduced, and the effect of increasing ER leak is predicted.

* Compound Ca Oscillations (Figures 7, 8; see ode file for details of how to produce each figure) [[compound.ode]](compound.ode)
*Key Finding:* Ca builds with each pulse in the compound burst provided the kineteics of cytosolic Ca are neither too slow nor too fast.

* Two-Compartment Model (with CICR) (Figures 9, 10; see ode file for details of how to produce each figure) [[cicr.ode]](cicr.ode)
*Key Finding:* If CICR is strong enough to produce net emptying of the ER during the active phase of a burst, then dumping the stores with Tg reduces Ca amplitude, in contradiction to the experiments.

Note: kserca3=0.05, kserca2b=0.002 ms^{-1}; incorrect in Table 1 of paper.

* Three-Compartment (Subspace) Model (Figure 11) [[three-cmpt.ode]](three-cmpt.ode)
Adapted from subspace model (model 2) in M. Zhang, P. Goforth, A. Sherman, R. Bertram, and L. S. Satin. 2003, Biophys. J. 84:2852-2870. [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/12719219/) [[XPP Files]](../Subspace)
