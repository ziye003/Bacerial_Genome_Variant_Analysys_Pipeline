#!/bin/bash -l
#SBATCH --time=39:00:00
#SBATCH --ntasks=6
#SBATCH --mem=50g
#SBATCH -p small

module load picard-tools
module load samtools
module load gatk/3.7.0
module load bwa
module load bedtools


bwa mem -M -R '@RG\tID:D0_S1_L001\tLB: D0_S1_L001\tPL:ILLUMINA\tPM:MINISEQ\tSM:D0_S1_L001' Nissle1917.fa.fasta D41_S2_L001_R2_001.fastq D41_S2_L001_R2_001.fastq > aligned_reads3.sam


$PTOOL/picard.jar SortSam INPUT= aligned_reads3.sam OUTPUT=sorted_reads3.bam SORT_ORDER=coordinate

$PTOOL/picard.jar CollectAlignmentSummaryMetrics R=Nissle1917.fa.fasta I= sorted_reads3.bam O=alignment_metrics3.txt
$PTOOL/picard.jar CollectInsertSizeMetrics INPUT=sorted_reads3.bam OUTPUT=insert_metrics3.txt HISTOGRAM_FILE=insert_size_histogram3.pdf 
samtools depth -a sorted_reads3.bam > depth_out3.txt

$PTOOL/picard.jar MarkDuplicates INPUT=sorted_reads3.bam OUTPUT=dedup_reads3.bam METRICS_FILE=metrics3.txt

$PTOOL/picard.jar BuildBamIndex INPUT= dedup_reads3.bam

gatk -T RealignerTargetCreator -R Nissle1917.fa.fasta -I dedup_reads3.bam -o realignment_targets3.list

gatk -T IndelRealigner -R Nissle1917.fa.fasta -I dedup_reads3.bam -targetIntervals realignment_targets3.list -o realigned_reads3.bam

gatk -T HaplotypeCaller -R Nissle1917.fa.fasta -I realigned_reads3.bam -o raw_variants3.vcf

gatk -T SelectVariants -R Nissle1917.fa.fasta -V raw_variants3.vcf -selectType SNP -o raw_snps3.vcf
gatk -T SelectVariants -R Nissle1917.fa.fasta -V raw_variants3.vcf -selectType INDEL -o raw_indels3.vcf

