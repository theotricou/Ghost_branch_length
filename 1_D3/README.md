
# D3 #

This folder is organised as follows: 

### **`Input_files/`** ###

Contains the parameters files for [ZOMBI](https://github.com/AADavin/Zombi) (Davin et al. 2020) (`zombi_parameters`), and the parameters file for the [ms software](http://home.uchicago.edu.inee.bib.cnrs.fr/~rhudson1/source/mksamples.html) (Hudson, 2002) used in this study (`sim_parameters`).
  
### **`Scripts/`** ###

Contains all the scripts used to produce the dataset used- and the figure presented- in the manuscript. 
You MUST use them in the following order. 

```shell
python3 Zombi.py T Input_files/zombi_parameters Datasets/ #Zombi must be installed first
python3 Scripts/build_ms_command_D3.py Datasets/T/CompleteTree.nwk -p Input_files/sim_parameters -s [N_sampled_species] -o Datasets -v 
Rscript ms_simulation_D3.R Datasets


```

The first line runs the Zombi software that produces a species tree. 

The second line converts the species tree to an ms-compatible format, simulates an introgression and outputs a [_coala_](https://github.com/statgenlmu/coala)-formated ms tree. `[N_sampled_species]` must be replaced by the number of species that need to be sampeld (see manuscript).

The last line reads the file produced by the previous line and executes ms from within R. 

The last line runs R to produce the figure presented in the Results section (subsection _D3_) of the manuscript.


### **`Datasets/`** ###

Contains the dataset produced with the scripts described above and used in the manuscript: `data_D3.txt`. Warning, if you run the code as described above, this file will be overwritten with another one with the same name.


----------------------

## Requirements ##

To use these scripts, you need, python3 and R installed on your computer, and the following R packages: [_coala_](https://github.com/statgenlmu/coala) and ggplot2. You also need the [ms software](http://home.uchicago.edu.inee.bib.cnrs.fr/~rhudson1/source/mksamples.html) (Hudson, 2002) and the [ZOMBI software](https://github.com/AADavin/Zombi) (Davin et al. 2020).

