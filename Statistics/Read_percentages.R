## Mapped Read Percentage data - for figure 1
#  The point is to show STAR worked as well as if not better than Tophat in the published papers

#### Set Up ####
# Goal - Get all read names and percentages into tables 
# This includes published percentages and My STAR percentages

## T3 ##
T3_names <- c('790','801','803','817','818','858','863','864','867','872','875','876','877','878','879','892')
length(T3_names)
Published_percetages_T3 <- c(67,70.5,69.1,72.5,64.1,55.1,63.99,64.4,49.8,77.2,74.6,63.7,72.7,61.8,47.6,81.4)
length(Published_percetages_T3)
T3.publ.mu <- mean(Published_percetages_T3)

Star_percentages_T3 <- c(88.81,93.76,93.32,92.72,92.92,84.01,88.21,93.94,93.78,95.48,94.35,88.91,92.32,94.09,95.13,99.64)
length(Star_percentages_T3)
T3.star.mu <- mean(Star_percentages_T3)


STAR_compare.T3.df <- data.frame(Star_percentages_T3,Published_percetages_T3,row.names=T3_names) 

par(mfrow=c(1,1),mar=c(4,4,5,10)) # Setting up plot window for the below barplot

## Barplot seemed the best visual representation for comparing the accuracy of the two aligners

barplot(t(as.matrix(STAR_compare.T3.df)),beside=TRUE,ylim=c(0,100),
        ylab="Uniquely Mapped Read %",xlab="Read Id",col=c("black","grey"))


## T2 ##

T2_names <- c('798','800','805','806','807','808','809','811','815','816','819','820','824','825','827','829')
Publ_percentages_T2 <- c(72.9,66.4,77,72,49.7,62.9,79.9,46.9,70.6,69.9,19.6,59.9,14.9,66.6,51.2,55)
T2.pub.mu <- mean(Publ_percentages_T2)

Star_percentages_T2 <-read.table('../Data/Primary/SRP036848/T2_log.csv')
Star_percentages_T2 <- Star_percentages_T2$V2
Star_percentages_T2 <- c(94.88,91.19,92.92,92.77,92.28,91.58,95.75,96.01,94.04,92.04,93.50,91.91,93.42,90.71,88.83,94.67)
T2.star.mu <- mean(Star_percentages_T2)

par(mfrow=c(1,1),mar=c(4,4,5,10))
STAR_compare.T2.df <- data.frame(Star_percentages_T2,Publ_percentages_T2,row.names=T2_names)
STAR_compare.T2.df

par(mfrow=c(1,1),mar=c(4,4,5,10))
barplot(t(as.matrix(STAR_compare.T2.df)),beside=TRUE,ylim=c(0,100),
        ylab="Uniquely Mapped Read %",xlab="Read Id",col=c("black","grey"))

## T1 ## Not enough samples - keep for later

Star_percentages_T1 <-c()
T1.star.mu <- mean(Star_percentages_T1)

STAR_compare.T1.df <- data.frame()

## BM ##

Star_percentages_BM <- read.table('../Data/Bone/SRP029603/SRP029603_align_percentages.csv')  
Star_percentages_BM.vec <- as.vector(Star_percentages_BM$V2)
Star_percentages_BM

Star_percentages_BM$V1
#[1] SRR969851 SRR969852 SRR969853 SRR969854 SRR969855 SRR969856 SRR969857 SRR969858


BM_Names <- c('851','852','853','854','855','856','857','858')

BM.star.mu <- mean(Star_percentages_BM.vec)

BM.star.df <- data.frame(Star_percentages_BM.vec,row.names=BM_Names)

BM.star.df
par(mfrow=c(1,1),mar=c(4,4,5,10))

barplot(t(as.matrix(BM.star.df)),beside=TRUE,ylim=c(0,100),
        ylab="Uniquely Mapped Read %",xlab="Read Id",col=c("black"))


## All ##

## Comparison of the mean values for all mapped percentages

Star_Compare.All.df <- data.frame(T2.star.mu,T3.star.mu,BM.star.mu,T2.pub.mu,T3.publ.mu)
colnames(Star_Compare.All.df) <- c('T2','T3','BM','Pub T2','Pub T3')
Star_Compare.All.df

par(mfrow=c(1,1),mar=c(4,4,5,5))

barplot((as.matrix(Star_Compare.All.df)),beside=TRUE,ylim=c(0,100),
        ylab="Uniquely Mapped Read %",col=c("Black","Black","Black","Grey","Grey"))

