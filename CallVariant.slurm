#!/bin/bash -l
#!/bin/bash -l
#SBATCH --time=39:00:00
#SBATCH --mem=50g
module load gatk
for f in *.bam;
do
gatk HaplotypeCaller -R ../0_index/Nissle_1917.fasta -I $f -O ${f}_raw_variants.vcf;
done

