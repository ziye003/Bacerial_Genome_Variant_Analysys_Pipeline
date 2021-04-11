#!/bin/bash -l
#SBATCH --time=39:00:00
#SBATCH --mem=50g
module load gatk
for f in *.sam;
do gatk MarkDuplicatesSpark -I $f -M ${f}_dedup_metrics.txt -O ${f}_dedup_reads.bam;
done


