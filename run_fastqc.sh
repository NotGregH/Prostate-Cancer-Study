#!/bin/bash
sra=$1

echo "#!/bin/bash

#PBS -l nodes=1:ppn=16,walltime=04:00:00,mem=50GB
#PBS -N Fastqc_$sra
#PBS -e localhost:/scratch/gah324/log/fastqc/e_$sra
#PBS -o localhost:/scratch/gah324/log/fastqc/o_$sra


module purge

cd /scratch/gah324/AppliedGenomics/Prostat_Project/SRAs/$sra

module load fastqc/0.11.2

mkdir QC_Reports

fastqc -t 16 -o QC_Reports fastq/*.fastq 

">fastqc_$sra.sh

qsub fastqc_$sra.sh








