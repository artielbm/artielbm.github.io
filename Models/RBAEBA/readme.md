Calcium Calculator
Matlab files to accompany:
*Asymptotic analysis of buffered calcium diffusion near a point source.* Gregory D. Smith, Longxiang Dai, Robert M. Miura, and Arthur Sherman. 2001. SIAM J. App. Math. 61:1816-1838 [[doi]](https://doi.org/10.1137/S0036139900368996)

This page contains matlab scripts that allow calculation of calcium and buffer profiles near a point source for free calcium release.

Zip file with the scripts: zip file (23K).

How to use the files:
For a description of each function, run matlab, and type "help ".

Four EXAMPLE scripts are included. They have been tested with Matlab 5.2 and 5.3.

EXAMPLE_RBA, EXAMPLE_EBA, and EXAMPLE_IBA load buffer and source parameters and then plot various approximate solutions to the equations for the buffered diffusion of calcium (RBA, EBA, IBA). To run these type:

>> example_rba

etc. at the matlab prompt. First order (plotted in red) and second order (plotted in green) versions of the approximations are compared to the numerically calculated exact solution (plotted in blue) obtained using FULLEQ. EXAMPLE_EBA also calculates LIN, the linear approximation (plotted in magenta).

Parameters are purposely chosen so that the various approximations are marginally valid, so that the improvement of the second order approximations is obvious in the graphs. To modify parameters, edit the files RBAPARAMS.M, EBAPARAMS.M, or IBAPARAMS.M. A good exercise is to try to move the points squarely into RBA, EBA, or IBA zones, where you should see both the first and second order approximations converge to the exact solutions.

gif files of the output: RBA, EBA, and IBA.
EXAMPLE_DIM loads buffer and source parameters and then plots calcium and buffer profiles near a point source using RBADIM, a dimensional version of the RBA approximation. Those more comfortable with dimensional versions of these approximations can easily modify this script to present calculations using EBADIM, IBADIM, or LINDIM.

Questions and comments about the MATLAB scripts can be sent to:

Gregory D. Conradi Smith
The College of William and Mary
Email: greg.conradi.smith@gmail.com
URL: http://wmpeople.wm.edu/site/page/gdsmit/home
