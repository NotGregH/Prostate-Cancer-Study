#!/bin/bash
NAME=$1

echo "#!/bin/bash

#PBS -l nodes=1:ppn=20,walltime=12:00:00,mem=100GB
#PBS -N SRA_Conversion
#PBS -M gah324@nyu.edu
#PBS -m e
#PBS -e localhost:/scratch/gah324/log/e_Conversion_$NAME
#PBS -o localhost:/scratch/gah324/log/o_Conversion_$NAME


module purge

cd /scratch/gah324/AppliedGenomics/Prostat_Project/SRAs/$NAME

module load sratoolkit/2.4.4

fastq-dump --split-3 -R pass -O fastq3 *.sra

">SRA_conversion_$NAME.sh

qsub SRA_conversion_$NAME.sh





