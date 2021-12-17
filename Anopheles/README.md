## Scripts to generate Anopheles-like dataset for the manuscript _Recognizing the existence of ghost lineages reverses the results of evolutionary studies on genetic transfers_ 

* Input file(s) : 
  *  `species_tree` contains the input tree generated with the software [ZOMBI](https://github.com/AADavin/Zombi) (Davin et al. 2020).
  
* How to use the scripts:  
The three foloowing commands will produce the dataset used- and the figure presented- in the manuscript for the _Anopheles_ example 
```
ms_generator.py #reads the species tree, converts it to an ms-compatible format, simulates an introgression and outputs a [_coala_](https://github.com/statgenlmu/coala)-formated ms tree.
ms_simulation.R #
plot_Anopheles.R
```


* `ms_generator.py` reads a tree (simualted with ZOMBI in this case), simulates an ingroup introgression or ghost introgression then generate a coala formated ms tree.

* `ms_simulation.R` reads ms_command.R and contains all the functions, described in the header of the file.

* `species_tree` is the newick species tree used for this analysis.

* `ingroup_int_final.txt` is the dataset produced by simulating only ingroup introgression

* `ghost_int_final.txt` is the dataset produced by simulating only ghost introgression from outside the trîplet chosen

* `plot_Anopheles.R` is the script for producing the boxplot presenting the results in the article
