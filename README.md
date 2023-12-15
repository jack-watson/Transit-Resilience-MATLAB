# Transit-Resilience-MATLAB

Main program can be run from Boston_NoN_HMS_demo.mlx (matlab livescript, equivalent of ipynb) or from Boston_NoN_HMS_scratch.m (as a function for development and debugging purposes). 

Data used as inputs is stored in the google drive folder at the below address; make sure data directory is added to path. Modify variable "flood_geoTIFF_fpath" and "network_fpath" to reflect your system. To use the .mat flood data provided, uncomment "load_from_file = true;" on line 5 of cell 1 in the .mlx demo (line 14 in the .m file).
Data: https://drive.google.com/drive/folders/1JAiTNTBJlEgmFpAmPN-UwsJ2VRCYtFw9?usp=sharing

Currently, this isn't simulated compound flooding and opportunistic exploitation-- just flooding. Variable "threshold" can be set to determine at what depth of standing water (in meters) is necessary for a station to be considered flooded. Variable "recov_method" can be set to determine the network centrality measure used for recovery prioritization sequence. 

Email: watson.jac@northeastern.edu

