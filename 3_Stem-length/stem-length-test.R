library("ape")
library("phangorn")
library('TreeSimGM')


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


StemLengthSimulation<-function(tree, xy,tips, percmin, percmax, plot) {
    #perc: we don't accept transfer occuring in the last perc=proportion of the tree height.
    alive.tips<-tips

    if (plot) points(xy$xx[alive.tips], xy$yy[alive.tips], pch=19, col="black", cex=0.3)
    Ancestors.with.descent<-unique(unlist(Ancestors(tree, alive.tips)))
    #for a given tree, sample an introgression, with proba proportional to nb of branches at this time.
    #trick sampling: we put all branches each after each other and sample in this new array uniformly. Works well. 
    realtimeoftheevent.rel<-0
    while((realtimeoftheevent.rel<=percmin) || (realtimeoftheevent.rel>=percmax)) { 
        sample<-runif(1,0,max(cumsum(tree$edge.length)))
        if (sample<cumsum(tree$edge.length)[1]) {
            quellebranche<-1
            oudanslabranche<-sample
            nodeinvolved<-tree$edge[quellebranche,1]
        }
        else {
            quellebranche<-max(which(sample>cumsum(tree$edge.length)))+1
            oudanslabranche<-sample-cumsum(tree$edge.length)[quellebranche-1] #disatnce au début de la branche.
            nodeinvolved<-tree$edge[quellebranche,1]

        }
        realtimeoftheevent<-xy$xx[nodeinvolved]+oudanslabranche
        realtimeoftheevent.rel<-(max(xy$xx)-realtimeoftheevent)/max(xy$xx)
    }
    miny<-min(xy$yy)
    if (plot) points(xy$xx[nodeinvolved]+oudanslabranche, miny, pch=19, cex=0.3, col="red")
    ##we decide that this is the donor branch. The receiver branch will be another one present at exactly the same moment. 
    if (is.element(nodeinvolved, Ancestors.with.descent)) { #we give the time of the event
        stemlength.rel<-(max(xy$xx)-realtimeoftheevent)/max(xy$xx)
    }
    else {
        Anc<-Ancestors(tree, tree$edge[quellebranche,1])
        AncOk<-Anc[which(is.element(Anc, Ancestors.with.descent))[1]]
        stemlength.rel<-(max(xy$xx)-xy$xx[AncOk])/max(xy$xx)
    }
    return(c(realtimeoftheevent.rel, stemlength.rel))
}


colorit<-function(tree, tips, xy) {
    edg<-tree$edge
    tolookfor<-tips
    miniedg<-NULL
    while(length(tolookfor)>0) {
        subedg<-edg[is.element(edg[,2],tolookfor),,drop=FALSE]
        miniedg<-rbind(miniedg, subedg)
        tolookfor<-unique(subedg[,1])
    }
    #now we color miniedg
    segments(xy$xx[miniedg[,2]], xy$yy[miniedg[,2]], xy$xx[miniedg[,1]], xy$yy[miniedg[,2]], lwd=1.5)
    segments(xy$xx[miniedg[,1]], xy$yy[miniedg[,2]], xy$xx[miniedg[,1]], xy$yy[miniedg[,1]], lwd=1.5)
}

fun<-function(minimat) {
    if (length(which(apply(minimat,1,diff)==0))>0) return(NA)
    else return(sum(apply(minimat,1,diff)<0)!=1)
    #if true, stem length agree on the order
    #if false stem length disagree
    #if na, impossible to say because some values are equal.
}

