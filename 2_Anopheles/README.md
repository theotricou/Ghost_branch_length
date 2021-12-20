# 2__Anopheles_ method

## Input_files

`species_tree` fle, _i.e._ the input tree generated with the software [ZOMBI](https://github.com/AADavin/Zombi) (Davin et al. 2020).
  
## Scripts

Scripts used to produce the dataset used- and the figure presented- in the manuscript. 


### Usage:
```shell
ms_generator.py 
ms_simulation.R #
plot_Anopheles.R
```

### Description
The first script (`ms_generator.py`) reads the species tree, converts it to an ms-compatible format, simulates an introgression and outputs a [_coala_](https://github.com/statgenlmu/coala)-formated ms tree. 

The second script (`ms_simulation.R`) reads the file produced by the previous script and executes ms. 

The third script (`plot_Anopheles.R`) runs R to produce the figure presented in the Results section (subsection _Anopheles_) of the manuscript.

## Datasets

Datasets produced with the scripts described above and used in the manuscript.

`ghost_int_final.txt`: data for the introgression event coming from a ghost lineage.

`ingroup_int_final.txt`: data for the introgression event coming from within the ingroup.

## Requirements

To use these scripts, you need, python3 and R installed on your computer, and the following R packages: [_coala_](https://github.com/statgenlmu/coala) and ggplot2.

