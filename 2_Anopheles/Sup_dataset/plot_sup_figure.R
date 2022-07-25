
pdf("theplots.pdf")

ploter <- function(data){
	RES <- as.data.frame(do.call('rbind', by(data, data$topology, function(x){
		Mean_T1 = mean(x$T1)
		Mean_T2 = mean(x$T2)

		Err_T1 = sd(x$T1)/sqrt(nrow(x))
		Err_T2 = sd(x$T2)/sqrt(nrow(x))
		return(c(topo = x$topology[1], T1 = Mean_T1, T2 = Mean_T2, ERR_T1 = Err_T1, ERR_T2 = Err_T2))
		})
	))

	RES = RES[match(RES$topo, c("ABC", "BCA", "ACB")),]
	plot(c(RES$T1, RES$T2), ylim=c(0,130), pch=23, cex=2)
	err_plus = as.numeric(c(RES$T1, RES$T2))+as.numeric(c(RES$ERR_T1, RES$ERR_T2))/2
	err_minus = as.numeric(c(RES$T1, RES$T2))-as.numeric(c(RES$ERR_T1, RES$ERR_T2))/2
	segments((1:6)+0.1,err_minus, (1:6)+0.1, err_plus, col="red")
}



data_extant <- read.table("T1T2_extant", h = T)
ploter(data_extant)

data_back <- read.table("T1T2_background_extinction", h = T)
ploter(data_back)

dev.off()



##COMPUTE SIGNIFICANCE:
##WITH extinction

# for T1
ABC_t1 <- data_back[data_back$topology = "ABC", "T1"]
BCA_t1 <- data_back[data_back$topology = "BCA", "T1"]
ACB_t1 <- data_back[data_back$topology = "ACB", "T1"]

#we test the larger to the two others:
t.test(BCA_t1, ABC_t1, "greater")
t.test(BCA_t1, ACB_t1, "greater")
t.test(ABC_t1, ACB_t1, "greater")

# for T2
ABC_t2 <- data_back[data_back$topology = "ABC", "T2"]
BCA_t2 <- data_back[data_back$topology = "BCA", "T2"]
ACB_t2 <- data_back[data_back$topology = "ACB", "T2"]

#we test the larger to the two others:
t.test(BCA_t2, ABC_t2, "greater")
t.test(BCA_t2, ACB_t2, "greater")
t.test(ABC_t2, ACB_t2, "greater")

##WITHOUT extinction

# for T1
ABC_t1 <- data_extant[data_extant$topology = "ABC", "T1"]
BCA_t1 <- data_extant[data_extant$topology = "BCA", "T1"]
ACB_t1 <- data_extant[data_extant$topology = "ACB", "T1"]

#we test the larger to the two others:
t.test(BCA_t1, ABC_t1, "greater")
t.test(BCA_t1, ACB_t1, "greater")
t.test(ABC_t1, ACB_t1, "greater")

# for T2
ABC_t2 <- data_extant[data_extant$topology = "ABC", "T2"]
BCA_t2 <- data_extant[data_extant$topology = "BCA", "T2"]
ACB_t2 <- data_extant[data_extant$topology = "ACB", "T2"]

#we test the larger to the two others:
t.test(BCA_t2, ABC_t2, "greater")
t.test(BCA_t2, ACB_t2, "greater")
t.test(ABC_t2, ACB_t2, "greater")

