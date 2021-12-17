## Unique script for generating the dataset and plotting the results of the Anopheles analysis
* `ms_generator.py` reads a tree (simualted with ZOMBI in this case), simulates an ingroup introgression or ghost introgression then generate a coala formated ms tree.

* `ms_simulation.R` reads ms_command.R and contains all the functions, described in the header of the file.

* `species_tree` is the newick species tree used for this analysis.

* `ingroup_int_final.txt` is the dataset produced by simulating only ingroup introgression

* `ghost_int_final.txt` is the dataset produced by simulating only ghost introgression from outside the trîplet chosen

* `plot_Anopheles.R` is the script for producing the boxplot presenting the results in the article
