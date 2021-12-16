#!/usr/bin/env Rscript
# Theo

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
  T2=(1 / 1000) *  ((length(which(pa == 'aba')) +
      length(which(pa == 'baa')))/2)
  T1=(1 / 1000) * (((length(which(pa == 'aba')) +
      length(which(pa == 'baa')))/2) + length(which(pa == 'bba')))
  res=c("Topology"=topo, "T2"=T2, "T1"=T1)
  return(res)
}

std <- function(x) sd(x)/sqrt(length(x))

simulateTT<-function(model, name){
  rep = simulate(model, nsim = 1000, cores = 8)
  TT<-as.data.frame(do.call('rbind',lapply(rep, function(x) TT_count(x))))
  TT$T1<-as.numeric(as.character(TT$T1))
  TT$T2<-as.numeric(as.character(TT$T2))
  TT$truc<-"other"
  TT[which(TT$Topology == "ABC"), "truc"] <- "ABC"
  TT$truc<- as.factor(TT$truc)
  res=c("mT1"=mean(TT$T1), "mT2"=mean(TT$T2), "seT1"=std(TT$T2),
      "seT2"=std(TT$T2))
  # plot(TT$T1 ~ TT$truc, main = name)
  # plot(TT$T2 ~ TT$truc)
  # write.table(TT, paste(name, ".txt", sep = ""), sep = "\t", row.names = F, append = F, quote=F)
  return(res)
}

source("ms_command.R")

list_model<-list("no_int" = model, "ingroup_int" = model_ingroup,
                  "ghost_int" = model_ghost)
# par(mfrow=c(4,2))
RES<-do.call('rbind', lapply(c(1: length(list_model)), function(x) simulateTT(list_model[[x]], names(list_model[x]))))
res<-as.data.frame(RES)
res
# png(filename = "Clean_spe.png", width = 500, height = 900,
#     unit = "px", pointsize = 18, bg = "white")
# svg(filename = "Clean_spe.svg", width = 6, height = 9,
#       pointsize = 12, bg = "white")

plot(c(res$mT1, res$mT2), ylim=c(min(res$mT2)-(min(res$mT2)/3),max(res$mT1)),
    pch = 23, cex =3, col="black", bg=c("#DA291CFF", '#56A8CBFF', "#53A567FF"),
    xaxt='n', xlim=c(0,7), xlab="", ylab ="Height", cex.axis = 1.2, cex.lab= 1.4)

segments(c(1:6)+0.25,c(res$mT1, res$mT2)-c(res$seT1, res$seT2),
         c(1:6)+0.25,c(res$mT1, res$mT2)+c(res$seT1, res$seT2),
         lwd = 2, , cex = 5)
axis(side = 1, at = c(2,5), labels=c("T1", "T2"), tick = F,  cex.axis = 1.4)
axis(side = 1, at = c(2,5), labels=c("Species        Ghost\nIngroup",
    "Species        Ghost\nIngroup"), tick = F, line=-2.5, cex.axis = 1.2)

# dev.off()
