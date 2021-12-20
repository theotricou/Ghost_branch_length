######################################
## PLOT RESULTS FOR ANOPHELES STUDY ##
######################################

### PLOTTING FUNCTION

PlotCompareSPtopoALTtopo<-function(filename) {

	data<-read.table(filename, header=TRUE)

	sptopo<-data[data$Topology=="ABC",]
	othertopo<-data[data$Topology!="ABC",]

	sptopoT1<-sptopo$T1
	sptopoT2<-sptopo$T2
	othertopoT1<-othertopo$T1
	othertopoT2<-othertopo$T2

	stderr<-function(x) sqrt(var(x)/length(x))

	MEANS<-c(mean(sptopoT1), mean(othertopoT1),mean(sptopoT2), mean(othertopoT2))
	print(t.test(sptopoT1, othertopoT1))
	print(t.test(sptopoT2, othertopoT2))

	STDERR<-c(stderr(sptopoT1), stderr(othertopoT1),stderr(sptopoT2), stderr(othertopoT2))
	plot(MEANS, pch=23, cex=4, bg=c("black","#1b9e77"), ylab="height", xaxt="n", ylim=c(0,0.3), xlim=c(0.5,7), frame.plot=F)
	axis(1,at=c(1.5,3.5),labels=c("T1","T2"), tick=F)
	segments((1:4)+0.25,MEANS-STDERR/2,(1:4)+0.25,MEANS+STDERR/2)
	title(filename)
}


### FINAL PLOTS

pdf("Anopheles_results.pdf")

PlotCompareSPtopoALTtopo("ghost_int_final.txt") #ghost introg. from outside triplet
PlotCompareSPtopoALTtopo("ingroup_int_final.txt") #ingroup introg.

dev.off()
