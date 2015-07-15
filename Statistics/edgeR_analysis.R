## edgeR or DESeq2, GO stats, and GAGE analysis of ht-seq count results


#### Set upt ####
## Packages ##

library('BiocInstaller')
biocLite('BiocUpgrade')
biocLite('gage')
biocLite('DESeq2')

library('DESeq2')

## Data ## 
# Get all the count data into tables 
# combine the count data into a super table

BM_66 <- read.table('../Data/Bone/SRP007881/counts/66.count.txt')
BM_67 <- read.table('../Data/Bone/SRP007881/counts/67.count.txt')
BM_68 <- read.table('../Data/Bone/SRP007881/counts/68.count.txt')
BM_69 <- read.table('../Data/Bone/SRP007881/counts/69.count.txt')
BM_70 <- read.table('../Data/Bone/SRP007881/counts/70.count.txt')
BM_71 <- read.table('../Data/Bone/SRP007881/counts/71.count.txt')
BM_72 <- read.table('../Data/Bone/SRP007881/counts/72.count.txt')
BM_73 <- read.table('../Data/Bone/SRP007881/counts/73.count.txt')

BM_51 <- read.table('../Data/Bone/SRP029603/counts/51.count.txt')
BM_52 <- read.table('../Data/Bone/SRP029603/counts/52.count.txt')
BM_53 <- read.table('../Data/Bone/SRP029603/counts/53.count.txt')
BM_54 <- read.table('../Data/Bone/SRP029603/counts/54.count.txt')
BM_55 <- read.table('../Data/Bone/SRP029603/counts/55.count.txt')
BM_56 <- read.table('../Data/Bone/SRP029603/counts/56.count.txt')
BM_57 <- read.table('../Data/Bone/SRP029603/counts/57.count.txt')
BM_58 <- read.table('../Data/Bone/SRP029603/counts/58.count.txt')

T3_790 <- read.table('../Data/Primary/SRP036848/counts/T3/790.count.txt')
T3_801 <- read.table('../Data/Primary/SRP036848/counts/T3/801.count.txt')
T3_803 <- read.table('../Data/Primary/SRP036848/counts/T3/803.count.txt')
T3_817 <- read.table('../Data/Primary/SRP036848/counts/T3/817.count.txt')
T3_818 <- read.table('../Data/Primary/SRP036848/counts/T3/818.count.txt')
T3_858 <- read.table('../Data/Primary/SRP036848/counts/T3/858.count.txt')
T3_863 <- read.table('../Data/Primary/SRP036848/counts/T3/863.count.txt')
T3_864 <- read.table('../Data/Primary/SRP036848/counts/T3/864.count.txt')
T3_867 <- read.table('../Data/Primary/SRP036848/counts/T3/867.count.txt')
T3_872 <- read.table('../Data/Primary/SRP036848/counts/T3/872.count.txt')
T3_875 <- read.table('../Data/Primary/SRP036848/counts/T3/875.count.txt')
T3_876 <- read.table('../Data/Primary/SRP036848/counts/T3/876.count.txt')
T3_877 <- read.table('../Data/Primary/SRP036848/counts/T3/877.count.txt')
T3_878 <- read.table('../Data/Primary/SRP036848/counts/T3/878.count.txt')
T3_879 <- read.table('../Data/Primary/SRP036848/counts/T3/879.count.txt')
T3_892 <- read.table('../Data/Primary/SRP036848/counts/T3/892.count.txt')


T2_798 <- read.table('../Data/Primary/SRP036848/counts/T2/798.count.txt')
T2_805 <- read.table('../Data/Primary/SRP036848/counts/T2/805.count.txt')
T2_806 <- read.table('../Data/Primary/SRP036848/counts/T2/806.count.txt')
T2_807 <- read.table('../Data/Primary/SRP036848/counts/T2/807.count.txt')
T2_808 <- read.table('../Data/Primary/SRP036848/counts/T2/808.count.txt')
T2_809 <- read.table('../Data/Primary/SRP036848/counts/T2/809.count.txt')
T2_811 <- read.table('../Data/Primary/SRP036848/counts/T2/811.count.txt')
T2_815 <- read.table('../Data/Primary/SRP036848/counts/T2/815.count.txt')
T2_816 <- read.table('../Data/Primary/SRP036848/counts/T2/816.count.txt')
T2_819 <- read.table('../Data/Primary/SRP036848/counts/T2/819.count.txt')
T2_820 <- read.table('../Data/Primary/SRP036848/counts/T2/820.count.txt')
T2_824 <- read.table('../Data/Primary/SRP036848/counts/T2/824.count.txt')
T2_825 <- read.table('../Data/Primary/SRP036848/counts/T2/825.count.txt')
T2_827 <- read.table('../Data/Primary/SRP036848/counts/T2/827.count.txt')
T2_829 <- read.table('../Data/Primary/SRP036848/counts/T2/829.count.txt')
T2_800 <- read.table('../Data/Primary/SRP036848/counts/T2/800.count.txt')


Counts.table <- cbind(BM_51,BM_52,BM_53,BM_54,BM_55,BM_56,BM_57,BM_58,
                      BM_66,BM_67,BM_68,BM_69,BM_70,BM_71,BM_72,BM_73,
                      T2_798,T2_800,T2_805,T2_806,T2_807,T2_808,T2_809,T2_811,
                      T2_815,T2_816,T2_819,T2_820,T2_824,T2_825,T2_827,T2_829,
                      T3_790,T3_801,T3_803,T3_817,T3_818,T3_858,T3_863,T3_864,
                      T3_867,T3_872,T3_875,T3_876,T3_877,T3_878,T3_879,T3_892)

colnames(Counts.table)<-c('BM_51','BM_52','BM_53','BM_54','BM_55','BM_56','BM_57','BM_58',
                          'BM_66','BM_67','BM_68','BM_69','BM_70','BM_71','BM_72','BM_73',
                          'T2_798','T2_800','T2_805','T2_806','T2_807','T2_808','T2_809','T2_811',
                          'T2_815','T2_816','T2_819','T2_820','T2_824','T2_825','T2_827','T2_829',
                          'T3_790','T3_801','T3_803','T3_817','T3_818','T3_858','T3_863','T3_864',
                          'T3_867','T3_872','T3_875','T3_876','T3_877','T3_878','T3_879','T3_892')



stages <- c("BM","BM","BM","BM","BM","BM","BM","BM","BM","BM","BM","BM","BM","BM","BM","BM",
            "T3","T3","T3","T3","T3","T3","T3","T3","T3","T3","T3","T3","T3","T3","T3","T3",
            "T2","T2","T2","T2","T2","T2","T2","T2","T2","T2","T2","T2","T2","T2","T2","T2")






