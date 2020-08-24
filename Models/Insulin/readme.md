# Equations for Metabolic Insulin Signaling Pathways

## Supplementary material to accompany:

*A mathematical model of metabolic insulin signaling pathways*, A. R. Sedaghat, A. Sherman, and M. J. Quon. Am. J. Physiol., 283(5):E1084-101, 2002. [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/12376338/)

This page contains input files for the differential equation solvers _XPP_ and _WinPP_ that reproduce the figures in the above paper. The instructions below assume you have the paper open in front of you.

## Brief notes on the software:

XPP is designed for use with Unix/Linux and X-Windows. WinPP is designed for use with Windows. It is no longer under development, and lacks some features (not needed if you just want to solve these equations). See How to obtain below for information on how to run XPP with Windows. The files are human-readable ASCII text and may be easily adapted to other software if you do not have XPP or WinPP or prefer another tool.

There are two files:

nofeedback.ode (2K).
Which describes the basic model without negative feedback.
This file was used to produce Figures 6 and 7, the curves labeled "without feedback" in Figures 10 and 11, and Figure 12 in the paper.

feedback.ode (2K).
Which describes the basic model with negative feedback.
This file was used to produce Figures 8 and 9, and the curves labeled "with feedback" in Figures 10 and 11 in the paper.

How to use the files:
If you have and know how to use XPP/WinPP, just click on the link of each file, save to your own computer, and open with XPP or WinPP. (In Windows, be sure to save as Text). If not, see _How to obtain_ below.

Using nofeedback.ode, integrating with the default view, parameters and initial conditions will produce Fig. 6A (x2 vs. time). The other variables displayed in Figs. 6 and 7 in the paper can be displayed by changing the graphical view (no need to reintegrate). Fig. 10 is more labor intensive, each data point requiring a separate integration of the equations for each value of Insulin (insstep, in the ode file). Fig. 12 illustrates the effect of increasing phosphatase activity by raising the parameter PTP to 1.5. Insulin concentration (insstep) must also be adjusted as indicated in the figure.

Using feedback.ode, integrating with the default view, parameters and initial conditions will produce Fig. 8A (x2 vs. time). The other variables displayed in Figs. 8 and 9 in the paper can be displayed by changing the graphical view. Fig. 10 again requires a separate integration of the equations for each value of Insulin (insstep).

## How to obtain and learn about XPP/WinPP:

Information on how to use and install these programs can be found at: Bard Ermentrout's XPP Web page.
If you know what you want (for example, you just need the latest version), the programs can be downloaded from: Bard Ermentrout's ftp site.
A book with tutorials on how to use XPP/WinPP along with many informative examples of what they can be used for:

"Simulating, Analyzing, and Animating Dynamical Systems", by Bard Ermentrout, published in 2002 by SIAM (Society for Industrial and Applied Mathematics). The book can be ordered from SIAM On-Line Book Catalog or elsewhere. The ISBN is 0-89871-506-7.

CellML Version of Model
A CellML version of the model is available at: [CellML](http://models.cellml.org/cellml).

## Questions and Comments
Questions and comments about the ode files can be sent to:

Arthur Sherman
[[mailto:arthurs@niddk.nih.gov]](arthurs@niddk.nih.gov)
