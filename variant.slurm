#!/bin/bash -l
#SBATCH --time=39:00:00
#SBATCH --mem=50g
module load gatk

for f in *.vcf;
do
gatk SelectVariants -R ../0_index/Nissle_1917.fasta -V $f selectType INDEL -O /indel/${f}_raw_indels.vcf;
gatk SelectVariants -R ../0_index/Nissle_1917.fasta -V $f selectType SNP -O /snp/${f}_raw_snps.vcf;
done

