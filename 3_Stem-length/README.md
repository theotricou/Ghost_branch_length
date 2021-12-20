
# Anopheles #

This folder is organised as follows: 

### **`Scripts/`** ###

Contains a single R script (`stem-length-test.R`) that does all the steps for simulating data, computing the effect that ghost lineages have on the stem-length method and plotting the results presented in the manuscript. 

The header of the file, reproduced here, contains all the information necessary for understanding and using this code if necessary. 

```R

## These functions allow for testing the agreement between real and stem-length infered 
## acquisition times of genes by transfers. Inspired by the stem-length method proposed in Pittis and Gabaldon, 2016 (Science).
## 
## It is a three-steps process: 
##  1/ Simulate tree
##  2/ Generate pairs of acquisitions and for each, compute the real and the infered order of events
##  3/ Count how often they agree or disagree
##
## Function 'StemLengthSimulation' does the following : 
##  - take a tree and a time slice in the tree (relative time between percmin and percmax)
##  - sample ONE introgression donor (BRANCH and MOMENT), with probability of sampling this donor
##    proportional to the number of branches at that time. 
##  - compute the real time of the event and the inferred time if using stem length method
##  - all times are in proportion of the total height of the tree
##  - N extant species are considered. N can be smaller than the true number of extant species
##
## Function 'DoSimul' calls the previous function by doing the following: 
##  - Call 'NbTransf' times the function 'StemLengthSimulation' [NbTransf must be even]
##  - Separate in 'NbTransf/2' pairs of transfers
##  - For each pair, test whether real infered stem lengths agree on the timing (TRUE), disagree (FALSE), 
##    or if the infered times with stem-length are equal (NA)
##  - Return a table with number of TRUE, FALSE and NA
##  - the function also plots the tree and the times of transfers
##
## Function 'colorit' does the following: 
##  - plots the complete tree with extant (and sampled) species in and their ancestors in black
##  - plots small red points where introgressions occur 
## 


```

----------------------

## Requirements ##

To use this script, you only need R installed, with the following packages: 
* ape
* phangorn
* TreeSimGM

