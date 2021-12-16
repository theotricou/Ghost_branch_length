## script for generating the dataset, dataset, and plotting functions for the D3 analysis

* `build_ms_command.py` is the script that convert a newick tree simulated with ZOMBI (Davin et al. 2020) in a ms object
* `ms_simulation_D3.R` read the ms object generated then calls the ms software and generates D3 data. You can use `scr.sh` to run multiple simulations
* `D3_data.txt` is the dataset produced by the above script
* `D3_plot.R` is the R script that read the dataset and produces the figures for the manusctipt.
