#!/bin/bash

# the line below takes the word right after the command name and assigns
# it to SRRNAME. Now I don't have to create a separate script for each SRA file
SRRNAME=$1
D=$2
d2=$3

echo "#!/bin/bash

#PBS -l nodes=1:ppn=1,walltime=18:00:00,mem=400GB
#PBS -N sras
#PBS -M $USER@nyu.edu
#PBS -m e
#PBS -e localhost:/scratch/$USER/error_$SRRNAME
#PBS -o localhost:/scratch/$USER/output_$SRRNAME



cd /scratch/$USER/AppliedGenomics/Prostat_Project/SRAs/$SRRNAME


wget -r -nd -nH ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/$D/$d2/$SRRNAME


">getSRA_run_$SRRNAME.sh

qsub getSRA_run_$SRRNAME.sh

