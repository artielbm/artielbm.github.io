### Chapter in "Case Studies in Mathematical Modeling---Ecology, Physiology, and Cell Biology," H. G. Othmer, F. R. Adler, M. A. Lewis, and J. C. Dallon, eds. Prentice Hall,1997. 

[Web page for the book](http://www.math.utah.edu/books/csmmepcb/index.html)

The chapter, *Calcium and Membrane Potential Oscillations in Pancreatic beta-Cells*: Unofficial [PDF Version](chapter.pdf) with Exercises (314K).

The figures in the chapter can be reproduced using the files below, which are inputs for the ODE solver [xpp](http://www.math.pitt.edu/~bard/xpp/xpp.html).

* Basic Model (Figs. 1 - 7, 11)

    * Two variable (fast subsystem)[vn.ode] (Figs. 2 - 3, 7).

    * Two variable (for IV curves only)[ivcurves.ode] (Fig. 1).

    * Three variable [bursting model](burst.ode) (Figs. 5, 6).
    
    * v-s pseudo-phase plane for Z-curves and slow nullclines [[zeecurves.ode]] (Figs. 5, 7).
    
    * Bursting Model with Electrical Coupling [Two Cells](twocells.ode) (Fig. 11).

* Extended Model with Endoplasmic Reticulum for [muscarinic bursting](ach.ode) (Fig. 9).

* Bi-phasic Transient (Fig. 10) with [model](crac.ode) from R. Bertram, P. Smolen, A. Sherman, D. Mears, I. Atwater, F. Martin, and B. Soria. 1995. A role for calcium-release activated current (CRAC) in cholinergic modulation of electrical activity in pancreatic beta-cells. Biophys. J. 68:2323-2332.  [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/7647236/)

* Two Parameter Diagram (Fig. 8) and phase plane sketches (Fig. 4) are taken from R. Bertram, M. Butte, T. Kiemel, and A. Sherman. 1995. Topological and phenomenological classification of bursting mechanisms. Bull. Math. Biol. 57:413-439.  [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/7728115/)

* Example of a bursting model with a Non-Planar Fast Subsystem (Ex. 10).
