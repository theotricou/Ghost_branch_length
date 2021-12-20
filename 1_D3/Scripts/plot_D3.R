##################
## READ DATASET ##
##################


require(ggplot2)
d<-read.table('data_D3.txt',h=T)
d$EV<-as.factor(paste(d$Donor,d$Recip, sep=""))
d<-d[which(abs(d$Z_score) >= 3),]

D3_error_by_param<-function(datta,thres){
  data<-datta[which(datta$R2<=thres),]
  D3_H0<-length(which(data$EV %in% c('P3P1','P3P2','P1P3','P2P3')))
  D3_H1<-length(which(data$EV %in% c('OP1','OP2')))
  D3_err<-D3_H1/(D3_H0+D3_H1)
  return(c('err'=D3_err, "R"=nrow(data), "thres"=thres))
}

d$R2<-(d$ext+d$uns+d$ali)/d$allsp
step=0.1
xaxix=seq(0+step,1,step)
aa=as.data.frame(do.call('rbind',lapply(xaxix,function(x) D3_error_by_param(d,x))))


##################
## PLOT RESULTS ##
##################

step<-0.2
ranges<-cbind(seq(0,1-step,by=step), seq(step,1,by=step))
aa2<-data.frame(t(apply(ranges, 1, function(x) D3_error_by_param(d[which(d$R2>x[1]&d$R2<=x[2]),], 1000))))
df<-data.frame(range=rev(apply(ranges, 1, paste,collapse="-")), properror=rev(aa2$err))

pdf("fig-D3-final.pdf",height=3.2)
ggplot(df, aes(x=range, y=properror)) + geom_bar(stat="identity", fill="#7570b3", color="black") + coord_flip() + labs(x="Relative size of the ingroup", y="Proportion of the significant D3 attributable to ghost introgressions")
dev.off()