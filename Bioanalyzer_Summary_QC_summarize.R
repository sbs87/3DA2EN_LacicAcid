rm(list=ls())
source("http://stevenbsmith.net/source/load_R_enviornment_vars.R")
setwd(paste("/Users/",user,"/bin/3DA2EN_LacicAcid",sep=""))
QC<-read.table("Bioanalyzer_Summary_QC.txt",sep="\t",header=F)
names(QC)<-c("sample_num","sample_name","rep","QC_code","QC_call")
table(data.frame(QC$sample_name,QC$QC_code))
hist(QC$QC_code)

postscript("Bioanalyzer_Summary_QC_plot.ps")
QC$sample_num_rep<-rep(1:14, times=2)
plot(QC$sample_num_rep,QC$QC_code)
abline(h=3,col='red')
abline(h=5,col='blue')
abline(h=7,col='violet')
abline(h=1,lty=3)
dev.off()
# 0=>"Bad",
# 1=>"Ok concentration", *
# 2=>"Ok RIN",
# 3=>"Ok concentration & RIN", **
# 4=>"Ok Ratio", 
# 5=>"Ok concentration & ratio", **
# 6=>"Good RIN & ratio", 
# 7=>"Good" **

## (1) 3, 5 or 7
QC$QC_call<-factor(QC$QC_call,levels=c("Bad","Ok concentration","Ok Ratio","Ok concentration & ratio","Good"),ordered=T)
QC$acid<-rep(c("D","D","L","L","DL","DL","HCL","HCL","Media","D","L","DL","HCL","Media"),times=2)
QC$chlamydia<-rep(c(rep("no_CT",times=9),rep("CT",times=5)),times=2)
QC$pH<-rep(c(rep(c(4,7),times=4),"media",rep(4,times=4),"media"),times=2)

library(ggplot2)
core<-ggplot(data=QC)+geom_bar(aes(x=QC_call))+theme_bw()
core+aes(fill=pH)+facet_wrap(~rep,ncol=1)
core+aes(fill=pH)
core+aes(fill=acid)
core+aes(fill=acid)+facet_wrap(~rep,ncol=1)
core+aes(fill=pH)+facet_wrap(acid~pH,nrow=5)

## Split by acid, CT and pH. Sub split by replicate. 
  ## by acid
core+aes(fill=pH)+facet_wrap(~ acid,ncol=1)
core+aes(fill=pH)+facet_wrap(acid~rep,ncol=2)  
## by CT
core+aes(fill=acid)+facet_wrap(~ chlamydia,ncol=1)
core+aes(fill=acid)+facet_wrap(chlamydia~rep,ncol=2)
  ## by pH
core+facet_wrap(~ pH,ncol=1)