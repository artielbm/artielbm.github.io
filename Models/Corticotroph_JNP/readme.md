# Model of corticotroph electrical activity

 Two XPP files, described below, were used to generate figure panels described in:

"Modeling the diversity of spontaneous and agonist-induced electrical activity in anterior pituitary corticotrophs"
 Patrick Allen Fletcher, Hana Zemkova, Stanko S. Stojilkovic, Arthur Sherman
 Journal of Neurophysiology, Published 22 February 2017, Vol. no. , DOI: [10.1152/jn.00948.2016](http://dx.doi.org/10.1152/jn.00948.2016)

The ODE files can be can be downloaded [here](https://artielbm.github.io/Models/Corticotroph_JNP/) and run using Bard Ermentrout's [XPPAUT simulation tool](http://www.math.pitt.edu/~bard/xpp/xpp.html)

## [JNP17.ode](https://artielbm.github.io/Models/Corticotroph_JNP/JNP17.ode)

This file describes corticotroph electrical activity without ER calcium dynamics, used to simulate spontaneous electrical activity and modulation by CRH-receptor activation

Notes:

- Ensure that the system is at steady state before running a dynamic pulse simulation. The initial condition is set to the hyperpolarized state used for Fig. 4B
- Set parameters as indicated below to obtain the trajectory of interest from Figures 3-6. Default model parameters produce low-frequency spiking
- To see the pulse profile, plot the auxiliary variable "g"

### Figure 3B

- top (diamond)   - gnab=0.22, gbk=1.1
- middle (circle) - gnab=0.22, gbk=0.25
- bottom (square) - gnab=0.22, gbk=0.05

### Figure 4B

- top (diamond)   - gnab=0.05, gcrhpulse=0.22, gbk=0.89
- middle (circle) - gnab=0.05, gcrhpulse=0.22, gbk=0.25
- bottom (square) - gnab=0.05, gcrhpulse=0.22, gbk=0

### Figure 4D

- top (diamond)   - gkir=3.5, kp=0.3, gkirpulse=-2.4, gbk=0.96
- middle (circle) - gkir=3.5, kp=0.3, gkirpulse=-2.4, gbk=0.25
- bottom (square) - gkir=3.5, kp=0.3, gkirpulse=-2.4, gbk=0

### Figure 4F

- top (diamond)   - gkleak=1.9, kp=0.1, gkirpulse=-1.875, gbk=0.96
- middle (circle) - gkleak=1.9, kp=0.1, gkirpulse=-1.875, gbk=0.5
- bottom (square) - gkleak=1.9, kp=0.1, gkirpulse=-1.875, gbk=0

### Figure 6B

- top (diamond)   - vmca=-8, CRHvmca=-6, gbk=0.98
- middle (circle) - vmca=-8, CRHvmca=-6, gbk=0.7
- bottom (square) - vmca=-8, CRHvmca=-6, gbk=0.1

### Figure 7B

- top (diamond)   - gcrh=0.105, kcabk=2, CRHkcabk=1.4, gbk=1
- middle (circle) - gcrh=0.105, kcabk=2, CRHkcabk=1.4, gbk=0.5  
- bottom (square) - gcrh=0.105, kcabk=2, CRHkcabk=1.4, gbk=0.1  

### Figure 7D

- diamond  - gcrh=0.105, kcabk=2, gbk=0.5
- circle   - gcrh=0.105, kcabk=3.5, gbk=0.5
- star     - gcrh=0.105, kcabk=3.5, gbk=0.05
- square   - gcrh=0.105, kcabk=2, gbk=0.95

## [JNP17er.ode](https://artielbm.github.io/Models/Corticotroph_JNP/JNP17er.ode)

This file describes the model of corticotroph electrical activity modified to include ER calcium dynamics and IP3 receptor dynamics, used for simulation of Gq-coupled AVP receptor activation

Notes:

- The initial condition is set to the hyperpolarized state used for Fig. 7B top
- Set parameters to following to obtain the trajectory of interest from Figure 8
- To see the pulse profiles, plot the auxiliary variable "g1" or "g2"

### Figure 8B

- top (diamond)   - gnab=0.14, gbk=1, gavppulse=0.07, prelavp=0.01
- middle (circle) - gnab=0.18, gbk=0.85, gavppulse=0.055, prelavp=0.0025
- bottom (square) - gnab=0.17, gbk=0.35, gavppulse=0.04, prelavp=0.001
