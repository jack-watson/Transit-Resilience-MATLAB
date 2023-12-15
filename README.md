# Transit-Resilience-MATLAB

Main program can be run from Boston_NoN_HMS_demo.mlx (matlab livescript, equivalent of ipynb) or from Boston_NoN_HMS_scratch.m (as a function for development and debugging purposes). 

Data used as inputs is stored in data folder; make sure data directory is added to path. Modify variable "flood_geoTIFF_fpath" to reflect your system.

Currently, this isn't simulated compound flooding and opportunistic exploitation-- just flooding. Variable "threshold" can be set to determine at what depth of standing water (in meters) is necessary for a station to be considered flooded. Variable "recov_method" can be set to determine the network centrality measure used for recovery prioritization sequence. 

Email: watson.jac@northeastern.edu

