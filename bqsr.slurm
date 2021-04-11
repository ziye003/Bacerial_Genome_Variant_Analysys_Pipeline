#!/bin/bash -l
#SBATCH --time=39:00:00
#SBATCH --mem=50g
module load gatk
for f in *.bam;
do
gatk ApplyBQSR \
        -R ../0_index/Nissle_1917.fasta\
        -I $f\
        -bqsr ${f}_recal_data.table \
        -O ${f}_recal_reads.bam;

gatk AnalyzeCovariates \        
       -before ${f}_recal_data.table \
        -after ${f}_post_recal_data.table \
        -plots ${f}_recalibration_plots.pdf

done

