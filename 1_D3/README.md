## script for generating the dataset, dataset, and plotting functions for the D3 analysis

* `build_ms_command.py` is the script that convert a newick tree simulated with ZOMBI (Davin et al. 2020) into an object suitable for _ms_
* `ms_simulation_D3.R` read the ms object generated then calls the ms software and generates D3 data. The code in `scr.sh` allows to run multiple simulations
* `D3_data.txt` is the dataset produced by the above scripts
* `plot_D3.R` is the R script that read the dataset and produces the figures for the manusctipt.
* `sim_parameters` is the options file for _ms_
* `zombi_parameters` is the options file for the _Zombi_ software

* Alternatively, you can use `run_D3_simulation.sh` to run the species tree simulation using Zombi and the D3 test.

* Both sim_parameters and zombi_parameters files are seeded with "1123581321". You will need to change those seeds for randon simulations
