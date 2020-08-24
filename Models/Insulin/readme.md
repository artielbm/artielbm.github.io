## Equations for Metabolic Insulin Signaling Pathways

### Supplementary material to accompany:

*A mathematical model of metabolic insulin signaling pathways*, A. R. Sedaghat, A. Sherman, and M. J. Quon. Am. J. Physiol., 283(5):E1084-101, 2002. [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/12376338/)

This page contains input files for the differential equation solvers __XPP__ and __WinPP__ that reproduce the figures in the above paper.

### Brief notes on the software:

XPP is designed for use with Unix/Linux and X-Windows. WinPP is designed for use with Windows. XPP, WinPP and information on how to use them can be obtrained from [Bard Ermentrout's site](http://www.math.pitt.edu/~bard/xpp/xpp.html).

The files are human-readable ASCII text and may be easily adapted to other software if you prefer another tool, such as Matlab or Berkeley Madonna.

There are two files:

[nofeedback.ode (2K)](nofeedback.ode).

Which describes the basic model without negative feedback.
This file was used to produce Figures 6 and 7, the curves labeled "without feedback" in Figures 10 and 11, and Figure 12 in the paper.

[feedback.ode (2K)](feedback.ode).

Which describes the basic model with negative feedback.
This file was used to produce Figures 8 and 9, and the curves labeled "with feedback" in Figures 10 and 11 in the paper.

### How to use the files:

If you have XPP or WinPP, click on the link of each file, save to your own computer, and open with XPP or WinPP. *In Windows, be sure to save as Text*. Information on how to use and install these programs can be found at: Bard Ermentrout's XPP Web page.

Using nofeedback.ode, integrating with the default view, parameters and initial conditions will produce Fig. 6A (x2 vs. time). The other variables displayed in Figs. 6 and 7 in the paper can be displayed by changing the graphical view (no need to reintegrate). Fig. 10 is more labor intensive, each data point requiring a separate integration of the equations for each value of Insulin (insstep, in the ode file). Fig. 12 illustrates the effect of increasing phosphatase activity by raising the parameter PTP to 1.5. Insulin concentration (insstep) must also be adjusted as indicated in the figure.

Using feedback.ode, integrating with the default view, parameters and initial conditions will produce Fig. 8A (x2 vs. time). The other variables displayed in Figs. 8 and 9 in the paper can be displayed by changing the graphical view. Fig. 10 again requires a separate integration of the equations for each value of Insulin (insstep).  

__Important:__ This model has a delay equation, so the *delay* numerical parameter has to be set to a number greater than or equal to the delay used.  Consult the XPP documentation for more information.


### CellML Version of Model

A CellML version of the model is available at: [CellML](http://models.cellml.org/cellml).

### Questions and Comments
Questions and comments about the ode files can be sent to:

Arthur Sherman
[[mailto:arthurs@niddk.nih.gov]](arthurs@niddk.nih.gov)
