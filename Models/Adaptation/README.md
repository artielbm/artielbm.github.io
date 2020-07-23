# Adaptation
Supplementary xpp files for Ha and Sherman, "How Adaptation Makes Low Firing Rates Robust" [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/28647913), [[The article]](https://mathematical-neuroscience.springeropen.com/articles/10.1186/s13408-017-0047-3).

Two models are studied: One is modified from Hindmarsh and Rose, 1984 Proc R Soc Lond B Biol Sci, 221:87-102 [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/6144106), and the other is modified from Morris and Lecar, Biophys J, 1981 35(1):193-213 [[PubMed]](https://pubmed.ncbi.nlm.nih.gov/7260316).

The 2D Hindmarsh-Rose model with a SNIC but no adaptation, corresponding to Figs. 1 and 2, is defined in [HR_SNIC_2D.ode](./HR_SNIC_2D.ode).

The 3D Hindmarsh-Rose model with a SNIC and adaptation, corresponding to Figs. 3 - 5 and 7, is defined in [HR_SNIC.ode](./HR_SNIC.ode).

The 2D Hindmarsh-Rose model with a Hopf bifurcation but no adaptation, used to make Figs. 8 and 9, is defined in [HR_Hopf_2D.ode](./HR_Hopf_2D.ode).

The 3D Hindmarsh-Rose model with a Hopf bifurcation and adaption, corresponding to Fig. 10 is defined in [HR_Hopf.ode](./HR_Hopf.ode).

The Morris-Lecar model with adaptation is defined in [ML.ode](./ML.ode).

The version with a SNIC, corresponding to Fig. 11 in the paper, is defined in [ML_SNIC.set](./ML_SNIC.set). 

The version with a Hopf bifurcation, corresponding to Fig. 12, is defined in [ML_Hopf.set](./ML_Hopf.set).
