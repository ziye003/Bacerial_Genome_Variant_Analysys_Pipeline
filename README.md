# Bacerial_Genome_Variant_Analysys_Pipeline

Variant calling analysis of bacterial genomce on slurm / linux shell


Full List of Tools Used in this Pipeline:
GATK  (GATK 3.7.0 is used in this pipeline)
BWA
Picard 
Samtools
Bedtools
R (dependency for some GATK and Picard steps)

 1. Creating the FASTA sequence dictionary file, .dict, and the fasta index file,.fai.
 2. Read .fastq files
 3. bwa mem align to genome
 4. Mark duplicates
 5. Build .bam index
 6. Create realignment targets
 7. Realign around indels
 8. Produce variant calling .vcf files
 9. Extract and filter indel and SNP.vcf files