DoSimul<-function(Ntotal, N, birth, death, ptransition,NbTransf,percmin,percmax, plot=TRUE) {
	tree<-rphylo(Ntotal, birth, death, fossils=TRUE)
	if (N!=0) tips<-sample(1:Ntotal, N)
	else {#we do the binary trait evolution; option not used in the manuscript
		m<-matrix(c(0,0,ptransition,0),2)
		trait<-rTraitDisc(tree, model = m, states=c(0,1))[1:Ntotal]
		tips<-which(trait==1)
	}
    plot(tree, plot=plot, show.tip.label=F, edge.color = "grey", edge.width=1.5) #once only
    xy<-get("last_plot.phylo", envir = .PlotPhyloEnv)    
    ###SMALL FUNCTION TO PLOT extant LINEAGES IN BLACK
    if (plot) colorit(tree, tips,xy)  
    RES<-replicate(NbTransf, StemLengthSimulation(tree, xy, tips, percmin=percmin,percmax=percmax, plot=plot))
    index<-seq(1,NbTransf-1,by=2)
    KK<-sapply(index, function(i,mat) fun(RES[,i:(i+1)]), mat=RES)
    return(RES)
}



#######################################
## PERFORM SIMULATIONS FOR THE PAPER ##
#######################################


NB<-100
nbsampled<-seq(100,10,by=-10)
RESU<-list()
DIFF<-list()
properror<-matrix(NA, nrow=100, ncol=length(nbsampled))
for (K in 1:100) {
    print(K)
    RESU[[K]]<-list()
    DIFF[[K]]<-list()
    for (i in 1:length(nbsampled)) {
        O<-replicate(NB, DoSimul(1000,nbsampled[i],1,0,0.005,2,0,1, plot=FALSE))
        resu<-sapply(1:NB, function(i,m) fun(m[,,i]),m=O)
        RESU[[K]][[i]]<-resu
        differ<-sapply(1:NB, function(i,m) abs(diff(m[,,i][1,])),m=O)
        DIFF[[K]][[i]]<-differ
    }
}



##################################
## PREPARE DATA FOR MAIN FIGURE ##
##################################

percsampled<-paste((nbsampled/1000)*100, "%", sep="")

TAB1<-do.call(rbind, lapply(RESU, function(x) unlist(lapply(x, function(y) sum(y, na.rm=T)))))
df1<-data.frame(prop=rep(percsampled, each=100), err=array(TAB1), type="correct-pred")

TAB2<-do.call(rbind, lapply(RESU, function(x) unlist(lapply(x, function(y) sum(!y, na.rm=T)))))
df2<-data.frame(prop=rep(percsampled, each=100), err=array(TAB2), type="erroneous-pred")

TAB3<-do.call(rbind, lapply(RESU, function(x) unlist(lapply(x, function(y) sum(is.na(y))))))
df3<-data.frame(prop=rep(percsampled, each=100), err=array(TAB3), type="no-pred")


DF<-rbind(df2,df1)

pdf("THEFIGURE.pdf")
ggplot(DF, aes(x=factor(prop,levels=percsampled), y=err, fill=type)) +  geom_boxplot()
dev.off()




#################################################################################
## PREPARE DATA FOR FIGURE ON THE EFFECT OF (RELATIVE) DISTANCE BETWEEN EVENTS ##
#################################################################################

resu10perc<-lapply(RESU, function(x) x[[1]])
diff10perc<-lapply(DIFF, function(x) x[[1]])
lim<-c(1,0.6,0.1)
TABCOR<-NULL
TABERR<-NULL
for (l in lim) {
     TF<-sapply(1:100, function(x,res,dif,lev) res[[x]][which(dif[[x]]<lev)], res=resu10perc, dif=diff10perc, lev=l, simplify=FALSE)
    TABCOR<-cbind(TABCOR, unlist(lapply(TF, function(x) sum(x, na.rm=T)/length(x))))
    TABERR<-cbind(TABERR, unlist(lapply(TF, function(x) sum(!x, na.rm=T)/length(x))))
}

dferr<-data.frame(prop=rep(lim, each=100), err=array(TABERR), type="erreneous-pred")
dfcor<-data.frame(prop=rep(lim, each=100), err=array(TABCOR), type="correct-pred")
ddff<-rbind(dferr, dfcor)
pdf("EFFECT-TIME-INTERVAL.pdf")
ggplot(ddff, aes(x=factor(prop, levels=lim), y=err, fill=type)) + geom_boxplot()
dev.off()

