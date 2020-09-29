[Under Construction]

This is supplementary material for:

J. V. Stern, H. M. Osinga, A. LeBeau, and A. Sherman. 2007. Resetting behavior in a model of bursting in secretory pituitary cells: Distinguishing plateaus from pseudo-plateaus. Bull. Math. Biol., __70__(1):68-88 [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/17703340/)

This paper shows that two different classes of model for square-wave bursting in pituitary cells can be distinguished by their responses to resetting from the silent to the active phase. The model behavior resembles that seen in somatotrophs, lactotrophs, and corticotrophs.
This XPP file reproduces figure 2(b), and the same model was used for all the other simulation figures except 10(a):

* Basic 3D+1-variable bursting model [[pituit.ode]](pituit.ode)

This file implements a 2D+1 bursting model with similar resetting behavior:

* 2D+1-variable bursting model [[2dreset.ode]](2dreset.ode)

The paper compares the pituitary model with a generic Chay-Keizer-like model for bursting in pancreatic beta-cells which has different resetting behavior.
Based on: A. Sherman, J. Rinzel, and J. Keizer, Biophys. J.,54:411-425, 1988.
This file reproduces Fig. 2(a) and the same model was used to obtain Fig. 10(a):

* Chay-Keizer-like bursting model. [[srk.ode]](srk.ode)
