setwd("/Users/stevensmith/Desktop")
QC<-read.table("Bioanalyzer_Summary_QC.txt",sep="\t",header=F)
names(QC)<-c("sample_num","sample_name","rep","QC_code","QC_call")
?table
table(data.frame(QC$sample_name,QC$QC_code))
hist()

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