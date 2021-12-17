## Scripts to generate Anopheles-like dataset for the manuscript _Recognizing the existence of ghost lineages reverses the results of evolutionary studies on genetic transfers_ 

## Input file(s): 
`species_tree` contains the input tree generated with the software [ZOMBI](https://github.com/AADavin/Zombi) (Davin et al. 2020).
  
## Requirements: 

To use these scripts, you need, python3 and R to be installed on your computer, and the following R packages: [_coala_](https://github.com/statgenlmu/coala) and ggplot2.

## Command-line:


The three following commands will produce the dataset used- and the figure presented- in the manuscript for the _Anopheles_ example. 

The first script (`ms_generator.py`) reads the species tree, converts it to an ms-compatible format, simulates an introgression and outputs a [_coala_](https://github.com/statgenlmu/coala)-formated ms tree. 

The second script (`ms_simulation.R`) reads the file produced by the previous script and executes ms. 

The third script (`plot_Anopheles.R`) runs R to produces the figure presented in the Results section (subsection Anopheles) of the manuscript.


```shell
ms_generator.py 
ms_simulation.R #
plot_Anopheles.R
```

