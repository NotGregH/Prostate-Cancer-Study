#!/bin/bash
sra=$1

echo "#!/bin/bash

#PBS -l nodes=1:ppn=20,walltime=10:00:00,mem=180GB
#PBS -N STAR_$sra
#PBS -e localhost:/scratch/gah324/log/STAR/e_$sra
#PBS -o localhost:/scratch/gah324/log/STAR/o_$sra


module purge

cd /scratch/gah324/AppliedGenomics/Prostat_Project/Scripts

module load python/intel/2.7.6
module load star/intel/2.4

python Mass_Star.py -s $sra 

">run_STAR_$sra.sh

qsub run_STAR_$sra.sh








