#!/bin/bash
# Theo

#run D3 simulation for one species tree.

# Zombi can be clone from git@github.com:AADavin/Zombi.git

python3 ~/ZOMBI/Zombi.py T zombi_parameters out_dir

python3 build_ms_command_D3.py out_dir/T/CompleteTree.nwk -p out_dir/sim_parameters -s [N_sampled_species] -o out_dir -v

Rscript ms_simulation_D3.R out_dir
