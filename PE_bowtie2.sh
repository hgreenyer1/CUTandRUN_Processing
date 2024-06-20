#!/bin/bash
#simple script to run bowtie2 for alignment
#SBATCH --nodes=1                               # Request one core
#SBATCH --ntasks-per-node=1                     # Request one node (if you request more than one core with -n, also using
#SBATCH --cpus-per-task=8                       # -N 1 means all cores will be on the same node)
#SBATCH -t 1-06:00                              # Runtime in D-HH:MM format
#SBATCH -p bluemoon                             # Partition to run in
#SBATCH --mem=32000                             # Memory total in MB (for all cores)
#SBATCH -o bowtie2_pe_%j.out                    # File to which STDOUT will be written, including job ID
#SBATCH -e bowtie2_pe_%j.err                    # File to which STDERR will be written, including job ID
#SBATCH --mail-user=hgreenye@med.uvm.edu        # Email to which notifications will be sent

#no frills ... just runs bowtie2
#requires: a bowtie2 index (-x) (download at http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml) or create your own (look it up)
#requires: at least 1 fastq file (SE) or 2 paired fastqs (PE)

# define variables: change these later
index="/users/j/a/jargordo/scratch/indexes/HG38/BOWTIE_INDEX/GRCh38_noalt_as/GRCh38_noalt_as"

FASTQ=$1
NAME=$( echo $FASTQ | awk -F"/" '{print $NF}' | awk -F".fq" '{print $1}')
SAM=${NAME}.sam
BAM=${NAME}.bam
SBAM=${NAME}_sorted.bam


bowtie2 --dovetail -p 8 -x $index -1 $1 -2 $2 -S ${SAM}

samtools view -bS ${SAM} > ${BAM}
samtools sort ${BAM} -o ${SBAM}
samtools index ${SBAM}

# paired end simple alignment

echo "done!"



