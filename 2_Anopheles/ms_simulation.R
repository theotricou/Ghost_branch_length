#!/usr/bin/env Rscript
# Théo


# Simulate gene trees and output the observed topology, T2 and T1 distances  


library('ape')
library('coala')
library('phyclust')
library('phangorn')




activate_ms(priority = 600)

patterns_count<-function(sites){
  return(apply(sites, 2, function(x)
    if (all(x == c(1,0,0))){"aab"}
    else if (all(x == c(0,0,1))){"baa"}
    else if (all(x == c(0,1,0))){"aba"}
    else if (all(x == c(0,1,1))){"bba"}
    else{"other"}
  ))
}


TT_count<-function(sim){
  tt=read.tree(text=sim$trees[[1]][1])
  dist<-cophenetic(tt)
  temp=apply(dist, 1 , sum)
  out=names(temp[order(temp)][3])
  if (out == "s1"){
    topo="ABC"
    pa=patterns_count(sim$seg_sites[[1]])
  }else if (out == "s2"){
    topo="ACB"
    site=sim$seg_sites[[1]]
    site=site[c(2,1,3),]
    pa=patterns_count(site)
  }else if (out == "s3"){
    topo="BCA"
    site=sim$seg_sites[[1]]
    site=site[c(3,1,2),]
    pa=patterns_count(site)
  }
  T2=(1 / 1000) *  ((length(which(pa == 'aba')) + length(which(pa == 'baa')))/2)
  T1=(1 / 1000) * (((length(which(pa == 'aba')) + length(which(pa == 'baa')))/2) + length(which(pa == 'bba')))
  res=c("Topology"=topo, "T2"=T2, "T1"=T1)
  return(res)
}



source("ms_command.R")

list_model<-list("no_int" = model, "ingroup_int" = model_ingroup,
                  "ghost_int" = model_ghost)


model=list_model$ingroup_int
rep = simulate(model, nsim = 1000, cores = 8)
TT<-as.data.frame(do.call('rbind',lapply(rep, function(x) TT_count(x))))
write.table(TT,file="ingroup_int_final.txt",sep = "\t", row.names = F, append = F, quote=F)


model=list_model$ghost_int
rep = simulate(model, nsim = 1000, cores = 8)
TT<-as.data.frame(do.call('rbind',lapply(rep, function(x) TT_count(x))))
write.table(TT,file="ghost_int_final.txt",sep = "\t", row.names = F, append = F, quote=F)
