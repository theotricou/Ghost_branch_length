
# D3 #

This folder is organised as follows: 

### **`Input_files/`** ###

Contains the parameters files for [ZOMBI](https://github.com/AADavin/Zombi) (Davin et al. 2020) (`zombi_parameters`), and the parameters file for the [ms software](http://home.uchicago.edu.inee.bib.cnrs.fr/~rhudson1/source/mksamples.html) (Hudson, 2002) used in this study.
  
### **`Scripts/`** ###

Contains all the scripts used to produce the dataset used- and the figure presented- in the manuscript. 
You MUST use them in the following order. 

```shell
python3 Zombi.py T Input_files/zombi_parameters Datasets #install zombi first!
python3 build_ms_command_D3.py Datasets/T/CompleteTree.nwk -p Datasets/sim_parameters -s [N_sampled_species] -o Datasets -v
Rscript ms_simulation_D3.R Datasets


```

The first line runs the Zombi software that produces a species tree. 

The second line converts the species tree to an ms-compatible format, simulates an introgression and outputs a [_coala_](https://github.com/statgenlmu/coala)-formated ms tree. 

The last line reads the file produced by the previous line and executes ms from within R. 

The last line runs R to produce the figure presented in the Results section (subsection _D3_) of the manuscript.


### **`Datasets/`** ###

Contains the datasets produced with the scripts described above and used in the manuscript.

`ghost_int_final.txt`: data for the introgression event coming from a ghost lineage.

`ingroup_int_final.txt`: data for the introgression event coming from within the ingroup.

----------------------

## Requirements ##

To use these scripts, you need, python3 and R installed on your computer, and the following R packages: [_coala_](https://github.com/statgenlmu/coala) and ggplot2. You also need the [ms software](http://home.uchicago.edu.inee.bib.cnrs.fr/~rhudson1/source/mksamples.html) (Hudson, 2002) and the [ZOMBI software](https://github.com/AADavin/Zombi) (Davin et al. 2020).






## script for generating the dataset, dataset, and plotting functions for the D3 analysis ##

* `build_ms_command.py` is the script that convert a newick tree simulated with ZOMBI (Davin et al. 2020) into an object suitable for _ms_
* `ms_simulation_D3.R` read the ms object generated then calls the ms software and generates D3 data. The code in `scr.sh` allows to run multiple simulations
* `D3_data.txt` is the dataset produced by the above scripts
* `plot_D3.R` is the R script that read the dataset and produces the figures for the manusctipt.
* `sim_parameters` is the options file for _ms_
* `zombi_parameters` is the options file for the _Zombi_ software

* Alternatively, you can use `run_D3_simulation.sh` to run the species tree simulation using Zombi and the D3 test.

* Both sim_parameters and zombi_parameters files are seeded with "1123581321". You will need to change those seeds for randon simulations
