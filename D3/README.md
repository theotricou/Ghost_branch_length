## script for generating the dataset, dataset, and plotting functions for the D3 analysis

* `build_ms_command.py` is the script that convert a newick tree simulated with ZOMBI (Davin et al. 2020) in a ms object

* `ms_simulation_D3.R` read the ms object generated then calls the ms software and generates D3 data.

* Alternatively, you can use `run_D3_simulation.sh` to run the species tree simulation using Zombi and the D3 test.

* `D3_data.txt` is the dataset produced by 200 replicate of the above script.

* `D3_plot.R` is the R script that read the dataset and produces the figures for the manusctipt.


Both sim_parameters and zombi_parameters files are seeded with "1123581321". You will need to change those seeds for randon simulations
